require('pg')
require('pry')
require_relative('star')
require_relative('../sql_runner')

class Movie
  attr_accessor :title, :genre, :rating, :budget
  attr_reader :id

  def initialize options
    @title = options['title']
    @genre = options['genre']
    @rating = options['rating'].to_s
    @budget = options['budget'].to_s
    @id = options['id'].to_s
  end

  def save
    sql = "
      INSERT INTO movies (title, genre, rating, budget)
      VALUES ($1, $2, $3, $4)
      RETURNING id;
    "
    values = [@title, @genre, @rating, @budget]
    result = SqlRunner.run sql, values
    @id = result.first['id'].to_i
  end

  def update
    sql = "
      UPDATE movies
      SET (title, genre, rating, budget) = ($1, $2, $3, $4)
      WHERE id = $5;
    "
    values = [@title, @genre, @rating, @budget, @id]
    SqlRunner.run sql, values
  end

  def cast
    sql = "
      SELECT stars.*
      FROM stars
      INNER JOIN castings
      ON stars.id = castings.star_id
      INNER JOIN movies
      ON movies.id = castings.movie_id
      WHERE movie_id = $1;
    "
    values = [@id]
    list = SqlRunner.run sql, values
    return list.first != nil ? list.map { |e| Star.new(e) } : nil
  end

  def budget_minus_fees
    sql = "
      SELECT castings.fee
      FROM stars
      INNER JOIN castings
      ON stars.id = castings.star_id
      INNER JOIN movies
      ON movies.id = castings.movie_id
      WHERE movie_id = $1;
    "
    values = [@id]
    fees = SqlRunner.run sql, values
    total = fees.map { |e| e["fee"].to_i }
    return total.reduce(:+)
  end

  def self.delete
    sql = "
      DELETE FROM movies;
    "
    SqlRunner.run sql
  end

  def self.all
    sql = "
      SELECT * FROM movies;
    "
    list = SqlRunner.run sql
    return list.first != nil ? list.map { |e| Movie.new(e) } : nil
  end
end
