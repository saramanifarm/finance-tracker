class FriendsController < ApplicationController
    


    def search
        if params[:friend].present?
            @friends = User.search(params[:friend])
            @friends = current_user.except_current_user(@friends)
            if @friends
                respond_to do |format|
                    format.js { render partial: 'users/friendsresult'}
                end
            else
                respond_to do |format|
                    flash.now[:alert] = "Friends not found"
                    format.js { render partial: 'users/friendsresult'}
                end
            end
        else
            respond_to do |format|
                flash.now[:alert] = "Please enter a name or email to search"
                format.js { render partial: 'users/friendsresult'}
            end
        end
    end


    def create
        friend = User.find(params[:friend])
        current_user.friendships.build(friend_id:friend.id)
        if current_user.save
            flash[:notice] = "friends was successfully followed...."
        else
            flash[:notice] = "There was something wrong with tracking request...."
        end
        redirect_to my_friends_path
    end

    def destroy
        
        unfriend = Friendship.where(user_id: current_user.id, friend_id: params[:user_id]).first
        unfriend.destroy
        flash[:notice] = "friends was successfully unfollowed...."
        redirect_to my_friends_path
     end


end
