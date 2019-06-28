class RequestsController < ApplicationController
  after_action :read, only: :show
  def index
    session[:token] = nil
    @massage = 'Ведіть ід та ключ'
  end

  def find
    @token = params[:token]
    @request = Request.find_by(id: params[:id])
    if @request && @request.token == @token
      session[:token] = @token
      redirect_to request_path(@request.id)
    else
      @massage = ''
      @massage += 'Ви не ввели жодного значення ' if params[:id] == '' || params[:id].nil?
      @massage += 'Ви не ввели ключ ' if @token == '' || @token.nil?
      @massage += 'НЕ ЗНАЙДЕНО ЗАЯВКИ З ТАКИМ НОМЕРОМ ' unless @request && params[:id] != ''
      @massage += 'Ключ не співпадає ' if @request && @request.token != @token && @token != ''
      render 'index'
    end
  end

  def show
    @token = session[:token]
    @request = Request.find(params[:id])
    if @request.token == @token
    else
      redirect_to root_path
    end
  end

  def read
    @request.update(read: true) if @request && !@request.read
  end

  def new
    session[:token] = nil
    @request = Request.new
  end

  def create
    session[:token] = nil
    params[:request][:stat] = 'wait'
    params[:request][:token] = 'token'
    @request = Request.create(params.require(:request).permit(:name, :phone, :subject, :token, :text, :stat))
    if @request.save
      session[:token] = @request.token
      redirect_to request_path(@request.id)
    else
      render 'new'
    end
  end

  def admin; end

  def signin; end

  def login
    if params[:name] == 'admin' && params[:password] == 'guest'
      session[:admin] = true
      redirect_to admin_path
    end
  end

  def logout
    session[:admin] = false
    redirect_back(fallback_location: root_path)
  end
end
