class TweetsController < ApplicationController
  before_action :authenticate

  def index
    texts = Tweet.all
    render json: texts
  end

  def show
    texts = Tweet.where(id: params[:id])
    if texts.present?
      render json: texts, status:200
    else
      render json: {errors: "Tweet not found"}, status: 404
    end
  end

  def create

    text = Tweet.new tweet_params.merge({user_id: @current_user_id})
    if text.save
      render json: text, status: 200
    else
      render json: { errors:"couldnt create tweet"}, status: 404
    end
  end

  def destroy
    text = Tweet.find(params[:id])
    if text.present?
      render json: text.destroy
    else
      render json: { errors:"couldnt delete tweet, it doesn't exist"}, status: 404
    end
  end 

  private

  def tweet_params
    params.require(:tweet).permit(:message)
  end

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      user = User.find_by(auth_token: token)
      @current_user_id = user.id
    end
  end

end
