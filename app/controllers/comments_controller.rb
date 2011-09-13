class CommentsController < ApplicationController
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
 		@comment = Comment.new(params[:comment])
    if @comment.author.blank?
      @comment.author = "Anonym"
    end
		@comment.post = Post.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @div_id = "comment" + params[:id].to_s
  end
end
