owner_id = User.find(email:"lbsingh732196@gmail.com").id
100.times do |i|
    School.create(
      name: Faker::Address.city,
      location: Faker::Address.city,
      owner_id: owner_id,
      status: rand(0..2),
      meta: { website: Faker::Internet.url }
    )
  end