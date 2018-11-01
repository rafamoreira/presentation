require 'rails_helper'
include AuthHelper

RSpec.feature "Articles", type: :feature do
  before(:each) do
    basic_auth("admin", "password123")
  end

  context "New Article" do
    describe "Creating an Article with all required fields" do
      it "should save and redirect to the article" do
        visit "/articles/new"
        fill_in "Title", with: "My New Article"
        fill_in "Content", with: "Content of My New Article"
        expect{ click_button "Create Article" }.to change(Article, :count).by(1)
        expect(current_path).to eq "/articles/#{Article.last.id}"
        expect(page).to have_content "My New Article"
        expect(page).to have_content "Content of My New Article"
        expect(page).to have_css "h2", text: "My New Article"
      end
    end
    describe "Creating Articles without the required fields" do
      it "should not create an article without title" do
        visit "/articles/new"
        fill_in "Content", with: "Content of My New Article"
        click_button "Create Article"
        expect(current_path).to eq "/articles"
        expect(page).to have_content "Title can't be blank"
      end

      it "should not create an article without content" do
        visit "/articles/new"
        fill_in "Title", with: "My New Article"
        click_button "Create Article"
        expect(current_path).to eq "/articles"
        expect(page).to have_content "Content can't be blank"
      end
    end
  end

  context "Editing and deleting articles" do
    before do
      @article = Article.create(title: "My New Article", content: "Content of My New Article")
    end
    describe "Editing Articles" do
      it "should be able to edit the article title" do
        visit "/"
        click_link @article.title
        expect(page).to have_css "h2", text: @article.title
        click_link "Edit"
        fill_in "Title", with: "New title of my article"
        click_button "Update Article"
        expect(current_path).to eq "/articles/#{@article.id}"
        expect(page).to have_css "h2", text: "New title of my article"
      end

      it "should be able to edit the article content" do
        visit "/"
        click_link @article.title
        expect(page).to have_content @article.content
        click_link "Edit"
        fill_in "Content", with: "This is the new content of my article"
        click_button "Update Article"
        expect(current_path).to eq "/articles/#{@article.id}"
        expect(page).to have_content "This is the new content of my article"
      end
    end

    describe "delete articles" do
      it "should be able to delete an article" do
        visit "/"
        click_link @article.title
        expect{ click_link "Destroy" }.to change(Article, :count).by(-1)
        expect(current_path).to eq "/articles"
        expect(page).to_not have_content @article.title
      end
    end
  end
end
