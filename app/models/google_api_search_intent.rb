class GoogleApiSearchIntent < PipelineIntent
  def process_data(params = {})
    params[:user].selection = params[:data]
  end
end
