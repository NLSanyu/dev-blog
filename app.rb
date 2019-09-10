require 'sinatra'
require 'sinatra/activerecord'
require_relative './models/post'
require 'sinatra/json'

mime_type :json, 'application/json'

before do
    content_type :json
end

get '/' do
    "Welcome to DevBlog!"
end

# get posts
get '/posts/?:page?' do
    # get_page(params[:page])
    @posts = Post.all
    json @posts
end

# search posts by title
get '/posts/search/:title' do
    @title = params[:title]
    @post = Post.find_by title(@title)
    json @post
end

# create a post
post '/posts' do
    new_post = JSON.parse request.body.read  
    @post = Post.new( new_post )
    if @post.save
        @post.to_json
    end
end

# update a post
# put '/posts/:id' do
#     @post = Post.find_by_id params[:id]
#     update_post = JSON.parse request.body.read  

#     if @post.update_attributes(update_post)
#         json @post
#     else
#         json @post.errors.messages
#     end
# end

# delete posts
# delete '/posts/delete/:id' do
#     @post = Post.find_by_id params[:id]
#     @post.destroy
# end