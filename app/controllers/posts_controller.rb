class PostsController < ApplicationController
  before_action :require_login!
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      flash[:notice] = ["Post created!"]
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find_by_id(params[:id])
  end

  def update
    @post = Post.find_by_id(params[:id])

    if @post.update(post_params)
      flash[:notice] = ["Post updated!"]
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    @post.delete
    flash[:notice] = ["Post deleted!"]
    redirect_to sub_url(params[:sub_id])
  end

  def show
    @post = Post.find_by_id(params[:id])
    @sub = Sub.find_by_id(cookies[:sub_id]) if cookies[:sub_id]
    @comments_by_parent_id = @post.comments_by_parent_id
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
