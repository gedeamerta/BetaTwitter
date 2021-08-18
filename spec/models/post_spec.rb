require_relative '../test_helper.rb'
require 'mysql2'
require_relative '../../models/post.rb'

describe Post do

    describe '#valid' do
        context 'when initialiazed with valid input' do
            it 'should return true' do
                post = Post.new({
                    id_post: 1,
                    caption: 'Im groot',
                    image: [],
                    created_at: [],
                    id_user: 1,
                    post_hashtag: []
                })
                expect(post.valid?).to eq(true)
            end
        end
    end

    describe '#post_data' do
        context 'when show data posts' do
            it 'should show all data post' do
                post = Post.new({
                    id_post: [],
                    caption: 'Im groot',
                    image: '/gede-ganteng',
                    created_at: [],
                    id_user: 1,
                    post_hashtag: ['check1', 'check2']
                })

                show_query = "SELECT posts.*, GROUP_CONCAT(post_detail.post_hashtag) as post_hashtag FROM posts INNER JOIN post_detail ON posts.id_post = post_detail.id_post GROUP BY posts.id_post"

                result_mock_raw_data = [{
                    "id_post" => post.id_post,
                    "caption" => post.caption,
                    "image" => post.image,
                    "created_at" => post.created_at,
                    "id_user" => post.id_user,
                    "post_hashtag" => post.post_hashtag
                }]

                dummby_db = double
                allow(Mysql2::Client).to receive(:new).and_return(dummby_db)
                expect(dummby_db).to receive(:query).with(show_query).and_return(result_mock_raw_data)

                Post.get_all_post
            end
        end

        context 'when click comment link' do
            it 'should be show post data by id_post' do
                post = Post.new({
                    id_post: 1,
                    caption: 'Im groot',
                    image: '/gede-ganteng',
                    created_at: [],
                    id_user: 1,
                    post_hashtag: ['check1', 'check2']
                })

                result_mock_raw_data = [{
                    "id_post" => post.id_post,
                    "caption" => post.caption,
                    "image" => post.image,
                    "created_at" => post.created_at,
                    "id_user" => post.id_user,
                    "post_hashtag" => post.post_hashtag
                }]

                query_id_post = "SELECT posts.*, post_detail.post_hashtag FROM posts INNER JOIN post_detail ON posts.id_post = post_detail.id_post WHERE posts.id_post = #{post.id_post}"

                dummby_db = double
                allow(Mysql2::Client).to receive(:new).and_return(dummby_db)
                expect(dummby_db).to receive(:query).with(query_id_post).and_return(result_mock_raw_data)

                Post.get_posts_by_id(post.id_post)
            end
        end

        context 'when show form posts' do
            it 'should be save data' do
                post = Post.new({
                    id_post: 1,
                    caption: "Im a goodboy",
                    image: '/images/good.jpg',
                    created_at: [],
                    id_user: 1,
                    hashtag: "#check1"
                })

                insert_query = "INSERT INTO posts (caption, image, id_user) VALUES ('#{post.caption}', '#{post.image}', #{post.id_user})"

                dummby_db = double
                allow(Mysql2::Client).to receive(:new).and_return(dummby_db)
                expect(dummby_db).to receive(:query).with(insert_query)

                post.save
            end

            it 'should save to hashtag table' do
                post = Post.new({
                    id_post: [],
                    caption: [],
                    image: [],
                    created_at: [],
                    id_user: [],
                    post_hashtag: "#check1"
                })

                insert_query = "INSERT IGNORE INTO hashtag (hashtag_text) VALUES ('#{post.post_hashtag.match(/[^#]\S+/)}')"

                dummby_db = double
                allow(Mysql2::Client).to receive(:new).and_return(dummby_db)
                expect(dummby_db).to receive(:query).with(insert_query)

                post.save_hashtag(post.post_hashtag)
            end

            it 'should select posts id by caption' do
                post = Post.new({
                    id_post: 1,
                    caption: 'Im groot',
                    image: '/gede-ganteng',
                    created_at: [],
                    id_user: 1,
                    post_hashtag: ['check1', 'check2']
                })

                result_mock_raw_data = [{
                    "id_post" => post.id_post,
                    "caption" => post.caption,
                    "image" => post.image,
                    "created_at" => post.created_at,
                    "id_user" => post.id_user,
                    "post_hashtag" => post.post_hashtag
                }]

                show_id_post = "SELECT id_post FROM posts WHERE caption = '#{post.caption}'"

                dummby_db = double
                allow(Mysql2::Client).to receive(:new).and_return(dummby_db)
                expect(dummby_db).to receive(:query).with(show_id_post).and_return(result_mock_raw_data)

                Post.get_id_by_caption(post.caption)
            end

            it 'should save to post_detail after selected post id by caption' do
                post = Post.new({
                    id_post: 1,
                    caption: 'Im groot',
                    image: '/gede-ganteng',
                    created_at: [],
                    id_user: 1,
                    post_hashtag: '#check1'
                })

                insert_query = "INSERT INTO post_detail (id_post, post_hashtag) VALUES (#{post.id_post}, '#{post.post_hashtag.match(/[^#]\S+/)}')"

                dummby_db = double
                allow(Mysql2::Client).to receive(:new).and_return(dummby_db)
                expect(dummby_db).to receive(:query).with(insert_query)

                post.save_to_post_detail(post.id_post, post.post_hashtag)
            end
        end
    end

    describe "#filter_hashtag" do
        context 'when user click hashtag link' do
            it 'should show all data post by hashtag' do
                post = Post.new({
                    id_post: 1,
                    caption: "Im a goodboy",
                    image: '/images/good.jpg',
                    created_at: [],
                    id_user: 1,
                    post_hashtag: "check1"
                })

                result_mock_raw_data = [{
                    "id_post" => post.id_post,
                    "caption" => post.caption,
                    "image" => post.image,
                    "created_at" => post.created_at,
                    "id_user" => post.id_user,
                    "post_hashtag" => post.post_hashtag
                }]

                post_hashtag = "SELECT posts.*, post_detail.post_hashtag FROM posts INNER JOIN post_detail ON posts.id_post = post_detail.id_post WHERE post_detail.post_hashtag = '#{post.post_hashtag}'"

                dummby_db = double
                allow(Mysql2::Client).to receive(:new).and_return(dummby_db)
                expect(dummby_db).to receive(:query).with(post_hashtag).and_return(result_mock_raw_data)

                Post.find_post_hashtag("#{post.post_hashtag}")
            end
        end
    end
end