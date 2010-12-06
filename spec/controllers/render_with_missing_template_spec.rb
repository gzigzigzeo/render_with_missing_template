require 'spec_helper'

describe ApplicationController do
  render_views
  it "should render show action if index template missing" do
    get :index
    response.should render_template("show")
  end
  
  it "should not render index action if show template exists" do
    get :index1
    response.should render_template("show")
  end  

  it "should not raise exception if :default => false" do
    proc { get :index2 }.should_not raise_error
  end  
  
  it "should raise an error if both default & if_missing templates are not found" do
    proc { get :index3 }.should raise_error
  end
  
  it "should raise an error if controller template found && partial not found" do  
    lambda { get :index4 }.should raise_error
  end
  
  it "should raise TemplateError if deeply nested template not found" do
    lambda { get :nested }.should raise_error    
  end
end