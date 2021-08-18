require_relative '../test_helper.rb'
require 'mysql2'
require_relative '../../models/user.rb'

describe User do

    describe '#valid' do
        context 'when initialiazed with valid input' do
            it 'should return true' do
                user = User.new({
                    id_user: 1,
                    username: 'gdamerta',
                    email: 'amerta@gmail.com',
                })
                expect(user.valid?).to eq(true)
            end
        end
    end

    describe '#user_data' do
        context 'when user save data' do
            it 'should save user data' do
                user = User.new({
                    id_user: [],
                    username: "gdamerta",
                    email: "amerta@gmail.com",
                    bio: "I'm a softboy"
                })

                insert_query = "INSERT INTO users (username, email, bio) VALUES ('#{user.username}', '#{user.email}', '#{user.bio}')"

                dummby_db = double
                allow(Mysql2::Client).to receive(:new).and_return(dummby_db)
                expect(dummby_db).to receive(:query).with(insert_query)

                user.save
            end
        end
    end
end