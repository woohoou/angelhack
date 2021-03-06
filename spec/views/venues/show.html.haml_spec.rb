require 'spec_helper'

describe "venues/show" do
  before(:each) do
    @venue = assign(:venue, stub_model(Venue,
      :name => "Name",
      :image => "Image",
      :description => "MyText",
      :latitude => 1.5,
      :longitude => 1.5,
      :address => "Address",
      :postalcode => "Postalcode",
      :city => "City",
      :state => "State",
      :country => "Country"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Image/)
    rendered.should match(/MyText/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/Address/)
    rendered.should match(/Postalcode/)
    rendered.should match(/City/)
    rendered.should match(/State/)
    rendered.should match(/Country/)
  end
end
