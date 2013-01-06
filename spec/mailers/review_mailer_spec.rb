require "spec_helper"

describe ReviewMailer do
  describe "reviewed_notice" do
    let(:mail) { ReviewMailer.reviewed_notice }

    it "renders the headers" do
      mail.subject.should eq("Reviewed notice")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
