class PostsController < ApplicationController
  before_action :set_space, only: %i[index new create]
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = policy_scope(@space.posts)
             .order(created_at: :desc)
             .eager_load([:user])
             .page(params[:page])
             .per(12)
    authorize @posts
  end

  def show; end

  def new
    @post = authorize Post.new space: @space
    skip_policy_scope
  end

  def edit; end

  def create
    @post = authorize Post.new(post_params.merge(user: current_user, space: @space))
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
    redirect_to @post.space, notice: "Post was successfully destroyed."
  end

  private

  def set_space
    @space = authorize policy_scope(Space).find_by!(hashid: params[:space_hashid]), :show?
  end

  def set_post
    @post = authorize policy_scope(Post).find_by!(hashid: params[:hashid])
  end

  def post_params
    params.require(:post).permit(:title, :content, :copy_protect, :published)
  end
end
