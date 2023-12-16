class QuestionBanksController < ApplicationController
    def index
        @question = QuestionBank.first
    end
end