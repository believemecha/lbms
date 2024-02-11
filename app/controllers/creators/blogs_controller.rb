class Creators::BlogsController < ApplicationController
    before_action :authenticate_user!

    def index
        @blogs = Blog.all
    end

    def show
        @blog = Blog.find_by(slug: params[:id])
    end
    
    def edit
        @blog = Blog.find_by(slug: params[:id])
    end

    def new_blog

    end

    def make_creation
        title = params[:title]
        content = params[:content]
        content_json = params[:content_json]
        id = params[:id]
        @blog = Blog.find_by(id: id) || Blog.new(user_id: current_user.id)
      
        if title.present? && content.present? && content_json.present?
          @blog.title = title
          @blog.content = content
          @blog.content_json = content_json
      
          if @blog.save
            render json: { status: 'success', message: 'Blog created successfully', redirect_path: "/creators/blogs/#{@blog.slug}" }
          else
            render json: { status: 'error', message: 'Failed to save the blog.' }
          end
        else
          render json: { status: 'error', message: "Title and content can't be blank." }
        end
    end
    
      
end