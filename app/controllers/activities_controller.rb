class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[show edit update destroy]

  # GET /activities or /activities.json
  def index
    @activities = Activity.all
  end

  # GET /activities/1 or /activities/1.json
  def show; end

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit; end

  # POST /activities or /activities.json
  def create
    @activity = Activity.new(activity_params)

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render :show, status: :created, location: @activity }

      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @activity.errors, status: :unprocessable_entity) }
      end 
    end
  end


  def reassign
    @activity = Activity.find(params[:id])
    @platoons = Platoon.all
    @user = User.all

  end


  # POST /activities/1/assign_to_platoon
  def assign_to_platoon
    platoon = Platoon.find(params[:activity][:platoon_id])
    users_in_platoon = platoon.users
      
    users_in_platoon.each do |user|
      member_activites = MemberActivity.new(
        user_id: user.id,
        activity_id: @activity.id,
        date: nil,
        start_time: nil,
        end_time: nil
      )

      if member_activity.save
        redirect_to @activity, notice: 'Activity was successfully assigned to the platoon.'
      end
    end
  end



  # POST /activities/1/assign_to_user
  def assign_to_member



    member_activity = MemberActivity.new(
      user_id: user.id,
      activity_id: @activity.id,
      date: nil,
      start_time: nil,
      end_time: nil
    )
    if member_activity.save
      redirect_to @activity, notice: 'Activity was successfully assigned to the member.'
    end

  end


  def another_function
    user_id = params[:user_id]
    logger.info(user_id)
    logger.info(params[:activity_id])
    logger.info("!!!!!!!!!!!!!!!!!!!")

    @activity = Activity.find(params[:activity_id])

    member_activity = MemberActivity.new(
      user_id: user.id,
      activity_id: @activity.id,
      datetime.now: nil,
      start_time: nil,
      end_time: nil
    )

    if member_activity.save
      redirect_to @activity, notice: 'Activity was successfully assigned to the member.'
    end
  end



  def assign_member
    @user_id = params[:user_id]
    @users = User.all
    @activity = Activity.find(params[:activity_id])
    logger.info("works!!!!!!!!!!!!!!!!!!!!!")
    logger.info(params[:user_id])
  
    # Ensure params[:activity] is present
    if params[:user_id].present?
      user = User.find(params[:user_id])
      
      member_activity = MemberActivity.new(
        user_id: user.id,
        activity_id: @activity.id,
        date.now: nil,
        start_time: nil,
        end_time: nil
      )
  
      if member_activity.save
        redirect_to @activity, notice: 'Activity was successfully assigned to the member.'
      end
    end
  end
  


  def assign_platoon

    @activity = Activity.find(params[:activity_id])
    logger.info("platoon assign function accessed")
    logger.info(params[:platoon_id])

    if params[:platoon_id].present?
      platoon = Platoon.find(params[:platoon_id])
      users_in_platoon = platoon.users
        
      users_in_platoon.each do |user|
        member_activites = MemberActivity.new(
          user_id: user.id,
          activity_id: @activity.id,
          date: nil,
          start_time: nil,
          end_time: nil
        )

        if member_activity.save
          redirect_to @activity, notice: 'Activity was successfully assigned to the platoon.'
        end
      end
    end

  end 







  ## Creating and assigning in one action

  # def create
  #   @activity = Activity.new(activity_params)
  #   if @activity.save
  #     if params[:activity][:platoon_id] != ''
  #       logger.info "got to platoon"
  #       platoon = Platoon.find(params[:activity][:platoon_id])
  #       users_in_platoon = platoon.users
      
  #       users_in_platoon.each do |user|
  #         member_activites = MemberActivity.new(
  #           user_id: user.id,
  #           activity_id: @activity.id,
  #           date: nil,
  #           start_time: nil,
  #           end_time: nil
  #         )
  #         member_activities.save
  #       end

  #     elsif params[:activity][:user_id] != ''
  #       user = User.find(params[:activity][:user_id])
  #       logger.info "activity id: #{@activity.id}"
  #       member_activity = MemberActivity.new(
  #         user_id: user.id,
  #         activity_id: @activity.id,
  #         date: nil,
  #         start_time: nil,
  #         end_time: nil
  #       )
  #       logger.info("got to member activity save")
  #       member_activity.save

  #     end

  #     respond_to do |format|
  #       format.html { redirect_to(activity_url(@activity), notice: 'Activity was successfully created.') }
  #       format.json { render(:show, status: :created, location: @activity) }
  #     end
    
    
  #   else
  #     format.html { render(:new, status: :unprocessable_entity) }
  #     format.json { render(json: @activity.errors, status: :unprocessable_entity) }
  #   end
  # end




  # PATCH/PUT /activities/1 or /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to(activity_url(@activity), notice: 'Activity was successfully updated.') }
        format.json { render(:show, status: :ok, location: @activity) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @activity.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /activities/1 or /activities/1.json
  def destroy
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to(activities_url, notice: 'Activity was successfully destroyed.') }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_activity
    @activity = Activity.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def activity_params
    params.require(:activity).permit(:name, :description, :activity_type_id)
    
  end
end