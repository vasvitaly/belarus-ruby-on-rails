require 'spec_helper'

describe "custom_news/edit.html.erb" do
  before(:each) do
    @custom_news = assign(:custom_news, stub_model(CustomNews,
#      :name => "MyString",
      :title => "MyString",
      :content => "MyText"
    ))
  end

  it "renders the edit custom_news form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => custom_news_index_path(@custom_news), :method => "post" do
#      assert_select "input#custom_news_name", :name => "custom_news[name]"
      assert_select "input#custom_news_title", :name => "custom_news[title]"
      assert_select "textarea#custom_news_content", :name => "custom_news[content]"
    end
  end
end
