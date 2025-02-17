class MoviesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    movie = MovieFacade.new
    if params[:search] && params[:search].blank?
      []
    elsif params[:search]
      @movie = movie.movie_search(params[:search])
    else
      @movie = movie.top_40_movies
    end
  end

  def show
    @user = User.find(params[:user_id])
    movie = MovieFacade.new
    @movie = movie.find_movie(params[:id])
    # search = (params[:search])
  end
end

# The user movie show page is fixed to only have one movie show up, with all the movie info spelled out. All information should be there. Write a spec test for this page.
