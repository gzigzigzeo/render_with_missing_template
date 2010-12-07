require 'spec_helper'

describe ApplicationController do
  render_views
  
  it "should render show action if index template missing" do
    get :regular_missing
    response.should render_template("show")
  end
  
  it "should not render index action if show template exists" do
    get :not_missing
    response.should render_template("show")
  end  

  it "should not raise exception if :default => false" do
    proc { get :suspend_missing_error }.should_not raise_error
  end  
  
  it "should raise an error if both default & if_missing templates are not found" do
    proc { get :all_missing }.should raise_error
  end
    
  it "should raise an error if controller template found && partial not found" do  
    lambda { get :error_in_regular }.should raise_error
  end

  
  it "should raise error if it raises in nested template" do
    lambda { get :nested }.should raise_error
  end

  it "should raise error if it raises in nested missing template" do
    lambda { get :all_missing, :if_missing => {:action => :nested} }.should raise_error
  end
end