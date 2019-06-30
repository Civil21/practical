class RequestsController < ApplicationController
  after_action :read, only: :show
  def index
    session[:token] = nil
    if session[:admin]
      redirect_to admin_path

    else
      @message = 'Ведіть ід та ключ'
    end
  end

  def find
    @token = params[:token]
    @request = Request.find_by(id: params[:id])
    if @request && @request.token == @token
      session[:token] = @token
      redirect_to request_path(@request.id)
    else
      @message = ''
      @message += 'Ви не ввели жодного значення ' if params[:id] == '' || params[:id].nil?
      @message += 'Ви не ввели ключ ' if @token == '' || @token.nil?
      @message += 'НЕ ЗНАЙДЕНО ЗАЯВКИ З ТАКИМ НОМЕРОМ ' unless @request && params[:id] != ''
      @message += 'Ключ не співпадає ' if @request && @request.token != @token && @token != ''
      render 'index'
    end
  end

  def show
    @token = session[:token]
    @request = Request.find(params[:id])
    if @request.token == @token || session[:admin]
    else
      redirect_to root_path
    end
  end

  def read
    @request.update(read: true) if @request && !@request.read
  end

  def new
    if session[:admin]
      redirect_to admin_path
    else
      session[:token] = nil
      @request = Request.new
    end
  end

  def create
    session[:token] = nil
    params[:request][:stat] = 'wait'
    params[:request][:token] = (0...6).map { ('a'..'z').to_a[rand(26)] }.join
    params[:request][:name] = params[:request][:name].downcase
    @request = Request.create(params.require(:request).permit(:name, :phone, :subject, :token, :text, :stat))
    if @request.save
      session[:token] = @request.token
      redirect_to request_path(@request.id)
    else
      render 'new'
    end
  end

  def admin
    if session[:admin] == true
      @requests = Request.all
      @requests = @requests.order("#{session['order_name']} #{session['order_type']} ") unless session['order_name'].nil?
    else
      redirect_to admin_signin_path
    end
  end

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

  def order
    if session['order_name'] == params[:name]
      session['order_type'] = if session['order_type'] != 'ASC'
                                'ASC'
                              else
                                'DESC'
                              end
    else
      session['order_name'] = params[:name]
    end
    redirect_back(fallback_location: root_path)
  end

  def stat
    if %w[wait success close].include?(params[:name])
      @request = Request.find(params[:id])
      @request.update(stat: params[:name])
      redirect_back(fallback_location: root_path)
    end
  end
end
