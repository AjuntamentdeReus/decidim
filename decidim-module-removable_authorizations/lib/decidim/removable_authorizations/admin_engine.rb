# frozen_string_literal: true

module Decidim
  module RemovableAuthorizations
    # This is the engine that runs on the public interface of `RemovableAuthorizations`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::RemovableAuthorizations::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        # Add admin engine routes here
        resources :authorizations, only: [:index] do
          collection do
            post :delete
          end
        end
      end

      initializer "decidim_removable_authorizations_admin.mount_routes", before: "decidim_admin.mount_routes" do
        # Mount the engine routes to Decidim::Core::Engine because otherwise
        # they would not get mounted properly.
        Decidim::Admin::Engine.routes.append do
          mount Decidim::RemovableAuthorizations::AdminEngine => "/"
        end
      end

      def load_seed
        nil
      end
    end
  end
end
