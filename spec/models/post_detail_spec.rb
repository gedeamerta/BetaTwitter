require_relative '../test_helper.rb'
require 'mysql2'
require_relative '../../models/post.rb'

describe Post_Detail do 

    describe '#trending' do
        context 'return trending hashtag' do
            it 'should be show top 5 most posted hashtag' do
                post_detail = Post_Detail.new ({
                    id_post: 1,
                    id_comment: 2,
                    post_hashtag: '#check1',
                    comment_hashtag: '#check1'
                })

                show_query = "SELECT CONCAT('#',post_hashtag) as post_hashtag, COUNT(post_hashtag) as total FROM post_detail WHERE post_detail.created_at > DATE_SUB(CURDATE(), INTERVAL 1 DAY) GROUP BY post_hashtag ORDER BY post_detail.post_hashtag DESC LIMIT 5"

                result_mock_raw_data = [{
                    "id_post" => post_detail.id_post,
                    "id_comment" => post_detail.id_comment,
                    "post_hashtag" => post_detail.post_hashtag,
                    "comment_hashtag" => post_detail.comment_hashtag
                }]

                dummby_db = double
                allow(Mysql2::Client).to receive(:new).and_return(dummby_db)
                expect(dummby_db).to receive(:query).with(show_query).and_return(result_mock_raw_data)

                Post_Detail.get_all_tag_trending
            end
        end
    end
end