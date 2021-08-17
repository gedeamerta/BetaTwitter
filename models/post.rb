require 'json'
require 'mysql2'
require_relative '../db/mysql_connector.rb'
require_relative './post_detail.rb'

class Post

    attr_accessor :id_post, :caption, :image, :id_user, :created_at, :post_hashtag
    def initialize(params)
        @id_post = params[:id_post]
        @caption = params[:caption]
        @image = params[:image]
        @id_user = params[:id_user]
        @created_at = params[:created_at]
        @post_hashtag = params[:post_hashtag]
    end

    def self.get_all_post
        client = create_db_client
        result = client.query("SELECT posts.*, GROUP_CONCAT(post_detail.post_hashtag) as post_hashtag FROM posts INNER JOIN post_detail ON posts.id_post = post_detail.id_post GROUP BY posts.id_post")
        convert_sql_result_to_array(result)
    end

    def self.get_posts_by_id(id_post)
        client = create_db_client
        result = client.query("SELECT posts.*, post_detail.post_hashtag FROM posts INNER JOIN post_detail ON posts.id_post = post_detail.id_post WHERE posts.id_post = #{id_post}")
        convert_sql_result_to_array(result)
    end

    def self.get_post_by_hastag(hashtag_text)
        posts = find_post_hashtag(hashtag_text)
        posts
    end

    def self.find_post_hashtag(hashtag_text)
        client = create_db_client
        result = client.query("SELECT posts.*, post_detail.post_hashtag FROM posts INNER JOIN post_detail ON posts.id_post = post_detail.id_post WHERE post_detail.post_hashtag = '#{hashtag_text}'")
        convert_sql_result_to_array(result)
    end

    def self.get_id_by_caption(caption)
        client = create_db_client
        result = client.query("SELECT id_post FROM posts WHERE caption = '#{caption}'")
        convert_sql_result_to_array(result)[0]
    end

    def save 
        return false unless valid?
        client = create_db_client
        client.query("INSERT INTO posts (caption, image, id_user) VALUES ('#{@caption}', '#{@image}', #{@id_user})")
    end

    def save_hashtag(hashtag)
        client = create_db_client
        client.query("INSERT IGNORE INTO hashtag (hashtag_text) VALUES ('#{hashtag.match(/[^#]\S+/)}')")
    end

    def save_to_post_detail(post_id, hashtag_text)
        client = create_db_client
        client.query("INSERT INTO post_detail (id_post, post_hashtag) VALUES (#{post_id}, '#{hashtag_text.match(/[^#]\S+/)}')")
    end

    def valid?
        return false if @id_post.nil?

        return false if @caption.nil?
        
        return false if @id_user.nil?
        true
    end

    def self.convert_sql_result_to_array(params)
        posts = Array.new
        params.each do |data|
            # * `transform_keys(&:to_sym)` => transform hash with key data type "string" to "symbol"
            post = Post.new(data.transform_keys(&:to_sym)) 
            posts << post
        end
        posts
    end

    # * Json
    def self.get_all_post_json
        @hash = Hash.new 
        @array = Array.new
        client = create_db_client
        @query = client.query("SELECT * FROM posts")
        @query.each do |data| 
            @hash = { 
                :id_post => data['id_post'], 
                :caption => data['caption'], 
                :image => data['image'],
                :id_user => data['id_user'],
                :created_at => data['created_at'],
            }
            @array << @hash
        end
        return JSON(@array)
    end 
end