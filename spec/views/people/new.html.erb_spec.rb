require 'rails_helper'

RSpec.describe "people/new", type: :view do
  before(:each) do
    assign(:person, Person.new(
      :name => "MyString",
      :bio => "MyText",
      :age => 1
    ))
  end

  it "renders new person form" do
    render

    assert_select "form[action=?][method=?]", people_path, "post" do

      assert_select "input#person_name[name=?]", "person[name]"

      assert_select "textarea#person_bio[name=?]", "person[bio]"

      assert_select "input#person_age[name=?]", "person[age]"
    end
  end
end
