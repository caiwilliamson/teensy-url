class UrlsController < ApplicationController
  before_action :set_url, only: :destroy

  # GET /urls
  def index
    @urls = Url.all
    @url = Url.new
  end

  # GET /urls/1
  def show
    url = Url.find_by(slug: params[:slug])
    redirect_to url.original and return if url
    render 'static/url_not_found', status: :not_found
  end

  # POST /urls
  def create
    @url = Url.new(url_params)

    if @url.save
      redirect_to urls_path, notice: 'Url was successfully created.'
    else
      @urls = Url.all
      render :index
    end
  end

  # DELETE /urls/1
  def destroy
    @url.destroy
    redirect_to urls_url, notice: 'Url was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def url_params
      params.require(:url).permit(:original, :slug)
    end
end
