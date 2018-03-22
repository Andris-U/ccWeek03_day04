require('pg')

class Star
  attr_accessor :first_name, :last_name
  attr_reader :id

  def initialize options
    @first_name = options['first_name']
    @last_name = options['last_name']
    @id = options['id'].to_s
  end

  def save
    sql = "
      INSERT INTO stars (first_name, last_name)
      VALUES ($1, $2)
      RETURNING id;
    "
    values = [@first_name, @last_name]
    result = SqlRunner.run sql, values
    @id = result.first['id'].to_i
  end

  def movies
    sql = "
      SELECT movies.*
      FROM movies
      INNER JOIN castings
      ON movies.id = castings.movie_id
      INNER JOIN stars
      ON castings.star_id = stars.id
      WHERE star_id = $1;
    "
    values = [@id]
    list = SqlRunner.run sql, values
    return list.first != nil ? list.map { |e| Movie.new(e) } : nil
  end

  def self.all
    sql ="
      SELECT * FROM stars;
    "
    list = SqlRunner.run sql
    return list.first != nil ? list.map { |e| Star.new(e) } : nil
  end

  def self.delete
    sql = "
      DELETE FROM stars;
    "
    SqlRunner.run sql
  end
end
