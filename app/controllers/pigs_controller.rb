class PigsController < ApplicationController
  # GET /pigs
  # GET /pigs.xml
  def index
    @title = t :'view.pigs.index_title'
    @pigs = Pig.order('tag ASC').paginate(
      :page => params[:page],
      :per_page => APP_LINES_PER_PAGE
    )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pigs }
    end
  end

  # GET /pigs/1
  # GET /pigs/1.xml
  def show
    @title = t :'view.pigs.show_title'
    @pig = Pig.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pig }
    end
  end

  # GET /pigs/new
  # GET /pigs/new.xml
  def new
    @title = t :'view.pigs.new_title'
    @pig = Pig.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pig }
    end
  end

  # GET /pigs/1/edit
  def edit
    @title = t :'view.pigs.edit_title'
    @pig = Pig.find(params[:id])
  end

  # POST /pigs
  # POST /pigs.xml
  def create
    @title = t :'view.pigs.new_title'
    @pig = Pig.new(params[:pig])

    respond_to do |format|
      if @pig.save
        format.html { redirect_to(pigs_path, :notice => t(:'view.pigs.correctly_created')) }
        format.xml  { render :xml => @pig, :status => :created, :location => @pig }
      else
        format.html { render :action => :new }
        format.xml  { render :xml => @pig.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pigs/1
  # PUT /pigs/1.xml
  def update
    @title = t :'view.pigs.edit_title'
    @pig = Pig.find(params[:id])

    respond_to do |format|
      if @pig.update_attributes(params[:pig])
        format.html { redirect_to(pigs_path, :notice => t(:'view.pigs.correctly_updated')) }
        format.xml  { head :ok }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @pig.errors, :status => :unprocessable_entity }
      end
    end

  rescue ActiveRecord::StaleObjectError
    flash.alert = t :'view.pigs.stale_object_error'
    redirect_to edit_pig_url(@pig)
  end

  # DELETE /pigs/1
  # DELETE /pigs/1.xml
  def destroy
    @pig = Pig.find(params[:id])
    @pig.destroy

    respond_to do |format|
      format.html { redirect_to(pigs_url) }
      format.xml  { head :ok }
    end
  end
end