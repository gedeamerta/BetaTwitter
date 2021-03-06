require_relative '../models/comment.rb'
class CommentController 

    def create_comment(params)
        comment = Comment.new({
            id_comment: [],
            comment: params['comment'],
            id_user: params['id_user'],
            created_at: []
        })
        post_hashtag_text = params['post_hashtag']
        comment_hashtag_text = params['comment_hashtag']
        comment.save
        comment.save_hashtag(comment_hashtag_text)
        comment_id = Comment.get_id_by_comment(params['comment'])
        comment.save_comment_to_postdetail(comment_id.id_comment, post_hashtag_text, comment_hashtag_text)
    end
end