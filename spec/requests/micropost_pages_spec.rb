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
      let(:micropost) { FactoryGirl.create(:micropost, user: user) }
      before do 
        valid_signin wrong_user
      end
      it "should not delete a micropost" do
        expect { delete micropost_path(micropost) }.not_to change(Micropost, :count).by(-1)
      end
    end
  end

  describe "micropost pagination" do

    before(:all) { 30.times { FactoryGirl.create(:micropost, user: user) } }
    after(:all)  { Micropost.delete_all }
    before do
      valid_signin user
    end

    describe "in user profile page" do
      before { visit user_path(user) }

      describe "should have pagination div" do
        it { should have_selector 'div', class: 'pagination' }
      end

      describe "should have microposts list" do
        it { should have_selector 'ol.microposts' }
      end

      describe "should have 10 microposts visible" do
        it { should have_selector 'ol li', count: 10 }
      end
    end

    describe "in home page" do
      before { visit root_path }

      describe "should have pagination div" do
        it { should have_selector 'div', class: 'pagination' }
      end

      describe "should have 5 microposts visible" do
        it { should have_selector 'ol li', count: 5 }
      end
    end
  end
end