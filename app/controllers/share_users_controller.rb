class ShareUsersController < ApplicationController
  before_filter :require_user, :only => [:set_read_state, :retrieve]

  def set_read_state
    share_user = ShareUser.find_by_share_id_and_user_id(params[:share_id], current_user.id)
    share_user.read_state = params[:state]
    share_user.last_viewed_at = Time.now.utc
    share_user.save

    respond_to do |format|
      format.js {"{'success': true}"}
    end
  end

  def retrieve
    #build the @shares query based on user preferences
    if "titleView" == params[:content_layout]
      shares = current_user.share_users.select("share_users.*, posts.title AS post_title, users.display_name AS display_name, users.email AS email, shares.summary as summary").joins(:share => [:post, :user])
    else
      shares = current_user.share_users.select("share_users.share_id, share_users.read_state").joins(:share)
    end

    if params[:content_sort] == "unreadOnly" then
      shares = shares.unread
    elsif params[:content_sort] == "favoriteContent" then
      shares = shares.favorite
    end

    shares = shares.where("share_users.read_state != ?", ShareUser::MUTED_STATE)

    if params[:content_order] == "oldestFirst" then
      shares = shares.oldest_to_newest
    else
      shares = shares.newest_to_oldest
    end

    shares = shares.limit(100);

    respond_to do |format|
      format.js { render :json => shares }
      format.html { render :json => shares }
    end
  end
end
