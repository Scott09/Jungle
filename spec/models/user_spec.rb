require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do

    context "Password:" do
  
      it "user should have password" do
        @user = User.create(name: "Scott", last_name: "Appleton", email: "example@example.com")
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
  
      it "User should have confirm password" do
        @user = User.create(name: "Scott", last_name: "Appleton", email: "example@example.com", password: "1234")
        expect(@user.valid?).to eq(false)
        expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
      end
  
  
      it "Password should have minimum length of 4 characteres" do
        @user = User.create(name: "Scott", last_name: "Appleton", email: "example@example.com", password: "123")
        expect(@user.valid?).to eq(false)
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")
      end
  
    end
  
    context "Email:" do
  
      it "User should have email" do
        @user = User.create(name: "Scott", last_name: "Mill", password: "1234")
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
  
      it "Email should be unique" do
        @user = User.create(name: "Scott", last_name: "Appleton", email: "example@example.com", password: "1234")
        expect(@user.valid?).to eq(true)
        @user2 = User.create(name: "Scott", last_name: "Appleton", email: "example@example.com", password: "1234")
        expect(@user2.valid?).to eq(false)
        expect(@user2.errors.full_messages).to include("Email has already been taken")
      end
  
    end
  
    context "Name:" do
  
      it "User should have first name" do
        @user = User.create(last_name: "Appleton", email: "example@example.com
        ", password: "1234")
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
  
      it "User should have last name" do
        @user = User.create(name: "Appleton", email: "example@example.com
        ", password: "1234")
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
  
    end
  
  end
  
  describe '.authenticate_with_credentials' do
  
    it "User should login with the correct password" do
        @user = User.create(name: "Scott", last_name: "Appleton", email: "example@example.com
        ", password: "1234")
        expect(User.authenticate_with_credentials("example@example.com
        ", "1234").present?).to eq(true)
    end
  
    it "User should not login with the wrong password" do
        @user = User.create(name: "Scott", last_name: "Appleton", email: "example@example.com
        ", password: "1234")
        expect(User.authenticate_with_credentials("example@example.com
        ", "12345").present?).to eq(false)
    end
  
    it "User should login with spaces before email" do
        @user = User.create(name: "Scott", last_name: "Appleton", email: "example@example.com
        ", password: "1234")
        expect(User.authenticate_with_credentials(" example@example.com
        ", "1234").present?).to eq(true)
    end
  
    it "User should login with spaces after email" do
        @user = User.create(name: "Scott", last_name: "Appleton", email: "example@example.com
        ", password: "1234")
        expect(User.authenticate_with_credentials("example@example.com
         ", "1234").present?).to eq(true)
    end
  
    it "Email should be case insenitive" do
      @user = User.create(name: "Scott", last_name: "Appleton", email: "eXample@example.com", password: "1234")
      expect(User.authenticate_with_credentials("EXAMPLe@example", "1234").present?).to eq(true)
    end
  
  end

end
