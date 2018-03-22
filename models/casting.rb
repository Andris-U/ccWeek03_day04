require('pg')

class Casting
  attr_accessor :movie_id, :star_id, :fee
  attr_reader :id

  def initialize options
    @movie_id = options['movie_id'].to_s
    @star_id = options['star_id'].to_s
    @fee = options['fee'].to_s
    @id = options['id']
  end

  def save
    sql = "
      INSERT INTO castings (movie_id, star_id, fee)
      VALUES ($1, $2, $3)
      RETURNING id;
    "
    values = [@movie_id, @star_id, @fee]
    result = SqlRunner.run sql, values
    @id = result.first['id'].to_i
  end

  def self.all
    sql = "
      SELECT * FROM castings
    "
    list = SqlRunner.run sql
    return list.first != nil ? list.map { |e| Casting.new(e) } : nil
  end

  def self.delete
    sql = "
      DELETE FROM castings;
    "
    SqlRunner.run sql
  end
end
