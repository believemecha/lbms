module Colleges
    class CollegesController < ApplicationController
        before_action :check_college


        private
        def check_college
            puts "checking"
            redirect_to root_path unless current_user.present? && current_user.college?
        end
    end
end