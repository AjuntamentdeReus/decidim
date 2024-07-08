# frozen_string_literal: true

require "census_client"
require "custom_attribute_obfuscator"

class CensusAuthorizationHandler < Decidim::AuthorizationHandler

  include Decidim::HumanizeBooleansHelper

  TELEPHONE_NUMBER_REGEXP = /^\d{9,}$/
  NORMALIZE_TELEPHONE_REGEXP = /\.|\ |\-|\_/

  attribute :document_number, String
  attribute :date_of_birth, Date
  attribute :official_name_custom, String
  attribute :telephone_number_custom, String

  validates :date_of_birth, presence: true
  validates :document_number, presence: true

  validates :official_name_custom, presence: true, length: { minimum: 3 }, if: ->(form) do
    form.user.official_name_custom.blank? && !form.user.managed
  end
  validates :telephone_number_custom, presence: true, if: ->(form) do
    form.user.telephone_number_custom.blank? && !form.user.managed
  end
  validate :telephone_number_custom_format, unless: ->(form) { form.user.managed }

  validate :user_exists_in_census # must be declared as the last validation so custom
                                  # fields are not saved unless census call succeeds

  def self.from_params(params, additional_params = {})
    instance = super(params, additional_params)

    params_hash = hash_from(params)

    if params_hash["date_of_birth(1i)"]
      date = Date.civil(
        params["date_of_birth(1i)"].to_i,
        params["date_of_birth(2i)"].to_i,
        params["date_of_birth(3i)"].to_i
      )

      instance.date_of_birth = date
    end

    instance
  end

  def unique_id
    self.class.build_unique_id(document_number, date_of_birth)
  end

  private

  def user_exists_in_census
    @census_response = CensusClient.make_request(document_number, self.class.format_birthdate(date_of_birth))

    if !@census_response.registered_in_census?
      errors.add(:base, @census_response.message)
    elsif [telephone_number_custom, official_name_custom].any?(&:present?) && errors.empty?
      user.telephone_number_custom = telephone_number_custom if telephone_number_custom.present?
      user.official_name_custom = official_name_custom if official_name_custom.present?
      user.save!
    end
  end

  def telephone_number_custom_format
    return unless user.telephone_number_custom.blank?

    self.telephone_number_custom = telephone_number_custom.to_s.gsub(NORMALIZE_TELEPHONE_REGEXP, "")

    unless TELEPHONE_NUMBER_REGEXP =~ telephone_number_custom
      errors.add(:telephone_number_custom, I18n.t("custom_errors.telephone_format"))
    end
  end

  def log_success_entry_extras
    {
      email: CustomAttributeObfuscator.email(user.email),
      document_number: CustomAttributeObfuscator.document_number(document_number),
      managed_user: user.managed,
      census_code: @census_response.response_code,
      census_message: census_message
    }
  end

  def log_error_entry_extras
    {
      email: CustomAttributeObfuscator.email(user.email, false),
      document_number: CustomAttributeObfuscator.document_number(document_number, false),
      managed_user: user.managed,
      census_code: @census_response.response_code,
      census_message: census_message
    }
  end

  def self.build_unique_id(document_number, birth_date)
    Digest::MD5.hexdigest(
      "#{document_number}-#{format_birthdate(birth_date)}-#{Rails.application.secrets.secret_key_base}"
    )
  end

  def self.format_birthdate(date)
    date.strftime("%d/%m/%Y") if date.present?
  end

  def census_message
    if duplicate.blank?
      @census_response.message
    else
      other_user = duplicate.user

      """
      Està empadronat, però hi ha #{other_user.managed ? 'un compte administrat' : 'un altre usuari'} verificat amb les mateixes dades
      (nom: #{Decidim::RemovableAuthorizations::AttributeObfuscator.name_hint(other_user.name)}, email: #{CustomAttributeObfuscator.email(other_user.email)})
      """
    end
  end

end
