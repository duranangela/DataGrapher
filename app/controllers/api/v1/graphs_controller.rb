class Api::V1::GraphsController < ApiBaseController

  def index
    @presenter = GraphPresenter.new(params[:location], params[:stats])
    render json: @presenter
  end

end
