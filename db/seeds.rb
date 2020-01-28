User.create(
  name: "ueki", 
  email: "ueki@gmail.com", 
  password: "1111", 
)
User.create(
  name: "admin", 
  email: "ueki@dic.com", 
  password: "1111", 
  admin: "true",
)
User.create(
  name: "test_user", 
  email: "test@dic.com", 
  password: "1111", 
)

User.create(
  name: "test_user2", 
  email: "test02@dic.com", 
  password: "1111", 
  admin: "true"
)

5.times do |i|
  Label.create!(name: "sample#{i + 1}")
end