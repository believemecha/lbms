class ArticlesController < ApplicationController
    def index
       if current_user.present? && current_user.college?
          redirect_to '/colleges/dashboard'
          return
       end 

       if current_user.present? && current_user.admin?
        redirect_to '/admin'
        return
       end 

       ## handle for students and schools
        @articles = Article.all
      end
end