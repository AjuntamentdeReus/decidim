module Decidim
  module RemovableAuthorizations
    module Verifications
      module AuthorizeUserOverrides
        def call
          return transfer_authorization if !handler.unique? && handler.transferrable?

          if handler.invalid?
            handler.log_failed_authorization
            register_conflict

            return broadcast(:invalid)
          end

          Authorization.create_or_update_from(handler)
          handler.log_successful_authorization

          broadcast(:ok)
        end
      end
    end
  end
end
