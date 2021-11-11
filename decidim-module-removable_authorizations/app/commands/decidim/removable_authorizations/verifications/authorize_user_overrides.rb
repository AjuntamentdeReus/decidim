module Decidim
  module RemovableAuthorizations
    module Verifications
      module AuthorizeUserOverrides
        def call
          unless handler.valid?
            handler.log_failed_authorization
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
