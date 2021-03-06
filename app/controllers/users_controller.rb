class UsersController < ApplicationController

  before_action :set_user, only: [:show, :update, :destroy, :posts]
  before_action :authenticate_user!, except: [:create, :posts, :login]

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  def posts
    @posts = @user.posts.all
    render json: @posts
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    return head :unprocessable_entity unless (User.new.attributes.keys.any? {|key| user_params.keys.include?(key) })

    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  def login
    user = User.find_by(email: user_params[:email]).try(:authenticate, user_params[:password])
    return head :unauthorized unless user.present?
    token = JsonWebToken.encode(user.slice(:id, :name, :email))
    if (Session.find_by(user: user, agent: request.user_agent, token: token).present?)
      Session.find_by(user: user, agent: request.user_agent, token: token).touch
    else
      Session.create(user: user, agent: request.user_agent, token: token)
    end
    render json: {token: token}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      return head :unauthorized unless @user.present?
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end
