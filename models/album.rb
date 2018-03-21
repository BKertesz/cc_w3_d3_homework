require_relative('../db/sql_runner.rb')

class Album
  attr_reader :id, :artist_id
  attr_accessor :title, :genre

  def initialize(object)
    @id = object['id']
    @title = object['title']
    @genre = object['genre']
    @artist_id = object['artist_id'].to_i
  end

  def save()
    sql = 'INSERT INTO artists (title,genre,artist_id) VALUES ($1,$2,$3) RETURNING id;'
    values =[@title,@genre,@artist_id]
    result = SqlRunner.run(sql,values)
    @id = result[0]['id'].to_i
  end

# return an artist object of this album
# album1.artist() should return Artist object

  def artist()
    sql = 'SELECT FROM artists WHERE id= $1;'
    values = [@artist_id]
    result = SqlRunner.run(sql,values)
    return result.map{|x| Artist.new(x)}
  end

  def edit()
    sql = "UPDATE artists SET (title,genre)=($1,$2) WHERE id = $3"
    values = [@title,@genre,@id]
    SqlRunner.run(sql,values)
  end


  def self.list_all()
    sql = 'SELECT * FROM albums;'
    result = SqlRunner.run(sql)
    return result.map{|x| Album.new(x)}
  end

end
