require 'spec_helper'

describe Project do

  let(:project) { FactoryGirl.build(:project) }

  it "is not valid without a name" do
    project.name = ""
    project.should_not be_valid
  end


end