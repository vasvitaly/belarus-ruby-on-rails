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
    respond_to do |wants|
      wants.js do
        render :update do |page|
          if not (newbody = params[:comment][:body]).empty?
            @comment.body = newbody
            page.replace_html "comment" + @comment.id.to_s, :partial => "comments/show", :collection => [@comment]
            if @comment.save
              page.replace_html "commentnotice", "Comment " + @comment.id.to_s + " was successfully changed"
            else
              page.replace_html "commentnotice", "Comment " + @comment.id.to_s + " not changed"
            end
          else
            page.replace_html "commentnotice", "Write something"
          end
        end
      end
    end
  end

  def create
 		@comment = Comment.new(params[:comment])
    if @comment.author.blank?
      @comment.author = "Anonym"
    end
		@comment.post = Post.find(params[:id])
    if @comment.body != nil and not @comment.body.empty? and @comment.save
			respond_to do |wants|
  			wants.js do
	  			render :update do |page|
  					page.insert_html :top, "comments", :partial => 'comments/show', :collection => [@comment]
  					page.replace_html "commentnotice", "Your comment was succesfully added!"
  					page['comment_body'].clear
  					page['comment_author'].clear
  				end
  			end
  		end
		else
      respond_to do |wants|
        wants.js do
          render :update do |page|
            page.replace_html "commentnotice", "<p id='commentbodyerror'>You don't write comment</p>"
          end
        end
      end
    end
  end

  def update
    @comment = Comment.find(params[:id])
    respond_to do |wants|
      wants.js do
        render :update do |page|
          page.replace_html "comment" + @comment.id.to_s, :partial => "comments/update"
        end
      end
    end
  end

  def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      respond_to do |wants|
        wants.js do
          render :update do |page|
            page.remove("comment" + params[:id].to_s)
            page.replace_html "commentnotice", "Comment " + params[:id].to_s + " was succesfully destroyed"
          end
        end
      end
  end
end
