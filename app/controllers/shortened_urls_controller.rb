class ShortenedUrlsController < ApplicationController
  def show
    render json: ShortenedUrl.find_by(hashed_url: params[:id])
  end

  def create
    render json: UrlShortenerService.new.call(params[:url])
  end

  private

  def create_params
    params.permit(:url)
  end
end
