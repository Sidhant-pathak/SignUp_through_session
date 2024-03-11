class CommentsController < ApplicationController
  before_action :find_post


  def create
    # binding.pry

      # @parent_comment = Comment.find_by(id: comment_params[:parent_id])
      # @parent_comment = Comment.find(params[:parent_id])
      # @comment = @parent_comment.replies.build(comment_params)
      #


        @comment = @post.comments.build(comment_params)

      if @comment.save

        redirect_to @post, notice: 'Comment created successfully.'
        # redirect_to @parent_comment.post, notice: 'Reply added successfully.'

     else
        redirect_to @post, alert: 'Failed to create comment.'
        # render :new
    end
 end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
  
    if @post.comments.include?(@comment)
      if @comment.destroy
        redirect_to @post, notice: 'Comment deleted successfully.'
      else
        redirect_to @post, alert: 'Failed to delete comment.'
      end
    else
      redirect_to @post, alert: 'Failed to delete comment.'
    end
  end

  # def new
  #   @comment = Comment.new
  #   @parent_comment = Comment.find(params[:parent_id])
  #   @post = @parent_comment.post
  # end

  private

  def find_post
    if params[:post_id].present?
      @post = Post.find(params[:post_id])
    else
      @post = Post.find(params[:id])
    end
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id,:parent_id)
  end
end
