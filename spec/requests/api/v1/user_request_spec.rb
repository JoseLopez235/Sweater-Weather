require 'rails_helper'

describe 'user imformation' do
  it 'should save user information' do
    user = { 
                  "email": "whatever@example.com",
                  "password": "password",
                  "password_confirmation": "password"
    }

    post "/api/v1/users", params: user.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to be_successful
    expect(response.status).to eq(201)
    user = JSON.parse(response.body, symbolize_names: true)

    expect(user[:data]).to be_a(Hash)
    expect(user[:data][:type]).to eq("users")
    expect(user[:data][:attributes][:email]).to eq("whatever@example.com")
    expect(user[:data][:attributes][:api_key]).to be_a(String)
  end

  it "should send error if email already exists" do
    User.create(email: "whatever@example.com", password: "1234", password_confirmation: "1234")
    user = { 
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    post "/api/v1/users", params: user.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    user = JSON.parse(response.body, symbolize_names: true)

    expect(user[0]).to eq("Email has already been taken")
  end

  it "should send error if password dont match" do
    user = { 
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password123"
    }

    post "/api/v1/users", params: user.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to_not be_successful

    user = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(400)

    expect(user[0]).to eq("Password confirmation doesn't match Password")
  end

  it "should send error if missing a field" do
    user = { 
      "password_confirmation": "password123"
    }

    post "/api/v1/users", params: user.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response).to_not be_successful

    user = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(400)

    expect(user[0]).to eq("Password can't be blank")
    expect(user[1]).to eq("Email can't be blank")
  end
end