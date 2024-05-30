class GptController < ApplicationController

    def index
        @prompts = GptPrompt.order(created_at: :desc).limit(3)
    end

    def generate_response
        @prompt = GptPrompt.find_by(id: params[:prompt_id])
        load_next = params[:load_next]

        return render json: {status: false,message: "Invalid Id"} unless @prompt.present?
        if load_next != "true"
            if @prompt.conversations.length == 0
                @prompt.get_prompt_response
            end
        else
            @prompt.get_prompt_response
        end
        render partial: "chat_box"
    end

    def chat
        @current_prompt = GptPrompt.find_by(code: params[:code])
        redirect_to root_path if !@current_prompt.present? && params[:code].present?

        @prompt_lists = GptPrompt.where("jsonb_array_length(conversations) > 0").order(created_at: :desc).limit(5)
        @prompts = GptPrompt.where("jsonb_array_length(conversations) = 0").order(created_at: :desc).limit(3)
    end

    def list_prompts
        @prompt_lists = GptPrompt.order(created_at: :desc).limit(5)
        render partial: "prompts_list"
    end
end
    