class LayoversController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :show, :user_layovers, 
                                                  :all, :update_layover, :delete_layover,
                                                  :get_airport_layovers, :get_city_layovers]

  def create
    @layover = current_user.layovers.new(user_id: params[:user_id], 
                                        arrival_time: params[:arrival_time],
                                        dept_time: params[:dept_time],
                                        city: params[:city],
                                        short_name: params[:short_name],
                                        display: true)
    if @layover.save
      render 'create.json.jbuilder', status: :created
    else 
      render json: { errors: @user.errors.full_messages },
      status: :unprocessable_entity
    end
  end

  def show
    @layover = current_user.layovers.find(params[:id])
    render 'show.json.jbuilder', status: :ok
  end

  def current_user_layovers
    @layovers = current_user.layovers.order(created_at: :desc).page(params[:page])
    if Layover?.any
      render 'user_layovers.json.jbuilder', status: :ok
    else
      render json: { message: 'There are no layovers to display.' },
        status: :unprocessable_entity
    end
  end

  def user_layover
    @layover = Layover.find_by( user_id: params[:user_id])
     if @ayover.any?
      render 'user_layover.json.jbuilder', status: :ok
    else
      render json: { message: 'There are no layovers to display.' },
        status: :unprocessable_entity
    end
  end

# arrival_overlaps = Layover.where(short_name: @layover.short_name).
#       where("arrival_time <= ? AND dept_time >= ?",
#         @layover.arrival_time, @layover.arrival_time + 2.hours)

# ("created_at >= :start_date AND created_at <= :end_date",
#   {start_date: params[:start_date], end_date: params[:end_date]})

  def user_airport
    @layovers = Layover.where("user_id = ? AND city = ? AND short_name = ?", params[:user_id],  params[:city],
                                       params[:short_name])
    binding.pry
     if @layovers.any?
      render 'user_layovers.json.jbuilder', status: :ok
    else
      render json: { message: 'There are no layovers to display.' },
        status: :unprocessable_entity
    end
  end

  def user_layovers_all
    @layovers = Layover.find_by( user_id: params[:user_id])
     if layovers.any?
      render 'user_layovers.json.jbuilder', status: :ok
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

  def airport_all
    @layovers = Layover.where("city = ? AND short_name = ?", 
                                params[:short_name]).page(params[:page])
    if @layovers.any?
      render 'all.json.jbuilder', status: :ok
    else
      render json: { message: "There are no layovers to display." },
        status: :not_found
    end
  end

  def arrival_all
     @layovers = Layover.where( "arrival_time = ? AND city = ? AND short_name = ?", 
                                  params[:arrival_time], params[:city], params[:short_name]).page(params[:page])
    if @layovers.any?
      render 'all.json.jbuilder', status: :ok
    else
      render json: { message: 'There are no layovers for this airport.' },
        status: :unprocessable_entity
    end
  end

  def edit_layover
      @layover = Layover.find(params[:id])
      render 'show.json.jbuilder', status: :ok
  end

  def update_layover
    @layover = Layover.find(params[:id])
    if @layover.user == current_user
      @layover.update
      render '.json.jbuilder', status: :ok
    else
      render json: { message: 'You must be logged in to edit this information.' },
        status: :unprocessable_entity
    end
  end

  def delete_layover
    @layover = Layover.find(params[:id])
    if @layover.user == current_user
      @layover.destroy
      render json: { message: 'Layover has been deleted'},
        status: :ok
    else
      render json: { message: 'The password you supplied is not correct' }
    end
  end
end
