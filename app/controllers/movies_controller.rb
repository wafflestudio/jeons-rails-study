class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def parse
    url = "http://aggregate.movie.daum.net/provider/rss/futureshow.xml"
    xml = Nokogiri::XML(open(url))
    json = Hash.from_xml(xml.to_s)

    if params[:save]
      json['rss']['channel']['item'].each do |item|
        movie = Movie.new
        movie.title = item['title']
        movie.origin_url = item['link']
        movie.description = item['description']
        movie.published_at = Time.new(item['pubDate'])
        movie.guid = item['guid'].split("movieId=").last
        movie.save
      end
    end

    respond_to do |format|
      format.html { render :json => json['rss']['channel']['item'] }
      format.json { render :json => json }
      format.xml { render :json => xml }
    end
  end

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
    @sampled_movies = @movies.shuffle[0...3]
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render action: 'show', status: :created, location: @movie }
      else
        format.html { render action: 'new' }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :description, :poster_url, :origin_url, :published_at, :guid)
    end
end
