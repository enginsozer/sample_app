require 'spec_helper'

describe "Micropost pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:wrong_user) { FactoryGirl.create(:user) }
  before { valid_signin user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end

  describe "micropost destruction" do
    
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end

    describe "as wrong user" do
      before do 
        valid_signin wrong_user
        visit root_path
        delete micropost_path(micropost)
      end

      it "should not delete a micropost" do
        specify { response.should redirect_to(root_path) }     
        #expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end
  end
end