class CommentsController < ApplicationController
  def create
    comment = Comment.create(
      :share_id => params[:comment][:share_id],
      :user_id => current_user.id,
      :comment_text => params[:comment][:comment_text]
    )

    ShareUser.update_all("last_updated_at = now()", ["share_id = ? AND read_state = 1", params[:comment][:share_id]])
    ShareUser.update_all("read_state = 1, last_updated_at = now()", ["share_id = ? AND read_state = 0 AND user_id != ?", params[:comment][:share_id], current_user.id ])

    respond_to do |format|
      format.js {render :json => comment.to_json(
        :include => {
          :user => {}
        }
      )}
    end
  end

  def update
    comment = Comment.find_by_id(params[:comment_id])
    if current_user.id == comment.user_id
      comment.comment_text = params[:comment_text]
      comment.save

      ShareUser.update_all("last_updated_at = now()", ["share_id = ? AND read_state = 1", comment.share_id])
      ShareUser.update_all("read_state = 1, last_updated_at = now()", ["share_id = ? AND read_state = 0 AND user_id != ?", comment.share_id, current_user.id ])

      respond_to do |format|
        format.js {render :json => comment.to_json(
          :include => {
            :user => {}
          }
        )}
      end
    else
      respond_to do |format|
        format.js render :json => {"error" => "Unauthorized to edit this comment"}
      end
    end
  end
end
