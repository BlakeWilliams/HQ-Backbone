class HomeController < ApplicationController
  def index
    @projects = Project.all
    @projects = render_to_string 'projects/index', layout: false, formats: :json
    render 'index', formats: 'html'
  end
end
