class RequestsController < ApplicationController
  def index
    @massage = 'Ведіть ід та ключ'
  end

  def find
    @request = Request.find_by_id(params[:id])
    if @request && @request.token == params[:token]
      redirect_to request_path(@request.id)
    else
      @massage = 'Ви не ввели жоного значення' if params[:id] == '' || params[:id].nil?
      render 'index'
    end
  end

  def show
    @request = Request.find(params[:id])
    if @request.token == params[:token]
      # ss
    else
      redirect_to root_path
    end
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.create(params.require(:request).permit(:name, :text))
    if @request.save
      redirect_to request_path(@request.id)
    else
      render 'new'
    end
  end
end
