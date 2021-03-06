class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    
  # just combined my sorting system with the ratings to try to get them to both populate 
  #for some reason it only takes on param at a time though
  # if param is ratings then the movies is made up of only those that have the rating with 
  #a key in the param
  
  #just set the session as whatever the first params are :)
    case params[:sort]
    when 'title'
      @title_hilite = 'hilite'

      session[:sort] = params[:sort]
      if params[:ratings]
        @movies = Movie.where(rating: params[:ratings].keys).order('title ASC')
        session[:ratings] = params[:ratings]
      else 
        @movies = Movie.order('title ASC')
      end 
    when 'release_date'
      @release_hilite = 'hilite'

      session[:sort] = params[:sort]
      if params[:ratings]
        @movies = Movie.where(rating: params[:ratings].keys).order('release_date ASC')
        session[:ratings] = params[:ratings]
      else 
        @movies = Movie.order('release_date ASC')
      end
    else
      if params[:ratings]
        @movies = Movie.where(rating: params[:ratings].keys)
        session[:ratings] = params[:ratings]
      else 
        @movies = Movie.all
      end 
    end
#did the exact same thing with session as will params 
    case session[:sort]
        when 'title'
        @title_hilite = 'hilite'
        
      if  session[:ratings]
        @movies = Movie.where(rating:  session[:ratings].keys).order('title ASC')
      else 
        @movies = Movie.order('title ASC')
      end 
    when 'release_date'
      @release_hilite = 'hilite'

      if  session[:ratings]
        @movies = Movie.where(rating:  session[:ratings].keys).order('release_date ASC')
      else 
        @movies = Movie.order('release_date ASC')
      end
    else
      if  session[:ratings]
        @movies = Movie.where(rating:  session[:ratings].keys)
      else 
        @movies = Movie.all
      end 
    end
    
    
    
    
    
  @all_ratings = Movie.all_ratings



    
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
