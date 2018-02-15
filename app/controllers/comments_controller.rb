class CommentsController < ApplicationController

  before_action :set_post, only: [:index, :create, :show, :destroy]
  before_action :set_comment, only: [:show, :destroy]
  before_action :authenticate_user!, only: [:destroy]

  def index
    @comments = @post.comments.all
    render json: @comments
  end

  def create
    @comment = @post.comments.new(comment_params)
    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @comment
  end

  def destroy
    @comment.destroy
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end


  def comment_params
    params.require(:comment).permit(:author, :content)
  end

end
