class SubsController < ApplicationController

  before_action :require_login!, except: [:index, :show]

  def index
    @subs = Sub.all
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id

    if @sub.save
      flash[:notice] = ["Subforum created!"]
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find_by_id(params[:id])
  end

  def update
    @sub = Sub.find_by_id(params[:id])

    if @sub.update(sub_params)
      flash[:notice] = ["Subforum updated!"]
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def destroy
    @sub = Sub.find_by_id(params[:id])
    @sub.delete
    redirect_to root_url
  end

  def show
    @sub = Sub.find_by_id(params[:id])
    cookies[:sub_id] = params[:id]
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
