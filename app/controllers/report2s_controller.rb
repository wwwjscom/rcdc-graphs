class Report2sController < ApplicationController
  # GET /report2s
  # GET /report2s.xml
  def index
	# Replace this code with a calendar selector (ie nothing goes in the controller)
    @report2s = Report2.all
    @report2 = Report2.new
  end

  # GET /report2s/1
  # GET /report2s/1.xml
  def show
	# Replace this code with something like this
	
	# Report2.new
	# for Market.all.date_for.between(start_date, end_date)
	# 	report2.add market
	
	@report2 = Report2.find(params[:id])
	
#	markets = Market.find(:all, :conditions => { :for_date => @report2.start_date..@report2.end_date })	
#	markets.each { |m| @report2.add m }

	sorted_markets = @report2.gather_markets
	@js2 = @report2.to_js(params[:kind] ||= :all)
	
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @report2 }
    end
  end

  # GET /report2s/new
  # GET /report2s/new.xml
  def new
    @report2 = Report2.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @report2 }
    end
  end

  # GET /report2s/1/edit
  def edit
    @report2 = Report2.find(params[:id])
  end

  # POST /report2s
  # POST /report2s.xml
  def create
    @report2 = Report2.new(params[:report2])

    respond_to do |format|
      if @report2.save
        format.html { redirect_to(@report2, :notice => 'Report2 was successfully created.') }
        format.xml  { render :xml => @report2, :status => :created, :location => @report2 }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @report2.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /report2s/1
  # PUT /report2s/1.xml
  def update
    @report2 = Report2.find(params[:id])

    respond_to do |format|
      if @report2.update_attributes(params[:report2])
        format.html { redirect_to(@report2, :notice => 'Report2 was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @report2.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /report2s/1
  # DELETE /report2s/1.xml
  def destroy
    @report2 = Report2.find(params[:id])
    @report2.destroy

    respond_to do |format|
      format.html { redirect_to(report2s_url) }
      format.xml  { head :ok }
    end
  end
end
