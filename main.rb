require 'sinatra'
require 'sinatra/reloader'
require_relative './controllers/user_controller'
require_relative './controllers/post_controller'
require_relative './controllers/comment_controller'

get '/' do
    users = UserController.new
    erb users.show_index, :layout => :layout, locals: {
        title: "Users"
    }
end

post '/users/create' do
    users = UserController.new
    users.create_user_data(params)
    redirect '/'
end

get '/post' do
    posts = PostController.new
    erb posts.show_all_post, :layout => :layout, locals: {
        title: "Post"
    }
end

get '/post/new' do
    posts = PostController.new
    erb posts.show_form_post, :layout => :layout, locals: {
        title: "Post Form"
    }
end

post '/post/create' do
    posts = PostController.new
    posts.create_post(params)
    redirect '/post'
end

get '/post/comment/:id_post' do
    id_post = params[:id_post]
    posts = PostController.new
    erb posts.show_form_comment_by_id(id_post), :layout => :layout, locals: {
        title: "Form Comment Post"
    }
end

get '/post/add_hashtag/:id_post' do
    id_post = params[:id_post]
    posts = PostController.new
    erb posts.show_form_hashtag_by_id(id_post), :layout => :layout, locals: {
        title: "Form Hashtag Post"
    }
end

post '/post/create_hashtag' do
    posts = PostController.new
    posts.create_hashtag(params)
    redirect '/post'
end

post '/comment/create' do
    comments = CommentController.new
    comments.create_comment(params)
    redirect '/post'
end

get '/post/:hashtag' do
    hashtag = params['hashtag']
    posts = PostController.new 
    erb posts.show_list_post_base_on_hashtag(hashtag), :layout => :layout, locals: {
        title: "Post by Hashtag"
    }
end

# * Json
get '/users_json' do
    content_type :json
    users = UserController.new
    users.show_all_users_json
end

# * Json
get '/post_json' do
    content_type :json
    posts = PostController.new
    posts.show_all_post_json
end
