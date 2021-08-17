require_relative '../models/user.rb'
class UserController 

    def show_index 
        renderer = ERB.new(File.read("./views/index.erb"))
        renderer.result(binding)
    end

    # * Json
    def show_all_users_json 
        users = User.get_all_user_json
    end

    def create_user_data(param)
        users = User.new({
            id_user: [],
            username: param['username'],
            email: param['email'],
            bio: param['bio']
        })

        users.save
    end

end