require '../../db/mysql_connector.rb'
require_relative '../../controllers/user_controller.rb'
require_relative '../../models/user.rb'

describe UserController do
    
    describe '#save_user' do
        context 'when user want to save data' do
            it 'should be saved' do
                params = {
                    'username' => 'gdamerta',
                    'email' => 'email@gmail.com',
                    'bio' => 'Isi bio'
                }
                controller = UserController.new
                controller.create_user_data(params)
                response = User.get_users

                expect(response.size).to eq(1)
            end
        end
    end

end