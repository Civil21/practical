module RequestsHelper
  def color_stat(stat)
    if stat == 'wait'
      "<div class='stat bg-warning'></div>".html_safe
    else
      "<div class='stat bg-success'></div>".html_safe if stat == 'complet'
    end
  end

  def admin?
    session[:admin]
  end
end
