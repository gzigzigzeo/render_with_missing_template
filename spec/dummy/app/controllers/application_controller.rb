class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def regular_missing
    render :if_missing => {:action => :show}
  end
  
  def not_missing
    render :action => "show", :if_missing => {:action => :index}
  end

  def suspend_missing_error
    render :if_missing => false
  end
  
  def all_missing
    render :partial => "nano", :if_missing => {:template => "notfound"}
  end
  
  def error_in_regular
    render :if_missing => {:template => "notfound"}
  end
  
  def nested    
  end
  
  def missing_with_template_and_layout
    render :content_type => "text/html", :format => :html, :layout => 'iframe', :if_missing => {:template => "iframe/iframe"}    
  end
end
