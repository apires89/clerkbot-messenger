class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @root_intent = Intent.find_by(q_key: "root")
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.update(params)
  end
end
