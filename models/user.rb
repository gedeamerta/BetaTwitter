require 'json'
require 'mysql2'
require_relative '../db/mysql_connector.rb'

class User
    attr_accessor :id_user, :username, :email, :bio

    def initialize(param)
        @id_user = param[:id_user]
        @username = param[:username]
        @email = param[:email]
        @bio = param[:bio]
    end

    def valid?
        return false if @id_user.nil?

        return false if @username.nil?

        return false if @email.nil?

        true
    end

    def self.convert_sql_result_to_array(params)
        users = Array.new
        params.each do |data|
            # * `transform_keys(&:to_sym)` => transform hash with key data type "string" to "symbol"
            user = User.new(data.transform_keys(&:to_sym)) 
            users << user
        end
        users # return items
    end

    def save 
        return false unless valid?
        client = create_db_client
        result = client.query("INSERT INTO users (username, email, bio) VALUES ('#{@username}', '#{@email}', '#{@bio}')")
    end

    # * Json
    def self.get_all_user_json
        @hash = Hash.new 
        @array = Array.new
        client = create_db_client
        @query = client.query("SELECT * FROM users")
        @query.each do |data| 
            @hash = { 
                :id_user => data['id_user'], 
                :username => data['username'],
                :email => data['email'],
                :bio => data['bio']
            }
            @array << @hash
        end
        return JSON(@array)
    end 
end