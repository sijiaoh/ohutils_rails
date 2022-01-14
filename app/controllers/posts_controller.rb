class PostsController < ApplicationController
  before_action :set_space
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = policy_scope(@space.posts).all.eager_load([:user])
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
      redirect_to [@space, @post], notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to [@space, @post], notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to [@space, :posts], notice: "Post was successfully destroyed."
  end

  private

  def set_space
    @space = authorize policy_scope(Space).find_by!(slug: params[:space_slug]), :show?
  end

  def set_post
    @post = authorize policy_scope(@space.posts).find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :published).merge(user: current_user, space: @space)
  end
end
