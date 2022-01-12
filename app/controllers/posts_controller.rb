class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = policy_scope(Post).all.includes([:user])
    authorize @posts
  end

  def show; end

  def new
    @post = authorize Post.new
    skip_policy_scope
  end

  def edit; end

  def create
    @post = authorize Post.new(post_params)
    skip_policy_scope

    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: "Post was successfully destroyed."
  end

  private

  def set_post
    @post = authorize policy_scope(Post).find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :published).merge(user: current_user)
  end
end
