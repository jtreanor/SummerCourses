class MessageMailer < ActionMailer::Base
	default :from => "message@summercourses.herokuapp.com"
	 
	  def message
	    @url  = "http://summercourses.herokuapp.com/"
	    mail(:to => "jtreanor3@gmail.com", :subject => "Welcome to My Awesome Site")
	  end
	end
end
