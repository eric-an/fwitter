class TweetsController < ApplicationController

  get '/tweets' do
    @tweets = Tweet.all
    if logged_in?
      @user = current_user
      erb :"tweets/index"
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"tweets/new"
    else
      redirect to '/login'
    end
  end

  post '/tweets/new' do
    @user = current_user
    @tweet = Tweet.create(content: params[:content])
    @tweet.user = @user
    if @tweet.save
      redirect to "/users/#{@user.slug}"
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :"tweets/show"
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])

    if logged_in? && @tweet.user == current_user
      erb :"tweets/edit"
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    if @tweet.update(content: params[:content])
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by(id: params[:id])
    if logged_in? && @tweet.user == current_user
      @tweet.destroy
      redirect to '/tweets'
    else
      redirect to '/tweets'
    end
  end
end