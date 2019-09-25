class RatingsController < ApplicationController
  skip_before_action :authenticate_request

  def index
    render json: {ratings: Movie.ratings_map}
  end
end
