class CommentsController < ApplicationController
	require 'action_view'
	include ActionView::Helpers::DateHelper
	def create
		commentable = commentable_type.constantize.find(commentable_id)
		@comment = Comment.build_from(commentable, current_user.id, body)
		@comment.tag_list = comment_params[:tag_list]
		respond_to do |format|
			if @comment.save
			make_child_comment
			format.html  { redirect_to(:back, :notice => 'Comment was successfully added.') }
			else
			format.html  { redirect_to(:back, :notice => 'Failed to add comment.') }
			end
		end
	end

	def upvote
		@comment = Comment.find(params[:id])
	  @comment.upvote_by current_user
	  check_quests
	  redirect_to :back
	end

	def downvote
		@comment = Comment.find(params[:id])
	  @comment.downvote_by current_user
	  check_quests
	  redirect_to :back
	end

	def check_quests
    Quest.where(user_id: current_user.id).find_each do |quest|
      if quest.name == "Vote" and quest.state == "incomplete"
        quest.complete_quest
      end
    end
  end

	private

	def comment_params
		params.require(:comment).permit(:body, :tag_list, :commentable_id, :commentable_type, :comment_id)
	end

	def commentable_type
		comment_params[:commentable_type]
	end

	def commentable_id
		comment_params[:commentable_id]
	end

	def comment_id
		comment_params[:comment_id]
	end

	def body
		comment_params[:body]
	end

	def make_child_comment
		return "" if comment_id.blank?

		parent_comment = Comment.find comment_id
		@comment.move_to_child_of(parent_comment)
	end
end
