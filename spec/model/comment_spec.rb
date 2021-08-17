require_relative '../test/test_helper.rb'
require 'mysql2'
require_relative '../../models/comment.rb'

describe Comment do

    describe '#valid' do
        context 'when initialiazed with valid input' do
            it 'should return true' do
                comment = Comment.new({
                    id_comment: 1,
                    comment: 'Im groot',
                    id_user: 1,
                })
                expect(comment.valid?).to eq(true)
            end
        end
    end
    
    describe "#comment" do
        context "when tried to comment" do
            it "should be save the comment" do
                comment = Comment.new({
                    id_comment: 1,
                    comment: 'Test Comment',
                    id_user: 1
                })

                insert_query = "INSERT INTO comments (comment, id_user) VALUES ('#{comment.comment}', #{comment.id_user})"

                dummby_db = double
                allow(Mysql2::Client).to receive(:new).and_return(dummby_db)
                expect(dummby_db).to receive(:query).with(insert_query)

                comment.save
            end

            it 'should be save to hashtag table' do
                comment = Comment.new({
                    id_comment: 1,
                    comment: 'Test Comment',
                    id_user: 1
                })

                hashtag_text = '#check1'

                insert_query = "INSERT IGNORE INTO hashtag (hashtag_text) VALUES ('#{hashtag_text.match(/[^#]\S+/)}')"

                dummby_db = double
                allow(Mysql2::Client).to receive(:new).and_return(dummby_db)
                expect(dummby_db).to receive(:query).with(insert_query)

                comment.save_hashtag(hashtag_text)
            end

            it 'should be get id comment' do
                comments = Comment.new({
                    id_comment: 1,
                    comment: 'Test Comment',
                    id_user: 1
                })

                result_mock_raw_data = [{
                    "id_comment" => comments.id_comment,
                    "comment" => comments.comment,
                    "id_user" => comments.id_user,
                }]

                show_query = "SELECT id_comment FROM comments WHERE comment = '#{comments.comment}'"

                dummby_db = double
                allow(Mysql2::Client).to receive(:new).and_return(dummby_db)
                expect(dummby_db).to receive(:query).with(show_query).and_return(result_mock_raw_data)

                Comment.get_id_by_comment(comments.comment)
            end

            it 'should be save to detail post, which is have id_post and id_comment' do
                comment = Comment.new({
                    id_comment: 1,
                    comment: 'Test Comment',
                    id_user: 1,
                })

                hashtag_text = '#check1'

                insert_query = "INSERT INTO post_detail (id_comment, comment_hashtag) VALUES (#{comment.id_comment}, '#{hashtag_text.match(/[^#]\S+/)}')"

                dummby_db = double
                allow(Mysql2::Client).to receive(:new).and_return(dummby_db)
                expect(dummby_db).to receive(:query).with(insert_query)

                comment.save_comment_to_postdetail(comment.id_comment, hashtag_text)
            end
        end
    end

end