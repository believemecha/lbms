class GptController < ApplicationController

    def index
        @prompts = GptPrompt.order(created_at: :desc).limit(3)
    end

    def generate_response
        @prompt = GptPrompt.find_by(id: params[:prompt_id])
        return render json: {status: false,message: "Invalid Id"} unless @prompt.present?

        res = @prompt.get_prompt_response

        return render json: {status: true,message: res,prompt: @prompt.prompt }
    end

    def list_prompts
        @prompt_lists = GptPromptResponse.order(created_at: :desc).limit(5)
        render partial: "prompts_list"
    end
end
    