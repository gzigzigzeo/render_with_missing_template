require 'spec_helper'
describe "application/test.html.erb" do
  it "displays all cases" do
    render
    
    rendered.should match(/partial1/)
    rendered.should match(/partial2/)
  end
end