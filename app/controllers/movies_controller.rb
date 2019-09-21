class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_request, only: [:index]
  before_action :authorize_user, except: [:index, :create]

  def index
    @movies = Movie.all

    render json: { movies: @movies.pluck(:title, :description) }
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user

    if @movie.save
      data = {
        movie: { id: @movie.id, title: @movie.title, description: @movie.description },
        message: I18n.t('movie.create.success')
      }
      render json: data

      return
    end

    render json: {message: @movie.errors.full_messages.join(', ')}
  end

  def update
    if @movie.update(movie_params)
      data = {
        movie: { id: @movie.id, title: @movie.title, description: @movie.description },
        message: I18n.t('movie.create.success')
      }

      render json: data
      return
    end

    render json: {message: @movie.errors.full_messages.join(', ')}
  end

  def destroy
    @movie.destroy

    render json: {message: I18n.t('movie.destroy.success')}
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_movie
    @movie = Movie.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def movie_params
    params.require(:movie).permit(:title, :description, :category_id)
  end

  def authorize_user
    render_unauthorized unless @movie.user.id == current_user.id
  end
end