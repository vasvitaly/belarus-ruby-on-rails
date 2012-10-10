class DraftsController < ApplicationController
  load_and_authorize_resource

  def index
    @drafts = Draft.where(:object_type => params[:object_type], :object_id => params[:object_id]).order("created_at DESC")

    respond_to do |format|
      format.json { render :json => @drafts }
    end
  end

  def show
    @draft = Draft.find_by_object_type_and_object_id(params[:object_type], params[:id])

    respond_to do |format|
      format.json { render :json => @draft }
    end
  end

  def create
    @draft = Draft.create(:object_type => params[:object_type], :object_id => params[:object_id], :draft_object => params[:draft_object])

    respond_to do |format|
      format.json { render :json => @draft }
    end
  end
end
