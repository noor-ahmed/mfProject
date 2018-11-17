class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  after_action :create_activity, only: [:update, :create]

  # GET /requests
  # GET /requests.json
  def index
    @requests = case current_user.role
                when 'general'
                  current_user.requests
                when 'hr_executive'
                  Request.where(status: ['open', 'hr_reviewed'])
                when 'hr_manager'
                  Request.where(status: 'hr_reviewed')
                end
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(request_params)
    @request.user = current_user

    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: 'Request was successfully created.' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_request
      @request = Request.find(params[:id])
    end

    def request_params
      params.require(:request).permit(:description, :status, :user_id)
    end

    def create_activity
      ActivityMonitor.create(user_id: current_user.id, action: request[:action])
    end
end
