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
      if params[:sort_by_title]
        @movies = Movie.order(params[:sort_by_title])
        @my1 = "hilite"
      elsif params[:sort_by_date]
        @movies = Movie.order(params[:sort_by_date])
        @my2 = "hilite"
      else
        @movies = Movie.all
        @my = ""
      end
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
    
    def update1
    end
    
    def update2
      @datas1 = params[:movie]
      @datas2 = Movie.find_by(title: @datas1[:search])
      if(@datas2)
        @ts1 = @datas1[:title]
        @ts2 = @datas1[:rating]
        @ts3 = @datas1[:release_date]
        if @ts1=='' || @ts2=='' || @ts3==''
          flash[:notice]="Field Blank..."
        else
          @datas2.update_attributes!(movie_params)
          flash[:notice]="Movie updated!!!"
        end
      else
        flash[:notice] = "Can't find Movie"
      end
      redirect_to movies_path
    end
    
    def delete1
    end

    def delete2
      @datas1 = params[:movie]
      @datas2 = Movie.find_by(title: @datas1[:to_del])
      @datas3 = Movie.where(rating: @datas1[:rat_del])
      if(@datas2)
        @datas2.delete
        flash[:notice] = "Movie deleted by title"
      elsif(@datas3)
        @datas3.each {|x| x.delete}
        flash[:notice] = "Movie deleted by rating"
      else
        flash[:notice] = "can't find movie with title or rating"
      end
      redirect_to movies_path
    end

  end