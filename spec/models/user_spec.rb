require 'spec_helper'

describe User do

	subject { user }

	describe "when there is no email" do
		let (:user) { FactoryGirl.build(:user, email: '') }
		it { should_not be_valid }
	end

	describe "when there is no password" do
		let (:user) { FactoryGirl.build(:user, password: '', password_confirmation: '') }
		it { should_not be_valid }
	end

	describe "when the password is too small" do
		password = 'a' * 5
		let (:user) { FactoryGirl.build(:user, password: password, password_confirmation: password) }
		it { should_not be_valid }
	end

	describe "when the password and password_confirmation doesn't match" do
		let (:user) { FactoryGirl.build(:user, password: 'password', password_confirmation: 'different_password') }
		it { should_not be_valid }
	end

end