# frozen_string_literal: true

class PlatoonsController < ApplicationController
     before_action :set_platoon, only: %i[show edit update destroy]

     # GET /platoons or /platoons.json
     def index
          @platoons = Platoon.all
     end

     # GET /platoons/1 or /platoons/1.json
     def show; end

     # GET /platoons/new
     def new
          @platoon = Platoon.new
     end

     # GET /platoons/1/edit
     def edit; end

     # POST /platoons or /platoons.json
     def create
          @platoon = Platoon.new(platoon_params)

          respond_to do |format|
               if @platoon.save
                    format.html { redirect_to(platoon_url(@platoon), notice: 'Platoon was successfully created.') }
                    format.json { render(:show, status: :created, location: @platoon) }
               else
                    format.html { render(:new, status: :unprocessable_entity) }
                    format.json { render(json: @platoon.errors, status: :unprocessable_entity) }
               end
          end
     end

     # PATCH/PUT /platoons/1 or /platoons/1.json
     def update
          respond_to do |format|
               if @platoon.update(platoon_params)
                    format.html { redirect_to(platoon_url(@platoon), notice: 'Platoon was successfully updated.') }
                    format.json { render(:show, status: :ok, location: @platoon) }
               else
                    format.html { render(:edit, status: :unprocessable_entity) }
                    format.json { render(json: @platoon.errors, status: :unprocessable_entity) }
               end
          end
     end

     # DELETE /platoons/1 or /platoons/1.json
     def destroy
          @platoon.destroy!

          respond_to do |format|
               format.html { redirect_to(platoons_url, notice: 'Platoon was successfully destroyed.') }
               format.json { head(:no_content) }
          end
     end

  def my_platoon
    @current_user = User.find_by(email: session[":useremail"])
    @platoon = @current_user.platoon
    @members = @platoon.users
  end

  private

     # Use callbacks to share common setup or constraints between actions.
     def set_platoon
          @platoon = Platoon.find(params[:id])
     end

     # Only allow a list of trusted parameters through.
     def platoon_params
          params.require(:platoon).permit(:name, :leader_id)
     end
end
