require('pg')
require('pry')
require_relative('./models/movie')
require_relative('./models/star')
require_relative('./models/casting')

Casting.delete
Movie.delete
Star.delete

movie1 = Movie.new(
  {
    'title' => 'Blade Runner',
    'genre' => 'Sci-fi',
    'rating' => '9.0',
    'budget' => 100000
  }
)

movie2 = Movie.new(
  {
    'title' => 'Indiana Jones',
    'genre' => 'Action',
    'rating' => 8.3,
    'budget' => 120000
  }
)

star1 = Star.new(
  {
    'first_name' => 'Harrison',
    'last_name' => 'Ford'
  }
)
star2 = Star.new(
  {
    'first_name' => 'Rutger',
    'last_name' => 'Hauer'
  }
)

movie1.save
movie2.save
star1.save
star2.save

casting1 = Casting.new(
  {
    'movie_id' => movie1.id,
    'star_id' => star1.id,
    'fee' => '50000'
  }
)
casting2 = Casting.new(
  {
    'movie_id' => movie2.id,
    'star_id' => star1.id,
    'fee' => 30000
  }
)
casting3 = Casting.new(
  {
    'movie_id' => movie1.id,
    'star_id' => star2.id,
    'fee' => 20000
  }
)
# binding.pry
casting1.save
casting2.save
casting3.save
p Movie.all
p Star.all
p Casting.all
p movie1.cast
p star1.movies
p movie1.budget_minus_fees
