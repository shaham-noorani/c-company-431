class MemberActivitiesController < ApplicationController
  before_action :set_member_activity, only: %i[ show edit update destroy ]

  # GET /member_activities or /member_activities.json
  def index
    @member_activities = MemberActivity.all
  end

  # GET /member_activities/1 or /member_activities/1.json
  def show
  end

  # GET /member_activities/new
  def new
    @member_activity = MemberActivity.new
  end

  # GET /member_activities/1/edit
  def edit
  end

  # POST /member_activities or /member_activities.json
  def create
    @member_activity = MemberActivity.new(member_activity_params)

    respond_to do |format|
      if @member_activity.save
        format.html { redirect_to member_activity_url(@member_activity), notice: "Member activity was successfully created." }
        format.json { render :show, status: :created, location: @member_activity }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @member_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /member_activities/1 or /member_activities/1.json
  def update
    respond_to do |format|
      if @member_activity.update(member_activity_params)
        format.html { redirect_to member_activity_url(@member_activity), notice: "Member activity was successfully updated." }
        format.json { render :show, status: :ok, location: @member_activity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @member_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /member_activities/1 or /member_activities/1.json
  def destroy
    @member_activity.destroy

    respond_to do |format|
      format.html { redirect_to member_activities_url, notice: "Member activity was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member_activity
      @member_activity = MemberActivity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def member_activity_params
      params.require(:member_activity).permit(:user_id, :activity_id, :date, :time_spent)
    end
end
