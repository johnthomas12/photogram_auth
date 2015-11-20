class LikesController < ApplicationController
  def index
    @likes = Like.all
  end

  def show
    @like = Like.find(params[:id])
  end

  def new
    @like = Like.new
  end

  def create
    @like = Like.new

    @like.user_id = current_user.id

    @like.photo_id = params[:photo_id]



    if @like.save
      if cookies[:last_viewed] == "photo.index"
      redirect_to "/photos", :notice => "Like created successfully."
      end
      if cookies[:last_viewed] == "mylikes.index"
      redirect_to "/my_likes", :notice => "Like created successfully."
      end
      if cookies[:last_viewed] == "mywall.index"
      redirect_to :back, :notice => "Like created successfully."
      end
    else
      render 'new'
    end

  end

  def edit
    @like = Like.find(params[:id])
  end

  def update
    @like = Like.find(params[:id])


    @like.user_id = params[:user_id]

    @like.photo_id = params[:photo_id]



    if @like.save
      redirect_to "/likes", :notice => "Like updated successfully."
    else
      render 'edit'
    end

  end

  def destroy
    @like = Like.find(params[:id])

    x = @like.user_id.to_i

    @like.destroy

    if cookies[:last_viewed] == "photo.index"
    redirect_to "/photos", :notice => "Like deleted."
    end

    if cookies[:last_viewed] == "mylikes.index"
    redirect_to "/my_likes", :notice => "Like deleted."
    end

    if cookies[:last_viewed] == "mywall.index"
    redirect_to :back, :notice => "Like deleted."
    end

  end
end
