# This script anonymizes the users defined by an scope

scope = Decidim::User.where("email LIKE '%@mail.ru'")
puts "Anonymizing #{scope.count} users"

scope.find_each do |user|
  user.update_columns(
    email: "user-#{user.id}@reus-anonymized-user.com",
    name: "Anonymized User #{user.id}",
    telephone_number_custom: "123456789",
    official_name_custom: "Anonymized User #{user.id}",
    encrypted_password: SecureRandom.hex(64),
    reset_password_token: nil,
    current_sign_in_at: nil,
    last_sign_in_at: nil,
    current_sign_in_ip: nil,
    last_sign_in_ip: nil,
    invitation_token: nil,
    confirmation_token: nil,
    unconfirmed_email: nil
  )
end
