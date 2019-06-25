class RequestsController < ApplicationController
  def index
    @massage = 'Ведіть ід та ключ'
  end

  def find
    @request = Request.find_by(id: params[:id])
    pp Request.all
    pp @request
    if @request && @request.token == params[:token]
      redirect_to request_path(@request.id, token: params[:token])
    else
      @massage = ''
      @massage += 'Ви не ввели жодного значення ' if params[:id] == '' || params[:id].nil?
      @massage += 'Ви не ввели ключ ' if params[:token] == '' || params[:token].nil?
      @massage += 'НЕ ЗНАЙДЕНО ЗАЯВКИ З ТАКИМ НОМЕРОМ ' unless @request && params[:id] != ''
      @massage += 'Ключ не співпадає ' if @request && @request.token != params[:token] && params[:token] != ''
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
    params[:request][:stat] = 'wait'
    params[:request][:token] = 'token'
    @request = Request.create(params.require(:request).permit(:name, :phone, :subject, :token, :text, :stat))
    if @request.save
      redirect_to request_path(@request.id)
    else
      render 'new'
    end
  end
end
