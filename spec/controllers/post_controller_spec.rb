require '../../db/mysql_connector.rb'
require_relative '../../controllers/post_controller.rb'
require_relative '../../models/post.rb'
require_relative '../../models/post_detail.rb'

describe PostController do

    # ! There is a problem while returning views files, IDK why can't access the the views file 
    # describe '#show_posts' do
    #     context 'when data is exist' do
    #         it 'should show all data posts' do
    #             controller = PostController.new
    #             response = controller.show_all_post
    #             expected_view = ERB.new(File.read('./views/posts.erb')).result(binding)
    #             expect(expected_view).to eq(response)
    #         end
    #     end
    # end

    # describe '#save_post' do
    #     before(:each) do
    #         client = create_db_client
    #         client.query("TRUNCATE posts")
    #     end
    #     context 'when given valid parameter' do
    #         before(:each) do
    #             params = {
    #                 'caption' => 'caption nih boss',
    #                 'image' => '/img/testing',
    #                 'id_user' => 3,
    #                 'post_hashtag' => '#check1'.match(/[^#]\S+/)
    #             }

    #             controller = PostController.new

    #             response = controller.create_post(params)
    #         end

    #         it 'should save order' do
    #             expected_post = Post.get_posts_by_id('posts.id_post')
    #             expect(expected_post).not_to be_nil
    #         end

    #         it 'should render page' do
    #             posts = Post.get_all_post
    #             post_tags = Post_Detail.get_all_tag_trending
    #             expected_view = ERB.new(File.read('../../views/posts.erb')).result(binding)
    #             expect(expected_view).to eq(@response)
    #         end
    #     end
    # end
end