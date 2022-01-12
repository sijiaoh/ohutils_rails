class SpacesController < ApplicationController
  before_action :set_space, only: %i[show edit update destroy]

  def index
    @spaces = policy_scope(Space).all
    authorize @spaces
  end

  def show; end

  def new
    @space = authorize Space.new
    skip_policy_scope
  end

  def edit; end

  def create
    @space = authorize Space.new(space_params)
    skip_policy_scope

    if @space.save
      redirect_to @space, notice: "Space was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @space.update(space_params)
      redirect_to @space, notice: "Space was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @space.destroy
    redirect_to spaces_url, notice: "Space was successfully destroyed."
  end

  private

  def set_space
    @space = authorize policy_scope(Space).find(params[:id])
  end

  def space_params
    params.require(:space).permit(:name)
  end
end
