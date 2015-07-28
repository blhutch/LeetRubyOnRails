class UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:get_user, :get_users, :delete_user, :get_current_user]

  def get_current_user
    render json: current_user.as_json(except: [:password]), status: :ok
  end

  def register
    passhash = self.password_encryption(params[:password])
    @user = User.new(user_name: params[:user_name],
                      email: params[:email],
                       password: passhash,
                      first_name: params[:first_name],
                      last_name: params[:last_name],
                     avatar_url: params[:avatar_url],
                     linked_in_url: params[:linked_in_url],
                     phone_number: params[:phone_number])
    if @user.save
      render 'register.json.jbuilder', status: :created
      OurMailer.welcome_email(@user).deliver_now
    else 
      render json: { errors: @user.errors.full_messages },
      status: :unprocessable_entity
    end
  end

  def login
    passhash = self.password_encryption(params[:password])
    @user = User.find_by(user_name: params[:user_name], password: passhash)
    if @user
      render 'login.json.jbuilder', status: :created
    else 
      render json: { message: 'The username or password you supplied is incorrect.' },
        status: :unprocessable_entity
    end
  end

  def get_users
    @users = User.order(created_at: :desc).page(params[:page])
    if @users.any?
      render 'users.json.jbuilder', status: :ok
    else
      render json: { message: 'There are no users to display.' },
        status: :unprocessable_entity
    end
  end

  def get_user
    @user = User.find_by(id: params[:id])
    if @user
       render 'users.json.jbuilder', status: :ok
    else
      render json: { message: "There is no user to display with that user id." },
      status: :not_found
    end
  end

  def delete_user
    passhash = self.password_encryption(params[:password])
    if passhash == current_user.password
      current_user.destroy
      render json: { message: 'User has been deleted'},
        status: :ok
    else
      render json: { message: 'Password you supplied is not correct' }
    end
  end

  protected
  def password_encryption(password)
    if password.present?
      result = Digest::SHA1.hexdigest(password)
    else
      result = nil
    end
    result
  end
end
