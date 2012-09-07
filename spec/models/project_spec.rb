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

  describe "#destroy" do
    before { @my_project = FactoryGirl.create(:project) }

    it "should remove the project from the database" do
      expect { @my_project.destroy }.to change(Project, :count).by(-1)
    end

    it "should delete the Pages connected to it" do
      a_page = FactoryGirl.create(:page, project: @my_project)
      
      @my_project.destroy

      Page.find_by_id(a_page.id).should be_nil
    end

  end
end
