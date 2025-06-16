# frozen_string_literal: true

Decidim::ExtraUserFields::Settings.configure do |config|
  config.interests = [
    :social_welfare,
    :cooperation,
    :culture,
    :education,
    :sports,
    :training_and_employment,
    :elderly,
    :childhood,
    :youth,
    :environment,
    :gender_policies,
    :city_projection,
    :economic_promotion,
    :public_health,
    :citizen_safety,
    :associative_network,
    :urban_planning,
    :public_roads,
    :other_topics_of_interest,
    :none
  ]
end
