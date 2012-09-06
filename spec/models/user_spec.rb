# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

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
