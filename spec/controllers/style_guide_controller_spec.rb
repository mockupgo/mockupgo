require 'spec_helper'

describe StyleGuideController do

  describe "GET 'annotation'" do
    it "returns http success" do
      get 'annotation'
      response.should be_success
    end
  end

end
