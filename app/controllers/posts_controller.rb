class PostsController < ApplicationController
  before_action :require_login!, except: [:show]

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
    cookies[:post_id] = params[:id]
    @sub = Sub.find_by_id(cookies[:sub_id]) if cookies[:sub_id]
    @comments_by_parent_id = @post.comments_by_parent_id
  end

  def upvote
    vote(1)
  end

  def downvote
    vote(-1)
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def vote(value)
    @post = Post.find(params[:id])
    @vote = Vote.find_by(
      votable_id: @post.id, votable_type: "#{self.class.name}", user_id: current_user.id
    )

    if @vote
      @vote.update(value: value)
    else
      @post.votes.create!(
        user_id: current_user.id, value: value
      )
    end

    redirect_to sub_url(cookies[:sub_id])
  end
end
