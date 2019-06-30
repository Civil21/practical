module RequestsHelper
  def color_stat(stat)
    return "<div class='stat bg-warning'></div>".html_safe if stat == 'wait'
    return "<div class='stat bg-success'></div>".html_safe if stat == 'success'
    return "<div class='stat bg-danger'></div>".html_safe if stat == 'close'
  end

  def admin?
    session[:admin]
  end

  def subject(name)
    return 'Підключення до інтернету' if name == 'new_client'
    return 'Проблема з інтернетом' if name == 'old_client'
  end
end
