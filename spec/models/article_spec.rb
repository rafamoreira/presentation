require 'rails_helper'

RSpec.describe Article, type: :model do
  before do
    @article = Article.new(title: "Article Title", content: "Article Content")
  end

  context "validations" do
    it "should be a valid object" do
      expect(@article).to be_valid
    end

    it "should not be valid without a title" do
      @article.title = nil

      expect(@article).to_not be_valid
      expect(@article.errors).to have_key(:title)
      expect(@article.errors.messages).to eq(:title=>["can't be blank"])
    end

    it "should not be valid without content" do
      @article.content = nil
      expect(@article).to_not be_valid
      expect(@article.errors).to have_key(:content)
      expect(@article.errors.messages).to eq(content: ["can't be blank"])
    end
  end

  context "associations" do
    it { should have_many(:comments).dependent(:destroy) }
  end
end
