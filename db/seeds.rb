PASSWORD = '123456'

List.destroy_all
Board.destroy_all
AdminUser.destroy_all
User.destroy_all
Person.destroy_all

AdminUser.create!(email: 'admin@example.com', password: PASSWORD, password_confirmation: PASSWORD) if Rails.env.development?

person1 = Person.create(
  name: 'User One',
  image: Faker::Avatar.image("User-One"),
  alternate_name: 'User One'
)
user1 = User.create(
  email: 'user1@example.com',
  password: PASSWORD,
  password_confirmation: PASSWORD,
  confirmed_at: "2018-02-07 07:50:16.384971",
  image: Faker::Avatar.image("User-One"),
  person_id: person1.id
)

person2 = Person.create(
  name: 'User Two',
  image: Faker::Avatar.image("User-Two"),
  alternate_name: 'User Two'
)
user2 = User.create(
  email: 'user2@example.com',
  password: PASSWORD,
  password_confirmation: PASSWORD,
  confirmed_at: "2018-02-07 07:50:16.384971",
  image: Faker::Avatar.image("User-Two"),
  person_id: person2.id
)

7.times.each do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  Person.create(
    name: "#{first_name} #{last_name}",
    alternate_name: first_name,
    image: Faker::Avatar.image(first_name),
  email: "#{first_name.downcase}.#{last_name.downcase}@example.com"
  )
end

users = User.all
puts Cowsay.say("Created #{users.count} users", :tux)

people = Person.all
puts Cowsay.say("Created #{people.count} people", :stegosaurus)

board1 = Board.create(
  title: 'My first board',
  background_color: 'green',
  user_id: user1.id
)

board2 = Board.create(
  title: 'My first board',
  background_color: 'blue',
  user_id: user2.id
)

boards = Board.all
puts Cowsay.say("Created #{boards.count} boards", :beavis)

lists = ['WISHLIST','APPLIED','INTERVIEW','OFFER','REJECTED']

for i in 0..4 do
  List.create(
    title: lists[i],
    order: i+1,
    background_color: Faker::Color.color_name,
    board_id: board1.id
  )
end

for i in 0..4 do
  List.create(
    title: lists[i],
    order: i+1,
    background_color: Faker::Color.color_name,
    board_id: board2.id
  )
end

lists = List.all
puts Cowsay.say("Created #{lists.count} lists", :kitty)

puts "Login as user with #{user1.email} and password of '#{PASSWORD}'!"

puts "Login as admin at http://localhost:3005/admin with admin@example.com and password of '#{PASSWORD}'!"
