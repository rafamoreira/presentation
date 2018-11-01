require 'rails_helper'

RSpec.feature "Comments", type: :feature do
  context "comments feature" do
    before do
      @article = Article.create(title: "My New Article", content: "My New Article Content")
    end

    describe "submiting a comment" do
      it "should allow to create with all required fields" do
        visit "/articles/#{@article.id}"
        fill_in "Name", with: "Commentator"
        fill_in "Email", with: "email@example.com"
        fill_in "Content", with: "This is a nice comment!"
        expect { click_button "Create Comment" }.to change(Comment, :count).by(1)
        expect(current_path).to eq "/articles/#{@article.id}"
        expect(page).to have_content "Commentator"
        expect(page).to have_content "This is a nice comment!"
        expect(page).to_not have_content "email@example.com"
      end

      it "should not allow creating a comment without Name" do
        visit "/articles/#{@article.id}"
        fill_in "Email", with: "email@example.com"
        fill_in "Content", with: "This is a nice comment!"
        click_button "Create Comment"
        expect(current_path).to eq "/comments"
        expect(page).to have_content "Name can't be blank"
      end

      it "should not allow creating a comment without Email" do
        visit "/articles/#{@article.id}"
        fill_in "Name", with: "Commentator"
        fill_in "Content", with: "This is a nice comment!"
        click_button "Create Comment"
        expect(current_path).to eq "/comments"
        expect(page).to have_content "Email can't be blank"
      end

      it "should not allow creating a comment without Email" do
        visit "/articles/#{@article.id}"
        fill_in "Name", with: "Commentator"
        fill_in "Email", with: "email@example.com"
        click_button "Create Comment"
        expect(current_path).to eq "/comments"
        expect(page).to have_content "Content can't be blank"
      end
    end

    describe "Managing comments" do
      before do
        @comment = @article.comments.create(name: "Commentator", email: "email@example.com",
                                            content: "some nasty comment")
      end
      describe "logged user" do
        before do
          basic_auth("admin", "password123")
        end
        it "should allow a logged user to delete a comment" do
          visit "/articles"
          click_link @article.title
          expect { click_link("Delete Comment") }.to change(Comment, :count).by(-1)
          expect(current_path).to eq "/articles/#{@article.id}"
          expect(page).to_not have_content "some nasty comment"
        end
      end

      describe "non logged user" do
        it "should not be able to delete a comment" do
          visit "/articles"
          click_link @article.title
          click_link "Delete Comment"
          expect(page).to have_content "HTTP Basic: Access denied."
        end
      end
    end
  end
end
