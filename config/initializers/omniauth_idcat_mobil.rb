Decidim::TrustedIds.configure do |config|
  # The name of the omniauth provider, must be registered in Decidim.
  config.omniauth_provider = "valid"
  config.omniauth = {
    enabled: true,
    client_id: ENV["IDCAT_MOBIL_CLIENT_ID"],
    client_secret: ENV["IDCAT_MOBIL_CLIENT_SECRET"],
    site: ENV["IDCAT_MOBIL_SITE_URL"],
    scope: "autenticacio_usuari",
    icon: "smartphone-line"
  }
end
