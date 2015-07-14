class LayoversController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :show, :user_layovers, 
                                                  :all, :update_layover, :delete_layover,
                                                  :get_airport_layovers, :get_city_layovers]

  def create
    @layover = current_user.layover.new(user_id: params[:user_id],
                                        arrival_time: params[:arrival_time],
                                        dept_time: params[:dept_time],
                                        city: params[:city],
                                        short_name: params[:short_name],
                                        display: params[:display],
                                        start_time: params[:start_time],
                                        end_time: params[:end_time])
    if @user.save
      render 'register.json.jbuilder', status: :created
    else 
      render json: { errors: @user.errors.full_messages },
      status: :unprocessable_entity
    end
  end

  def show
    @layover = current_user.layover.find(id: params[:id])
    render 'user.json.jbuilder', status: :ok
  end

  def user_layovers
    @layover = current_user.layover.order(created_at: :desc).page(params[:page])
    if @layovers.any?
      render 'users.json.jbuilder', status: :ok
    else
      render json: { message: 'There are no layovers to display.' },
        status: :unprocessable_entity
    end
  end

  def all
    @layovers = Layover.order(created_at: :desc).page(params[:page])
    if @layovers.any?
      render 'all.json.jbuilder', status: :ok
    else
      render json: { message: "There are no layovers to display." },
        status: :not_found
    end
  end

  def edit_layover
      @layover = Layover.find_by(id: params[:id])
      render 'login.json.jbuilder', status: :ok
    else 
      render json: { message: 'You must be logged in to edit this information.' },
        status: :unprocessable_entity
    
  end

  def update_layover
    @layover = Layover.find(params[:id])
    if @layover.user == current_user
      @layover.update
      render 'login.json.jbuilder', status: :ok
    else
      render json: { message: 'You must be logged in to edit this information.' },
        status: :unprocessable_entity
    end
    redirect_to post_path(@post)
  end

  def delete_layover
    @layover = Layover.find(params[:id])
    if @layover.user == current_user
      current_user.layover.destroy
      render json: { message: 'Layover has been deleted'},
        status: :ok
    else
      render json: { message: 'Password you supplied is not correct' }
    end
  end

  def get_airport_layovers
    @layovers = Layover.find_by(short_name: params[:short_name]).page(params[:page])
    if @layovers.any?
      render 'users.json.jbuilder', status: :ok
    else
      render json: { message: 'There are no layovers for this airport.' },
        status: :unprocessable_entity
    end
  end

  def get_city_layovers
    @layovers = Layover.find_by(city: params[:city]).page(params[:page])
    if @layovers.any?
      render 'users.json.jbuilder', status: :ok
    else
      render json: { message: 'There are no layovers for this city.' },
        status: :unprocessable_entity
    end
  end
end


