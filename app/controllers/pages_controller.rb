class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :update]

  def home
    @root_intent = Intent.find_by(q_key: "root")
  end

  def update
    #byebug
    all_updated = true
    @answer = Answer.find(params[:id])
    ActiveSupport::Inflector.underscore(@answer.type)
    stripped_params = params[ActiveSupport::Inflector.underscore(@answer.type)]
    all_updated = false unless @answer.update(answer_params(stripped_params))
    stripped_params.keys.each do |key|
      if key.to_i.to_s == key
        sub_answer = Answer.find(key)
        all_updated = false unless sub_answer.update(answer_params(stripped_params[key]))
      end
    end
    if all_updated
      redirect_to root_path, notice: "Bot updated successfully."
    else
      redirect_to root_path, alert: "Bot not fully updated, fields missing."
    end
  end

  private

  def answer_params(a_params)
    a_params.permit(:message, :name, :location, :time, :price, :title, :subtitle, :url, :description, :duration)
  end
end
