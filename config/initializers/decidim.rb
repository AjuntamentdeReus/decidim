# frozen_string_literal: true

Decidim.configure do |config|
  config.application_name = "Participa Reus"
  config.mailer_sender = Rails.application.secrets.mailer_sender

  config.available_locales = %i(ca es en)

  # Sets the default locale for new organizations. When creating a new
  # organization from the System area, system admins will be able to overwrite
  # this value for that specific organization.
  config.default_locale = Rails.application.secrets.decidim[:default_locale].presence || :ca

  # Restrict access to the system part with an authorized ip list.
  # You can use a single ip like ("1.2.3.4"), or an ip subnet like ("1.2.3.4/24")
  # You may specify multiple ip in an array ["1.2.3.4", "1.2.3.4/24"]
  config.system_accesslist_ips = Rails.application.secrets.decidim[:system_accesslist_ips] if Rails.application.secrets.decidim[:system_accesslist_ips].present?

  # Defines a list of custom content processors. They are used to parse and
  # render specific tags inside some user-provided content. Check the docs for
  # more info.
  # config.content_processors = []

  # Whether SSL should be enabled or not.
  # if this var is not defined, it is decided automatically per-rails-environment
  config.force_ssl = Rails.application.secrets.decidim[:force_ssl].present? unless Rails.application.secrets.decidim[:force_ssl] == "auto"
  # or set it up manually and prevent any ENV manipulation:
  # config.force_ssl = true

  # Enable the service worker. By default is disabled in development and enabled in the rest of environments
  config.service_worker_enabled = Rails.application.secrets.decidim[:service_worker_enabled].present?

  # Sets the list of static pages' slugs that can include content blocks.
  # By default is only enabled in the terms-of-service static page to allow a summary to be added and include
  # sections with a two-pane view
  config.page_blocks = Rails.application.secrets.decidim[:page_blocks].presence || %w(terms-of-service)

  # Geocoder configuration

  config.geocoder = {
    static_map_url: "https://image.maps.cit.api.here.com/mia/1.6/mapview",
    here_app_id: Rails.application.secrets.geocoder[:here_app_id],
    here_app_code: Rails.application.secrets.geocoder[:here_app_code],
    here_api_key: Rails.application.secrets.geocoder[:here_api_key]
  }

  # Custom resource reference generator method
  # config.resource_reference_generator = lambda do |resource, feature|
  #   # Implement your custom method to generate resources references
  #   "1234-#{resource.id}"
  # end

  # Currency unit
  config.currency_unit = Rails.application.secrets.decidim[:currency_unit] if Rails.application.secrets.decidim[:currency_unit].present?

  # Workaround to enable SVG assets cors
  config.cors_enabled = Rails.application.secrets.decidim[:cors_enabled].present?

  # Defines the quality of image uploads after processing. Image uploads are
  # processed by Decidim, this value helps reduce the size of the files.
  config.image_uploader_quality = Rails.application.secrets.decidim[:image_uploader_quality].to_i

  config.maximum_attachment_size = Rails.application.secrets.decidim[:maximum_attachment_size].to_i.megabytes
  config.maximum_avatar_size = Rails.application.secrets.decidim[:maximum_avatar_size].to_i.megabytes

  # The number of reports which a resource can receive before hiding it
  config.max_reports_before_hiding = Rails.application.secrets.decidim[:max_reports_before_hiding].to_i

  # Custom HTML Header snippets
  #
  # The most common use is to integrate third-party services that require some
  # extra JavaScript or CSS. Also, you can use it to add extra meta tags to the
  # HTML. Note that this will only be rendered in public pages, not in the admin
  # section.
  #
  # Before enabling this you should ensure that any tracking that might be done
  # is in accordance with the rules and regulations that apply to your
  # environment and usage scenarios. This feature also comes with the risk
  # that an organization's administrator injects malicious scripts to spy on or
  # take over user accounts.
  #
  config.enable_html_header_snippets = true

  # Allow organizations admins to track newsletter links.
  config.track_newsletter_links = Rails.application.secrets.decidim[:track_newsletter_links].present? unless Rails.application.secrets.decidim[:track_newsletter_links] == "auto"

  # Amount of time that the download your data files will be available in the server.
  config.download_your_data_expiry_time = Rails.application.secrets.decidim[:download_your_data_expiry_time].to_i.days

  # Max requests in a time period to prevent DoS attacks. Only applied on production.
  config.throttling_max_requests = Rails.application.secrets.decidim[:throttling_max_requests].to_i

  # Time window in which the throttling is applied.
  config.throttling_period = Rails.application.secrets.decidim[:throttling_period].to_i.minutes

  # Time window were users can access the website even if their email is not confirmed.
  config.unconfirmed_access_for = Rails.application.secrets.decidim[:unconfirmed_access_for].to_i.days

  # A base path for the uploads. If set, make sure it ends in a slash.
  # Uploads will be set to `<base_path>/uploads/`. This can be useful if you
  # want to use the same uploads place for both staging and production
  # environments, but in different folders.
  #
  # If not set, it will be ignored.
  config.base_uploads_path = Rails.application.secrets.decidim[:base_uploads_path] if Rails.application.secrets.decidim[:base_uploads_path].present?

  # Sets Decidim::Exporters::CSV's default column separator
  config.default_csv_col_sep = Rails.application.secrets.decidim[:default_csv_col_sep] if Rails.application.secrets.decidim[:default_csv_col_sep].present?

  # The list of roles a user can have, not considering the space-specific roles.
  # config.user_roles = %w(admin user_manager)

  # The list of visibility options for amendments. An Array of Strings that
  # serve both as locale keys and values to construct the input collection in
  # Decidim::Amendment::VisibilityStepSetting::options.
  #
  # This collection is used in Decidim::Admin::SettingsHelper to generate a
  # radio buttons collection input field form for a Decidim::Component
  # step setting :amendments_visibility.
  # config.amendments_visibility_options = %w(all participants)

  # Defines the social networking services used for social sharing
  config.social_share_services = Rails.application.secrets.decidim[:social_share_services]

  # Defines the name of the cookie used to check if the user allows Decidim to
  # set cookies.
  config.consent_cookie_name = Rails.application.secrets.decidim[:consent_cookie_name] if Rails.application.secrets.decidim[:consent_cookie_name].present?

  # Defines data consent categories and the data stored in each category.
  # config.consent_categories = [
  #   {
  #     slug: "essential",
  #     mandatory: true,
  #     items: [
  #       {
  #         type: "cookie",
  #         name: "_session_id"
  #       },
  #       {
  #         type: "cookie",
  #         name: Decidim.consent_cookie_name
  #       }
  #     ]
  #   },
  #   {
  #     slug: "preferences",
  #     mandatory: false
  #   },
  #   {
  #     slug: "analytics",
  #     mandatory: false
  #   },
  #   {
  #     slug: "marketing",
  #     mandatory: false
  #   }
  # ]

  # Defines additional content security policies following the structure
  # Read more: https://docs.decidim.org/en/develop/configure/initializer#_content_security_policy
  config.content_security_policies_extra = {
    "default-src" => %w('self' 'unsafe-inline'),
    "script-src" => %w('self' 'unsafe-inline' 'unsafe-eval'),
    "style-src" => %w('self' 'unsafe-inline' fonts.googleapis.com maxcdn.bootstrapcdn.com),
    "img-src" => %w('self' *.hereapi.com data: *.amazonaws.com),
    "font-src" => %w('self' fonts.gstatic.com maxcdn.bootstrapcdn.com),
    "connect-src" => %w('self' *.hereapi.com *.jsdelivr.net *.amazonaws.com fonts.googleapis.com maxcdn.bootstrapcdn.com),
    "frame-src" => %w('self' *.youtube.com),
    "media-src" => %w('self')
  }

  # Admin admin password configurations
  Rails.application.secrets.dig(:decidim, :admin_password, :strong).tap do |strong_pw|
    # When the strong password is not configured, default to true
    config.admin_password_strong = strong_pw.nil? ? true : strong_pw.present?
  end
  config.admin_password_expiration_days = Rails.application.secrets.dig(:decidim, :admin_password, :expiration_days).presence || 90
  config.admin_password_min_length = Rails.application.secrets.dig(:decidim, :admin_password, :min_length).presence || 15
  config.admin_password_repetition_times = Rails.application.secrets.dig(:decidim, :admin_password, :repetition_times).presence || 5

  # Additional optional configurations (see decidim-core/lib/decidim/core.rb)
  config.cache_key_separator = Rails.application.secrets.decidim[:cache_key_separator] if Rails.application.secrets.decidim[:cache_key_separator].present?
  config.expire_session_after = Rails.application.secrets.decidim[:expire_session_after].to_i.minutes if Rails.application.secrets.decidim[:expire_session_after].present?
  config.enable_remember_me = Rails.application.secrets.decidim[:enable_remember_me].present? unless Rails.application.secrets.decidim[:enable_remember_me] == "auto"
  if Rails.application.secrets.decidim[:session_timeout_interval].present?
    config.session_timeout_interval = Rails.application.secrets.decidim[:session_timeout_interval].to_i.seconds
  end
  config.follow_http_x_forwarded_host = Rails.application.secrets.decidim[:follow_http_x_forwarded_host].present?
  config.maximum_conversation_message_length = Rails.application.secrets.decidim[:maximum_conversation_message_length].to_i
  config.password_similarity_length = Rails.application.secrets.decidim[:password_similarity_length] if Rails.application.secrets.decidim[:password_similarity_length].present?
  config.denied_passwords = Rails.application.secrets.decidim[:denied_passwords] if Rails.application.secrets.decidim[:denied_passwords].present?
  config.allow_open_redirects = Rails.application.secrets.decidim[:allow_open_redirects] if Rails.application.secrets.decidim[:allow_open_redirects].present?
end

Decidim::Verifications.register_workflow(:census_authorization_handler) do |auth|
  auth.form = "CensusAuthorizationHandler"
end

TELEPHONE_NUMBER_REGEXP = /^\d{9,}$/
NORMALIZE_TELEPHONE_REGEXP = /\.|\ |\-|\_/

Rails.application.reloader.to_prepare do
  ::Decidim::RegistrationForm.class_eval do
    attribute :official_name_custom, String
    attribute :telephone_number_custom, String

    validates :official_name_custom, presence: true, length: { minimum: 3 }
    validates :telephone_number_custom, presence: true
    validate :telephone_number_custom_format

    def telephone_number_custom_format
      self.telephone_number_custom = telephone_number_custom.gsub(NORMALIZE_TELEPHONE_REGEXP, "")

      unless TELEPHONE_NUMBER_REGEXP =~ telephone_number_custom
        errors.add(:telephone_number_custom, I18n.t("custom_errors.telephone_format"))
      end
    end
  end

  ::Decidim::AccountForm.class_eval do
    attribute :official_name_custom, String
    attribute :telephone_number_custom, String

    validates :official_name_custom, presence: true, length: { minimum: 3 }, if: ->(form) do
      form.current_user.official_name_custom.present?
    end
    validates :telephone_number_custom, presence: true, if: ->(form) do
      form.current_user.telephone_number_custom.present?
    end

    validate :telephone_number_custom_format

    private

    def telephone_number_custom_format
      return unless telephone_number_custom.present?

      self.telephone_number_custom = telephone_number_custom.gsub(NORMALIZE_TELEPHONE_REGEXP, "")

      unless TELEPHONE_NUMBER_REGEXP =~ telephone_number_custom
        errors.add(:telephone_number_custom, I18n.t("custom_errors.telephone_format"))
      end
    end
  end

  ::Decidim::CreateRegistration.class_eval do

    private

    def create_user
      @user = ::Decidim::User.create!(
        # defined by Decidim
        email: form.email,
        name: form.name,
        nickname: form.nickname,
        password: form.password,
        password_confirmation: form.password_confirmation,
        organization: form.current_organization,
        tos_agreement: form.tos_agreement,
        newsletter_notifications_at: form.newsletter_at,
        email_on_notification: true,
        accepted_tos_version: form.current_organization.tos_version,
        # custom
        official_name_custom: form.official_name_custom,
        telephone_number_custom: form.telephone_number_custom
      )
    end
  end

  ::Decidim::UpdateAccount.class_eval do

    private

    def update_personal_data
      # defined by Decidim
      @user.name = @form.name
      @user.nickname = @form.nickname
      @user.email = @form.email
      @user.personal_url = @form.personal_url
      @user.about = @form.about
      # custom
      @user.official_name_custom = @form.official_name_custom
      @user.telephone_number_custom = @form.telephone_number_custom
    end
  end
end
