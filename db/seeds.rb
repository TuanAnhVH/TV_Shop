Brand.create!(name: "Sony")
Brand.create!(name: "LG")
Brand.create!(name: "Panasonic")
Brand.create!(name: "Samsung")

Size.create!(name: "12 inch")
Size.create!(name: "24 inch")
Size.create!(name: "36 inch")
Size.create!(name: "72 inch")

99.times do |n|
  Product.create!(
    brand_id: Brand.pluck(:id).sample,
    size_id: Size.pluck(:id).sample,
    name: "#{Brand.pluck(:name).sample}" + " #{n+1}",
    describe: Faker::Lorem.paragraph,
    price: Faker::Number.decimal(l_digits: 2)
  )
end

User.create!(name: "Nguyen Van A",
  email: "nguyenvana@gmail.com",
  address: "Hue",
  phone: "0123456789",
  role: 1,
  password: "123456",
  password_confirmation: "123456")

User.create!(name: "Nguyen Van B",
  email: "nguyenvanb@gmail.com",
  address: "Da Nang",
  phone: "0123456789",
  role: 2,
  password: "123456",
  password_confirmation: "123456")

User.create!(name: "Nguyen Van C",
  email: "nguyenvanc@gmail.com",
  address: "Ha Noi",
  phone: "0123456789",
  role: 3,
  password: "123456",
  password_confirmation: "123456")

10.times do |n|
  User.create!(
    name: Faker::FunnyName.name,
    email: "example#{n+1}@gmail.com",
    password:"123123",
    password_confirmation: "123123",
    address: Faker::Address.full_address,
    phone: Faker::Number.leading_zero_number(digits: 10),
    role: 3)
end

users = User.order(:created_at).take(3)
products = Product.order(:created_at).take(5)
products.each do |product|
  users.each do |user|
    content = Faker::Lorem.paragraph
    product.comments.create!(user_id: user.id, content: content)
  end
end
