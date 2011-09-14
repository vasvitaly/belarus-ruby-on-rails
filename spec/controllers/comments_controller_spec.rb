require 'spec_helper'

describe CommentsController do
  before :each do
    (@post = Post.new({title: "Title", text: "Post's text"})).save
    (@comment = Comment.new({ body: "I'm a first comment", post: @post})).save
  end

  it "should render edit template on edit action" do
    xhr :get, :edit, { id: @comment.id }
    response.should render_template "comments/edit"
  end

  it "should render update template on update action by ajax" do
    xhr :get, :update, { id: @comment.id, comment: { body: "new text" } }
    response.should render_template "comments/update"
  end

  it "should update comment on update action by ajax" do
    xhr :get, :update, { id: @comment.id, comment: { body: "new text" } }
    Comment.find(@comment.id).body.should_not be_eql("I'm a first comment")
  end

  it "should not update comment on update action by ajax with invalid comment's body" do
    xhr :get, :update, { id: @comment.id, comment: { body: "+1" } }
    Comment.find(@comment.id).body.should be_eql("I'm a first comment")
  end

  it "should render destroy template on destroy action by ajax" do
    xhr :get, :destroy, { id: @comment.id }
    response.should render_template "comments/destroy"
  end

  it "should delete the comment on destroy action by ajax" do
    xhr :get, :destroy, id: @comment.id
    false.should be_eql(Comment.exists? @comment)
  end

  it "should render create template on create action by ajax" do
    xhr :get, :create, comment: { author: "Author", body: "I'm a Test comment"}, id: @post.id
    response.should render_template "comments/create"
  end

  it "should create comment on create action by ajax" do
    comments_count = (Comment.find :all).length
    xhr :get, :create, comment: { author: "Author", body: "I'm a Test comment"}, id: @post.id
    comments_count.should_not be_eql((Comment.find :all).length)
  end

  it "can't create a comment if comment body is invalid on create action by ajax" do
    comments_count = (Comment.find :all).length
    xhr :get, :create, comment: { body: "+1"}, id: @post.id
    comments_count.should be_eql((Comment.find :all).length)
  end
end