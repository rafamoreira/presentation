require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @article = Article.create(title: "test article", content: "test article content")
    @comment = @article.comments.create(name: "commentator",
                                        email: "email@example.com",
                                        content: "content")
  end

  subject { @comment }

  context "associations" do
    it { should belong_to :article }
  end

  context "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :content }
  end
end
