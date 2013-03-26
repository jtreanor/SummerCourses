ActiveAdmin.register Video do
  form :html => { :enctype => "multipart/form-data" } do |f|
   	f.inputs "Details" do
   		f.input :description
    	f.input :url, :label => "Video URL", :input_html => {:rows => 1}, :hint => "Video from YouTube, Vimeo or Dailymotion is supported."
    end
  	f.buttons
 end  
end
