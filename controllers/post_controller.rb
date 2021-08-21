require 'json'
require_relative '../models/post.rb'
require_relative '../models/post_detail.rb'

class PostController 

    def show_all_post
        posts = Post.get_all_post
        post_tags = Post_Detail.get_all_tag_trending
        renderer = ERB.new(File.read('./views/posts.erb'))
        renderer.result(binding)
    end

    def show_form_post 
        renderer = ERB.new(File.read('./views/new_post.erb'))
        renderer.result(binding)
    end

    def show_form_comment_by_id(params)
        posts = Post.get_posts_by_id(params)
        renderer = ERB.new(File.read('./views/comment_post.erb'))
        renderer.result(binding)
    end

    def show_form_hashtag_by_id(params)
        posts = Post.get_posts_by_id(params)
        renderer = ERB.new(File.read('./views/add_hashtag.erb'))
        renderer.result(binding)
    end

    def show_list_post_base_on_hashtag(params)
        posts = Post.get_post_by_hastag(params)
        renderer = ERB.new(File.read('./views/post_by_hashtag.erb'))
        renderer.result(binding)
    end

    def create_post(params)
        post = Post.new({
            id_post: [],
            caption: params['caption'],
            image: params['image'],
            id_user: params['id_user'],
            created_at: [],
            hashtag: []
        })
        hashtag_text = params['hashtag_text']
        post.save
        post.save_hashtag(hashtag_text)
        post_id = Post.get_id_by_caption(post.caption)
        post.save_to_post_detail(post_id.id_post, hashtag_text)
    end

    def create_hashtag(params)
        post = Post.new({
            id_post: [],
            caption: params['caption'],
            image: params['image'],
            id_user: params['id_user'],
            created_at: [],
            hashtag: []
        })
        post_id = params['id_post']
        hashtag_text = params['hashtag_text']
        post.save_hashtag(hashtag_text)
        post.save_to_post_detail(post_id, hashtag_text)
    end

    # * Json
    def show_all_post_json
        posts = Post.get_all_post_json
    end

end