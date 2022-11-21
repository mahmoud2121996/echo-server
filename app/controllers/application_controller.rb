class ApplicationController < ActionController::API
  before_action :set_headers

  def echo
    @endpoint = Endpoint.find_by path: request.path, verb: request.method_symbol

    if @endpoint
      render json: @endpoint.body, status: @endpoint.code, headers: @endpoint.headers
    else
      render json: get_error_response, status: :not_found
    end
  end

  private

  def get_error_response
    { errors: [
      {
        "code": 'not_found',
        "detail": "Requested page `#{request.path}` does not exist"
      }
    ] }
  end

  def set_headers
    if request.env['PATH_INFO'].match("/endpoints*")
        response.headers['Content-Type'] = 'application/vnd.api+json'
    end
  end
end
