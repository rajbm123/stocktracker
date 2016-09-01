class UsersController < ApplicationController
  def my_portfolio
  	@user_stocks = current_user.stocks
  	@user = current_user
  end
  def my_friends
  	@my_friends = current_user.friends
  end

  def search
  	@users = User.search(params[:search_params])

  	if @users
  		@users = current_user.except_current_user(@users)
  		render partial: "friends/lookup"
  	else
  		render status: not_found, nothing: true
  	end
  end

  def add_friend
  	@friend = User.find(params[:friend])
  	current_user.friendships.build(friend_id: @friend.id)	
  	if current_user.save
  		redirect_to my_friends_path
  		flash[:success] = "Friend was successfully added"
  	else
  		redirect_to my_friends_path, flash[:danger]="There is an error"
  	end
  end

  def show
  	@user = User.find(params[:id])
  	@user_stocks = @user.stocks
  end

  def edit
    @user = User.find(params[:id])
  end

  def update

    @user = User.find(params[:id])
    if @user == current_user
      if @user.update(user_params)
        redirect_to edit_user_path
      else
        render edit_user_path
        flash[:danger] = "Something went wrong"
      end
      else
        redirect_to edit_user_path
        flash[:danger] = "Access Denied"
    end
   
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :avatar)
  end
end
