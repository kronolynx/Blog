class UsersController < ApplicationController
   before_action :set_user, only: [:edit, :update, :show]
   before_action :require_same_user, only: [:edit, :update]

   def index
      @users = User.paginate(page: params[:page], per_page: 5)
   end

   def new
      @user = User.new
   end

   def create
      @user = User.new(user_params)
      if @user.save
         flash[:success] = "welcome to the alpha blog #{@user.username}"
         redirect_to articles_path
      else
         render 'new'
      end
   end

   def edit
      #before action replacing this
      #@user = User.find(params[:id])
   end

   def update
      #before action replacing this
      #@user = User.find(params[:id])
      if @user.update(user_params)
         flash[:success] = "Account successfully updated"
         redirect_to articles_path
      else
         render 'edit'
      end
   end

   def show
      #before action replacing this
      #@user = User.find(params[:id])
      @user_articles = @user.articles.order(updated_at: :desc).paginate(page: params[:page], per_page: 5)
   end

   private
   def user_params
      params.require(:user).permit(:username, :email, :password)
   end

   def set_user
     @user = User.find(params[:id])
   end

   def require_same_user
      if !logged_in? || current_user != @user
        flash[:danger] = "You can only edit your own account"
        redirect_to root_path
      end
   end
end