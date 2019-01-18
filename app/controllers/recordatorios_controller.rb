class RecordatoriosController < ApplicationController
  before_action :set_recordatorio, only: [:show, :update, :destroy]

  # GET /recordatorios
  def index
    @recordatorios = Recordatorio.order(:data, :time).reverse_order.where(user_id: @current_user)
    render json: { results: @recordatorios}, status: :ok
  end

  # GET /recordatorios/1
  def show
    if @recordatorio.user_id == current_user.id
      render json: @recordatorio
    else
      render json: @recordatorio.errors, status: :unprocessable_entity
    end
  end

  # POST /recordatorios
  def create
    @recordatorio = current_user.recordatorios.new(recordatorio_params)

    if @recordatorio.save
      render json: @recordatorio, status: :created, location: @recordatorio
    else
      render json: @recordatorio.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /recordatorios/1
  def update
    if @recordatorio.update(recordatorio_params) and @recordatorio.user_id == current_user.id
      render json: @recordatorio
    else
      render json: @recordatorio.errors, status: :unprocessable_entity

    end
  end

  # DELETE /recordatorios/1
  def destroy
    if @recordatorio.user_id == current_user.id
      @recordatorio.destroy
    else
      render json: @recordatorio.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordatorio
      @recordatorio = Recordatorio.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def recordatorio_params
     params.permit(:data, :texto)
   end
end










# GET /recordatorios
=begin
@api {get} /recordatorios GET Recordatorios
@apiName GetRecordatorios
@apiGroup Recordatorios
@apiPermission Token

@apiSuccess {String} id ID of the Recordatorio.
@apiSuccess {String} data Date of the User.
@apiSuccess {String} texto Texto of the Recordatorio.
@apiSuccess {String} user_id ID of the User of recordatorio.
@apiSuccess {Datetime} created_at Creation Date of the Recordatorio.
@apiSuccess {Datetime} update_at Last Update Date of the Recordatorios.
@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": "Not Authorized"
      }
=end
# GET /recordatorios/1
=begin
@api {get} /recordatorios/:id GET Recordatorio
@apiName GetRecordatorio
@apiGroup Recordatorios
@apiPermission Token

@apiParam {Number}  id ID of the Recordatorio

@apiSuccess {String} id ID of the Recordatorio.
@apiSuccess {String} data Date of the User.
@apiSuccess {String} texto Texto of the Recordatorio.
@apiSuccess {String} user_id ID of the User of recordatorio.
@apiSuccess {Datetime} created_at Creation Date of the Recordatorio.
@apiSuccess {Datetime} update_at Last Update Date of the Recordatorios.
@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": "Not Authorized"
      }
=end
# POST /recordatorios
=begin
@api {post} /recordatorios  POST Recordatorio
@apiName PostRecordatorio
@apiGroup Recordatorios
@apiPermission Token

@apiParam {Number}  id ID of the Recordatorio
@apiParam {String} data Date of the User.
@apiParam {String} texto Texto of the Recordatorio.
@apiParam {String} user_id ID of the User of recordatorio.
@apiParam {Datetime} created_at Creation Date of the Recordatorio.
@apiParam {Datetime} update_at Last Update Date of the Recordatorios.

@apiSuccess {String} id ID of the Recordatorio.
@apiSuccess {String} data Date of the User.
@apiSuccess {String} texto Texto of the Recordatorio.
@apiSuccess {String} user_id ID of the User of recordatorio.
@apiSuccess {Datetime} created_at Creation Date of the Recordatorio.
@apiSuccess {Datetime} update_at Last Update Date of the Recordatorios.
@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": "Not Authorized"
      }
=end
# DELETE /recordatorios/1
=begin
@api {delete} /recordatorios/:id  DELETE Recordatorio
@apiName DeleteRecordatorio
@apiGroup Recordatorios
@apiPermission Token

@apiParam {Number}  id ID of the Recordatorio


@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": "Not Authorized"
      }
=end
