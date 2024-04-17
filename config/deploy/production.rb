# frozen_string_literal: true

server "participa.reus.cat", user: "populate", roles: %w(app db web worker)
set :branch, "master"
