require 'json'
require 'mysql2'
require_relative '../db/mysql_connector.rb'

class Post_Detail 
    attr_accessor :id_post, :id_comment, :post_hashtag, :comment_hashtag, :posts
    
    def initialize(params)
        @id_post = params[:id_post]
        @id_comment = params[:id_comment]
        @post_hashtag = params[:post_hashtag]
        @comment_hashtag = params[:comment_hashtag]
        @posts = []
    end

    def self.get_all_tag_trending
        client = create_db_client
        result = client.query("SELECT IF(post_hashtag LIKE comment_hashtag, CONCAT('#', post_hashtag), '') as post_hashtag, COUNT(post_hashtag) OR COUNT(comment_hashtag) as total FROM post_detail WHERE post_detail.created_at > DATE_SUB(CURDATE(), INTERVAL 1 DAY) GROUP BY post_hashtag, comment_hashtag LIMIT 5")
        convert_sql_result_to_array(result)
    end 

    def self.convert_sql_result_to_array(params)
        post_detail = Array.new
        params.each do |data|
            # * `transform_keys(&:to_sym)` => transform hash with key data type "string" to "symbol"
            post = Post_Detail.new(data.transform_keys(&:to_sym)) 
            post_detail << post
        end
        post_detail
    end
end