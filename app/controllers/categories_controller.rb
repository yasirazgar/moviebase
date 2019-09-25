class CategoriesController < ApplicationController
  skip_before_action :authenticate_request

  def index
    render json: {categories: Movie.category_map}
  end
end
