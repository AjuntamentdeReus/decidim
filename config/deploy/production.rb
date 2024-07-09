# frozen_string_literal: true

server "reus-production-new", user: "populate", roles: %w(app db web worker)
set :branch, "master"
