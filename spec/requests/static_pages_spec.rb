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

		let(:heading)    { 'Sample App' }
    	let(:page_title) { '' }

   		it_should_behave_like "all static pages"
   		it { should_not have_selector 'title', text: '| Home' }
	end

	describe "Help page" do
		before { visit help_path } 

	  	let(:heading)    { 'Help' }
    	let(:page_title) { 'Help' }

   		it_should_behave_like "all static pages"
	end

	describe "About page" do
		before { visit about_path } 

	    let(:heading)    { 'About Us' }
    	let(:page_title) { 'About Us' }

   		it_should_behave_like "all static pages"
	end

	describe "Contact page" do
		before { visit contact_path } 

	    let(:heading)    { 'Contact Us' }
    	let(:page_title) { 'Contact Us' }

   		it_should_behave_like "all static pages"
	end

	it "should have the right links on the layout" do
		visit root_path
		click_link "About"
			page.should have_selector 'title', text: full_title('About Us')
		click_link "Help"
			page.should have_selector 'title', text: full_title('Help')
		click_link "Contact"
			page.should have_selector 'title', text: full_title('Contact Us')
		click_link "Home"
			page.should have_selector 'title', text: full_title('')
		click_link "Sign up now!"
			page.should have_selector 'title', text: full_title('Sign Up')
		click_link "sample app"
			page.should have_selector 'title', text: full_title('')
	end
end
