class CommentsController < ApplicationController
  def create
    @request = Request.find(params[:request_id])
    comment = @request.comments.build(comment_params)
    render 'requests/show' if comment.save
  end

  def update
    comment.update(comment_params)
    render 'requests/show'
  end

  def destroy
    @request = Request.find(params[:request_id])
    comment.destroy
    redirect_to request_path(@request.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:autor, :text, :request_id)
  end

  def comment
    @comment ||= Comment.find_by(id: params[:id])
    @comment ||= Comment.new
  end
end
