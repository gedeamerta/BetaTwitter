require 'mysql2'
def create_db_client 
    client = Mysql2::Client.new(
        :host => "localhost",
        :username => "amerta",
        :password => "Amerta123#@!",
        :database => "beta_twitter"
    )
    client
end


