class Creators::BlogsController < ApplicationController
    before_action :authenticate_user!

    def index
        
    end

    def show
        @blog = Blog.find_by(slug: params[:id])
    end

    def new_blog

    end

    def make_creation
        title = params[:title]
        content = params[:content]
        id = params[:id]
      
        @blog = Blog.find_by(id) || Blog.new(user_id: current_user.id)
      
        if title.present? && content.present?
          @blog.title = title
          @blog.content = content
      
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