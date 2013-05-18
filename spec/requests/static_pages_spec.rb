require 'spec_helper'

describe "Static Pages" do

	let(:base_title) {"Ruby on Rails Tutorial Sample App"}
	subject { page }

	shared_examples_for "all static pages" do
		it { should have_selector('h1',    text: heading) }
		it { should have_selector('title', text: full_title(page_title)) }
	end
  
	describe "Home page" do
		before { visit root_path } 
		#Instead of before, before(:each) can also be used which are synonyms.

	    #it "should have the h1 content 'Sample App'" do
	    	# Run the generator again with the --webrat flag if you want to use webrat methods/matchers
	    #	page.should have_selector('h1', text: 'Sample App')
	    #end
	    #it { should have_selector('h1', text: 'Sample App') }

	    #it "should have the base title" do
	    #	page.should have_selector('title',
	    #                    text: "#{base_title}")
	    #end
	    #Simplified version below
	    #it { should have_selector 'title',
        #                text: "#{base_title}" }
        #As we added the helper under support directory, we can now use the full_title method itself here.
        #it { should have_selector 'title',
        #                text: full_title('') }

		#it "should not have a custom page title" do
		#	page.should_not have_selector('title', text: '| Home')
		#end
		#it { should_not have_selector 'title', text: '| Home' }

		define_heading_and_title('Sample App', '')

   		it_should_behave_like "all static pages"
   		it { should_not have_selector 'title', text: '| Home' }

		describe "for signed-in users" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
				FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
				valid_signin user
				visit root_path
			end

			it "should render the user's feed" do
				user.feed.each do |item|
					page.should have_selector("li##{item.id}", text: item.content)
				end
			end
		end
	end

	describe "Help page" do
		before { visit help_path } 

	  	define_heading_and_title('Help','Help')

   		it_should_behave_like "all static pages"
	end

	describe "About page" do
		before { visit about_path } 

	    define_heading_and_title('About Us','About Us')

   		it_should_behave_like "all static pages"
	end

	describe "Contact page" do
		before { visit contact_path } 

	    define_heading_and_title('Contact Us','Contact Us')

   		it_should_behave_like "all static pages"
	end

	it "should have the right links on the layout" do
		visit root_path
		visit_and_check_title('About','About Us')
		visit_and_check_title('Help','Help')
		visit_and_check_title('Contact','Contact Us')
		visit_and_check_title('Home','')
		visit_and_check_title('Sign up now!','Sign Up')
		visit_and_check_title('sample app','')
	end
end
