require_relative('../db/sql_runner.rb')

class Artist
  attr_reader :id
  attr_accessor :name

  def initialize(object)
    @name = object['name']
    @id = object['id'].to_i
  end

  def save()
    sql = 'INSERT INTO artists (name) VALUES ($1) RETURNING id;'
    values =[@name]
    result = SqlRunner.run(sql,values)
    @id = result[0]['id'].to_i
  end


  def albums()
    sql = 'SELECT FROM albums WHERE artist_id= $1;'
    values = [@id]
    result = SqlRunner.run(sql,values)
    return result.map{|x| Albums.new(x)}
  end

  def edit()
    sql = "UPDATE artists SET (name)=($1) WHERE id = $2"
    values = [@name,@id]
    SqlRunner.run(sql,values)
  end

  def self.list_all()
    sql = 'SELECT * FROM artists;'
    result = SqlRunner.run(sql)
    return result.map{|x| Artist.new(x)}
  end

end
