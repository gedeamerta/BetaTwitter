require 'mysql2'
require_relative '../db/mysql_connector.rb'
require_relative '../controllers/comment_controller.rb'

class Comment 
    attr_accessor :id_comment, :comment, :id_user, :created_at
    def initialize(params)
        @id_comment = params[:id_comment]
        @comment = params[:comment]
        @id_user = params[:id_user]
        @created_at = params[:created_at]
    end

    def valid?
        return false if @id_comment.nil?

        return false if @comment.nil?

        return false if @id_user.nil?

        true
    end

    def self.get_id_by_comment(comment)
        client = create_db_client
        result = client.query("SELECT id_comment FROM comments WHERE comment = '#{comment}'")
        convert_sql_result_to_array(result)[0]
    end

    def save 
        return false unless valid?
        client = create_db_client
        client.query("INSERT INTO comments (comment, id_user) VALUES ('#{@comment}', #{@id_user})")
    end

    def save_comment_to_postdetail(comment_id, comment_hashtag)
        client = create_db_client
        client.query("INSERT INTO post_detail (id_comment, comment_hashtag) VALUES (#{comment_id}, '#{comment_hashtag.match(/[^#]\S+/)}')")
    end

    def save_hashtag(hashtag)
        client = create_db_client
        client.query("INSERT IGNORE INTO hashtag (hashtag_text) VALUES ('#{hashtag.match(/[^#]\S+/)}')")
    end

    def self.convert_sql_result_to_array(params)
        comments = Array.new
        params.each do |data|
            # * `transform_keys(&:to_sym)` => transform hash with key data type "string" to "symbol"
            comment = Comment.new(data.transform_keys(&:to_sym)) 
            comments << comment
        end
        comments 
    end
end