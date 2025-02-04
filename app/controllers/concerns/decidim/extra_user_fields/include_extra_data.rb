# frozen_string_literal: true

module Decidim
  module ExtraUserFields
    # This controller customizes the behaviour of Devise::Omniauthable.
    module IncludeExtraData
      private

      # This override takes phone number from oauth_data extra info
      def user_params_from_oauth_hash
        return nil if oauth_data.empty?

        {
          provider: oauth_data[:provider],
          uid: oauth_data[:uid],
          name: oauth_data[:info][:name],
          nickname: oauth_data[:info][:nickname],
          oauth_signature: OmniauthRegistrationForm.create_signature(oauth_data[:provider], oauth_data[:uid]),
          avatar_url: oauth_data[:info][:image],
          phone_number: [oauth_data[:info][:prefix], oauth_data[:info][:phone]].compact.join,
          raw_data: oauth_hash
        }
      end
    end
  end
end
