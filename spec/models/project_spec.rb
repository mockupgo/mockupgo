# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Project do

  let(:project) { FactoryGirl.build(:project) }

  it "is not valid without a name" do
    project.name = ""
    project.should_not be_valid
  end


end
