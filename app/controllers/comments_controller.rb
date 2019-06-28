class CommentsController < ApplicationController
  def create
    @request = Request.find(params[:request_id])
    params[:comment][:author] = if session[:admin]
                                  'admin'
                                else
                                  @request.name
                                end
    comment = @request.comments.build(comment_params)
    if session[:token] == @request.token || session[:admin]
      redirect_to request_path(@request.id) if comment.save
    end
  end

  def update
    comment.update(comment_params) if session[:token] == @request.token
    render 'requests/show'
  end

  def destroy
    @request = Request.find(params[:request_id])
    comment.destroy if (session[:token] == @request.token && comment.author != 'admin') || (session[:admin] && comment.author == 'admin')
    redirect_to request_path(@request.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:author, :text, :request_id)
  end

  def comment
    @comment ||= Comment.find_by(id: params[:id])
    @comment ||= Comment.new
  end
end
