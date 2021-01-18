require 'rails_helper'

describe 'user login' do
  it 'should login user' do
    user = User.create(email: "whatever@example.com", password: "1234", password_confirmation: "1234")

    user = { 
                  "email": "whatever@example.com",
                  "password": "1234",
    }

    post "/api/v1/sessions", params: user.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to be_successful
    expect(response.status).to eq(200)
    login_user = JSON.parse(response.body, symbolize_names: true)
    
    expect(login_user[:data][:attributes][:email]).to eq(user[:email])
    expect(login_user[:data][:attributes][:api_key]).to be_a(String)
  end

  it 'should return error if password is wrong' do
    user = User.create(email: "whatever@example.com", password: "1234", password_confirmation: "1234")

    user = { 
                  "email": "whatever@example.com",
                  "password": "password",
    }

    post "/api/v1/sessions", params: user.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    login_user = JSON.parse(response.body, symbolize_names: true)

    expect(login_user[:error]).to eq("Email or Password are Incorrect")
  end

  it 'should return error if email is wrong' do
    user = User.create(email: "whatever@example.com", password: "1234", password_confirmation: "1234")

    user = { 
                  "email": "anything@example.com",
                  "password": "1234",
    }

    post "/api/v1/sessions", params: user.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
    login_user = JSON.parse(response.body, symbolize_names: true)

    expect(login_user[:error]).to eq("Email or Password are Incorrect")
  end
end