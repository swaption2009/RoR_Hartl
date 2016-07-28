module ApplicationHelper

	def full_title(page = '')
		base = "Ruby on Rails Tutorial Sample App"
		full_title = page.empty? ? base : "#{page} | #{base}"
	end

end
