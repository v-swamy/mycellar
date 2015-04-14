class WinesController < ApplicationController
  before_action :require_user_login
  before_action :set_wine, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:show, :edit, :update]


  def index
    @wines = current_user.wines
  end

  def new
    @wine = Wine.new
  end

  def create
    @wine = Wine.new(params.require(:wine).permit!)
    @wine.user = current_user

    if @wine.save
      flash[:success] = "Your wine has been added!"
      redirect_to root_path
    else
      flash[:danger] = "Please fix the below errors."
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @wine.update(params.require(:wine).permit!)
      flash[:success] = "Your wine has been updated!"
      redirect_to root_path
    else
      flash[:danger] = "Please fix the below errors."
      render 'edit'
    end
  end

  private

  def set_wine
    @wine = Wine.find(params[:id])
  end

  def require_same_user
    access_denied if @wine.user != current_user
  end

end