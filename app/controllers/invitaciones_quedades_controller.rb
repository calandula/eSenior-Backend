class InvitacionesQuedadesController < ApplicationController
  before_action :set_invitaciones_quedade, only: [:show, :update, :destroy]

  # GET /invitaciones_quedades
  def index
    @invitaciones_quedades = InvitacionesQuedade.all

    render json: @invitaciones_quedades
  end

  # GET /invitaciones_quedades/1
  def show
    render json: @invitaciones_quedade
  end

  # POST /invitaciones_quedades
  def create
    @invitaciones_quedade = InvitacionesQuedade.new(invitaciones_quedade_params)

    if @invitaciones_quedade.save
      render json: @invitaciones_quedade, status: :created, location: @invitaciones_quedade
    else
      render json: @invitaciones_quedade.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /invitaciones_quedades/1
  def update
    if @invitaciones_quedade.update(invitaciones_quedade_params)
      render json: @invitaciones_quedade
    else
      render json: @invitaciones_quedade.errors, status: :unprocessable_entity
    end
  end

  # DELETE /invitaciones_quedades/1
  def destroy
    @invitaciones_quedade.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invitaciones_quedade
      @invitaciones_quedade = InvitacionesQuedade.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def invitaciones_quedade_params
      params.permit(:user_id, :quedada_id, :status)
    end
end


# GET /quedadas
=begin
@api {get} /invitaciones_quedades GET Invitaciones Quedades
@apiName GetInvitacion
@apiGroup Invitaciones_Quedades
@apiPermission Token

@apiSuccess {String} id ID of the Quedada.
@apiSuccess {String} user_id  User of Invitacion.
@apiSuccess {String} status Status of Invitacion.
@apiSuccess {Datetime} created_at Creation Date of Quedada.
@apiSuccess {Datetime} update_at Last Update Date of Quedada.
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
