class ApplicationController < ActionController::API
  include JsonWebToken
  before_action :authenticate_request

  private

  def authenticate_request
    begin
      authorization = request.headers['Authorization']
      jwt = authorization.split(' ').last if authorization
      decoded = jwt_decode(jwt)
      @current_user = User.find(decoded[:user_id])
    rescue
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end
