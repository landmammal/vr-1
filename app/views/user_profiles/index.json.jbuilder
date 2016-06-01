json.array!(@user_profiles) do |user_profile|
  json.extract! user_profile, :id, :first_name, :last_name, :email, :age, :education, :race, :company, :role
  json.url user_profile_url(user_profile, format: :json)
end
