class CommentsController < ApplicationController
  def edit
    @comment = Comment.find(params[:id])
  end

  def create
 		@comment = Comment.new(params[:comment])
    if @comment.author.blank? or @comment.author.empty?
      @comment.author = "Anonym"
    end
		@comment.custom_news = CustomNews.find params[:id]
    if not @comment.body.blank? and not @comment.body.empty?  and @comment.save
      @saved = true
    else
      @saved = false
    end
  end

  def update
    @saved = false
    @comment = Comment.find(params[:id])
    if not (new_body = params[:comment][:body]).empty?
        @comment.body = new_body
        if @comment.save
          @saved = true
          @notify = "Comment #{ params[:id] } was successfully changed"
        else
          @notify = "Comment #{ params[:id] } body is too little. Its length must be grater then 4"
        end
    else
      @notify = "Write something"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @div_id = "comment" + params[:id].to_s
  end
end