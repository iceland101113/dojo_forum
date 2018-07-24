require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :controller do

  it "login via email and password" do
    user = create(:user, email: '123@gmail.com', password: '123123')
    post "login", params: { email: user.email, password: '123123' }

    expect(response).to have_http_status(200)
    expect(JSON.parse(response.body)).to eq({
      'message' => 'Ok',
      'auth_token' => user.authentication_token,
      'user_id' => user.id
    })
  end

  it "logout succesfully" do
    user = create(:user, email: '123@gmail.com', password: '123123')
    token = user.authentication_token

    post "logout", params: { auth_token: user.authentication_token }

    expect(response).to have_http_status(200)
    user.reload
    expect(user.authentication_token).not_to eq(token)
  end
end