# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
# movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# Character.create(name: 'Luke', movie: movies.first)

password = 'PassworD@55'
yasir, azgar, randy = User.create(
  [
    {name: 'Yasir', email: "yasir@risk.com", password: password},
    {name: 'Azgar', email: "azgar@risk.com", password: password},
    {name: 'Randy', email: "randy@risk.com", password: password}
  ]
)

desc = Proc.new {|movie| "Description for movie #{movie}, its director, year of release and etc."}
pulp_fiction, inception, dark_knight = Movie.create(
  ['Pulp Fiction', 'Inception', 'Dark Knight'].map do |movie|
    {
      title: movie,
      description: desc.call(movie),
      user: yasir,
      category_id: Movie::Category::ACTION
    }
  end
)
Rating.create(
  [
    {user: yasir, movie: pulp_fiction, rating: 5},
    {user: azgar, movie: pulp_fiction, rating: 4},
    {user: randy, movie: pulp_fiction, rating: 4}
  ]
)
Rating.create(
  [
    {user: yasir, movie: inception, rating: 5},
    {user: azgar, movie: inception, rating: 4},
    {user: randy, movie: inception, rating: 3}
  ]
)
Rating.create(
  [
    {user: yasir, movie: dark_knight, rating: 5},
    {user: azgar, movie: dark_knight, rating: 3},
    {user: randy, movie: dark_knight, rating: 4}
  ]
)

avengers, marvel, pool = Movie.create(
  ['Avengers', 'Captain Marvel', 'Dead Pool'].map do |movie|
    {title: movie, description: desc.call(movie), user: azgar, category_id: Movie::Category::ANIMATION}
  end
)
Rating.create(
  [
    {user: yasir, movie: avengers, rating: 4},
    {user: azgar, movie: avengers, rating: 3},
    {user: randy, movie: avengers, rating: 5}
  ]
)
Rating.create(
  [
    {user: yasir, movie: marvel, rating: 3},
    {user: azgar, movie: marvel, rating: 2},
    {user: randy, movie: marvel, rating: 4}
  ]
)
Rating.create(
  [
    {user: yasir, movie: pool, rating: 4},
    {user: azgar, movie: pool, rating: 3},
    {user: randy, movie: pool, rating: 2}
  ]
)

django, insomnia, interstellar = Movie.create(
  ['Django', 'Insomnia', 'Interstellar'].map do |movie|
    {title: movie, description: desc.call(movie), user: randy, category_id: Movie::Category::COMEDY}
  end
)
Rating.create(
  [
    {user: yasir, movie: django, rating: 4},
    {user: azgar, movie: django, rating: 4},
    {user: randy, movie: django, rating: 4}
  ]
)
Rating.create(
  [
    {user: yasir, movie: insomnia, rating: 3},
    {user: azgar, movie: insomnia, rating: 4},
    {user: randy, movie: insomnia, rating: 3}
  ]
)
Rating.create(
  [
    {user: yasir, movie: interstellar, rating: 5},
    {user: azgar, movie: interstellar, rating: 3},
    {user: randy, movie: interstellar, rating: 4}
  ]
)

redemption, rising, copper = Movie.create(
  ['redemption', 'rising', 'copper'].map do |movie|
    {title: movie, description: desc.call(movie), user: randy, category_id: Movie::Category::DRAMA}
  end
)
Rating.create(
  [
    {user: yasir, movie: redemption, rating: 4},
    {user: azgar, movie: redemption, rating: 4},
    {user: randy, movie: redemption, rating: 4}
  ]
)
Rating.create(
  [
    {user: yasir, movie: rising, rating: 3},
    {user: azgar, movie: rising, rating: 4},
    {user: randy, movie: rising, rating: 3}
  ]
)
Rating.create(
  [
    {user: yasir, movie: copper, rating: 5},
    {user: azgar, movie: copper, rating: 3},
    {user: randy, movie: copper, rating: 4}
  ]
)

