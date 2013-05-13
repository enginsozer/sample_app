module GlobalSpecModule
	
	def define_heading_and_title(heading, title)
		let(:heading)    { heading }
		let(:page_title) { title }
	end

	def check_heading_and_title(heading, title)
		it { should have_selector('h1',    text: heading) }
		it { should have_selector('title', text: title) }
	end

	def visit_and_check_title(link, title)
		click_link link
		page.should have_selector 'title', text: full_title(title)
	end

end