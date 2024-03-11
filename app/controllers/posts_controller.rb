class PostsController < ApplicationController
    before_action :require_login
    before_action :set_post, only: [:edit, :destroy, :update]
    before_action :authorize_user, only: [:edit, :destroy, :update]


    def index
      @posts = current_user.posts 
    end

    def new
      @post = Post.new
       #@post = current_user.posts.build

    end

    def show
      @post = Post.find(params[:id])
    end

    def create
      @post = current_user.posts.build(post_params)
       if @post.save
         redirect_to @post, notice: 'Post was successfully created'
       else
         render :new
       end
    end

    def destroy
      if @post.destroy
        redirect_to root_path, notice: 'Destoyed successfully'
      else
        render :show
      end
    end
      
    def edit
    end

    def update
        if @post.update(post_params)
          redirect_to root_path, notice: 'Post was successfully updated.'
        else
          render :edit
        end
    end


    private
      def set_post
             @post = current_user.posts.find(params[:id])
      end

      def post_params
        # params.permit(:content)
        params.require(:post).permit(:content)
      end

      def authorize_user
        unless @post.user == current_user
          redirect_to root_path, alert: 'You are not authorized to perform this action.'
        end
     end
    end



