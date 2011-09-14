Given /^I am logged in$/ do
end

Given /^I have (\d+) custom news article$/ do |arg1|
  Post.delete_all
  arg1.to_i.times do
    Post.new({title: "Title", text: "Post's text"}).save
  end
  @post = Post.first
end

Given /^I have no comments$/ do
  Post.all.each do |post|
    post.comments.delete_all
  end
end

Given /^I have (\d+) comment for custom news article "([^"]*)"$/ do |arg1, arg2|
  Post.delete_all
  Post.new({ title: arg2, text: "post body" }).save
  @post = Post.find_by_title arg2
  @post.comments.delete_all
  arg1.to_i.times do
    Comment.new({ body: "I'm a test comment", post: (Post.find @post.id)}).save
  end
end

When /^I am on custom news path for "([^"]*)"$/ do |arg1|
  @post = Post.find_by_title arg1
end

When /^(?:|I )follow "Delete comment"$/ do
  (Post.find @post.id).comments[0].delete
end

When /^(?:|I )follow "Add comment"$/ do
  Comment.new({ body: "I'm a test comment", post: @post}).save
end

When /^(?:|I )fill in "Message" with "([^"]*)"$/ do |value|
  (Post.find @post.id).comments[0].body = value
  (Post.find @post.id).comments[0].save
end

Then /^I should have no comments$/ do
  (Post.find @post.id).comments.length.should be_eql(0)
end

Then /^I should have (\d+) comment$/ do |arg1|
  (Post.find @post.id).comments.length.should be_eql(arg1.to_i)
end
