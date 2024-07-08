# frozen_string_literal: true

server "reus-staging-new", user: "populate", roles: %w(app db web worker)
set :branch, "staging"
