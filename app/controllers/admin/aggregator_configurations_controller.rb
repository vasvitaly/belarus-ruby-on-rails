class Admin::AggregatorConfigurationsController < ApplicationController
  load_and_authorize_resource

  def edit
    @aggregator_configuration = AggregatorConfiguration.find(params[:id])
  end

  def new
    @aggregator_configuration = AggregatorConfiguration.new
  end

  def index
    @aggregator_configurations = AggregatorConfiguration.paginate(:page => params[:page])
  end

  def destroy
    @aggregator_configuration = AggregatorConfiguration.find(params[:id])
    @aggregator_configuration.destroy
    redirect_to admin_aggregator_configurations_path, :notice => t('aggregator_configurations.successfully_deleted')
  end

  def create
    @aggregator_configuration = AggregatorConfiguration.new(params[:aggregator_configuration])
    respond_to do |format|
      format.html {
        if @aggregator_configuration.save
          redirect_to(admin_aggregator_configurations_path, :notice => t('aggregator_configurations.successfully_updated'))
        else
          render :action => "edit"
        end
      }
    end
  end

  def fetch
    require 'rss' unless defined?(RSS)
    RSS.fetch_aggregators
    redirect_to(admin_aggregator_configurations_path, :notice => t('aggregator_configurations.fetched'))
  end

  def update
    @aggregator_configuration = AggregatorConfiguration.find(params[:id])
    respond_to do |format|
      format.html {
        if @aggregator_configuration.update_attributes(params[:aggregator_configuration])
          redirect_to(admin_aggregator_configurations_path, :notice => t('aggregator_configurations.successfully_updated'))
        else
          render :action => "edit"
        end
      }
    end
  end
end
