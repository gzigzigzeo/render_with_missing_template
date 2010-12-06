class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def index
    render :if_missing => {:action => :show}
  end
  
  def index1
    render :action => "show", :if_missing => {:action => :index}
  end

  def index2
    render :if_missing => false
  end
  
  def index3
    render :partial => "nano", :if_missing => {:template => "notfound"}
  end
  
  def index4
    render :if_missing => {:template => "notfound"}
  end
  
  def nested    
  end
end
