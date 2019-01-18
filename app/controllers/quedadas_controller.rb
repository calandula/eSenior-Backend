class QuedadasController < ApplicationController
  before_action :set_quedada, only: [:show, :update, :destroy]


#kaksfdkn
  # GET /quedadas
  def index
    @quedadas = Quedada.all

    render json: {results: @quedadas}, status: :ok

  end

  # GET /quedadas/1
  def show
    render json: @quedada
  end

  # POST /quedadas
  def create
    @quedada = current_user.quedadas.new(quedada_params)
    if @quedada.save
      render json: @quedada, status: :created, location: @quedada
    else
      render json: @quedada.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /quedadas/1
  def update
    if @quedada.update(quedada_params)
      render json: @quedada
    else
      render json: @quedada.errors, status: :unprocessable_entity
    end
  end

  # DELETE /quedadas/1
  def destroy
    @quedada.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quedada
      @quedada = Quedada.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def quedada_params
      params.permit(:titulo, :descripcion, :fecha, :hora, :lugar)
    end
end


# GET /quedadas
=begin
@api {get} /quedadas GET Quedadas
@apiName GetQuedadas
@apiGroup Quedadas
@apiPermission Token

@apiSuccess {String} id ID of the Quedada.
@apiSuccess {String} titulo Title of Quedada.
@apiSuccess {String} descripcion Descripcion of Quedada.
@apiSuccess {String} fecha Date of Recordatorio
@apiSuccess {String} hora Time of Recordatorio
@apiSuccess {String} lugar Localitation of Recordatorio
@apiSuccess {Datetime} created_at Creation Date of Quedada.
@apiSuccess {Datetime} update_at Last Update Date of Quedada.
@apiSuccess {String} user_id ID of the User of Quedada.
@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": "Not Authorized"
      }
=end
# GET /quedadas/1
=begin
@api {get} /quedadas/:id GET Quedada
@apiName GetQuedada
@apiGroup Quedadas
@apiPermission Token

@apiParam {Number}  id ID of the Quedada

@apiSuccess {String} id ID of the Quedada.
@apiSuccess {String} titulo Title of Quedada.
@apiSuccess {String} descripcion Descripcion of Quedada.
@apiSuccess {String} fecha Date of Recordatorio
@apiSuccess {String} hora Time of Recordatorio
@apiSuccess {String} lugar Localitation of Recordatorio
@apiSuccess {Datetime} created_at Creation Date of Quedada.
@apiSuccess {Datetime} update_at Last Update Date of Quedada.
@apiSuccess {String} user_id ID of the User of Quedada.
@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": "Not Authorized"
      }
=end
# POST /quedadas
=begin
@api {post} /quedadas  POST Quedada
@apiName PostQuedada
@apiGroup Quedadas
@apiPermission Token

@apiParam {String} titulo Title of Quedada.
@apiParam {String} descripcion Descripcion of Quedada.
@apiParam {String} fecha Date of Recordatorio
@apiParam {String} hora Time of Recordatorio
@apiParam {String} lugar Localitation of Recordatorio

@apiSuccess {String} id ID of the Quedada.
@apiSuccess {String} titulo Title of Quedada.
@apiSuccess {String} descripcion Descripcion of Quedada.
@apiSuccess {String} fecha Date of Recordatorio
@apiSuccess {String} hora Time of Recordatorio
@apiSuccess {String} lugar Localitation of Recordatorio
@apiSuccess {Datetime} created_at Creation Date of Quedada.
@apiSuccess {Datetime} update_at Last Update Date of Quedada.
@apiSuccess {String} user_id ID of the User of Quedada.
@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": "Not Authorized"
      }
=end
# DELETE /quedadas/1
=begin
@api {delete} /quedadas/:id  DELETE Quedada
@apiName DeleteQuedadas
@apiGroup Quedadas
@apiPermission Token

@apiParam {Number}  id ID of Quedada


@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": "Not Authorized"
      }
=end
# PUT /quedadas/1
=begin
@api {put} /quedadas/:id  PUT Quedada
@apiName PutQuedada
@apiGroup Quedadas
@apiPermission Token

@apiParam {String} titulo Title of Quedada.
@apiParam {String} descripcion Descripcion of Quedada.
@apiParam {String} fecha Date of Recordatorio
@apiParam {String} hora Time of Recordatorio
@apiParam {String} lugar Localitation of Recordatorio

@apiSuccess {String} id ID of the Quedada.
@apiSuccess {String} titulo Title of Quedada.
@apiSuccess {String} descripcion Descripcion of Quedada.
@apiSuccess {String} fecha Date of Recordatorio
@apiSuccess {String} hora Time of Recordatorio
@apiSuccess {String} lugar Localitation of Recordatorio
@apiSuccess {Datetime} created_at Creation Date of Quedada.
@apiSuccess {Datetime} update_at Last Update Date of Quedada.
@apiSuccess {String} user_id ID of the User of Quedada.
@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": "Not Authorized"
      }
=end
