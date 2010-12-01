require 'spec_helper'

describe ApplicationController do
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
end