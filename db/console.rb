require_relative "../models/album"
require_relative "../models/artist"
require_relative "sql_runner"

artist1 = Artist.new({'name'=>'Lady Gaga'})
artist1.save

p Artist.list_all

# EOF
