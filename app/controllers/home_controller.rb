class HomeController < ApplicationController
  skip_before_filter :require_login

  def index
    @projects = Project.all
    @projects = render_to_string 'projects/index', layout: false, formats: :json
    render 'index', formats: 'html'
  end
end
