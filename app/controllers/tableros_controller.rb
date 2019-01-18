class TablerosController < ApplicationController
  before_action :set_quedada


  #POST quedadas/1/tableros
  def create
    t = Tablero.find_by(quedada_id: params[:id])
    if !t
      t = Tablero.new(tablero_params)
      t.filas = params[:filas]
      t.columnas = params[:columnas]
      t.casillas[t.filas*t.columnas - 1] = nil
      t.quedada_id = @quedada.id
      t.save
      render json: {info: 'tableros', data: t}
    else
      render json: {error: 'ya existe un tablero de esta quedada'}
    end
  end

  #GET quedadas/1/tableros
  def show
    t = Tablero.find_by(quedada_id: params[:id])
    if t
      render json: {info: 'tablero para la quedada', data: t}
    else
      render json: {error: 'no existe un tablero asignado para esta quedada'}
    end
  end

  #PATCH quedadas/1/tableros
  def deleteAll
    t = Tablero.all
    for index in 0 ... t.size
      t[index].destroy
    end
  end

  #PUT quedadas/1/tableros
  def update
    t = Tablero.find_by(quedada_id: params[:id])
    if t
      index = t.columnas.to_i * params[:filas].to_i + params[:columnas].to_i
      t.casillas[index] = params[:value]
      t.save
      render json: {info: 'update', data: t}
    else
      render json: {error: 'no existe tal tablero'}
    end
  end

  #DELETE quedadas/1/tableros
  def destroy
    t = Tablero.find_by(quedada_id: params[:id])
    if t
      t.destroy
      render json: {info: 'tablero_removed'}
    else
      render json: {error: 'no existe tal tablero'}
    end
    head :no_content
  end

  private

  def set_quedada
    @quedada = Quedada.find(params[:id])
  end

  def tablero_params
   params.permit(:filas, :columnas)
  end
end

# GET /quedadas/:id/tableros
=begin
@api {get} /quedadas/{:id}/tableros GET Quedadas
@apiName GetTablero
@apiGroup Tableros
@apiPermission Token

@apiSuccess {Integer} id ID of the Tablero
@apiSuccess {Array} array of tablero
@apiSuccess {String} created_at
@apiSuccess {String} updated_at
@apiSuccess {Integer} filas
@apiSuccess {Integer} columnas
@apiSuccess {Integer} quedada_id

@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": "Not Authorized"
      }
=end

# POST /quedadas/:id/tableros
=begin
@api {post} /quedadas/{:id}/tableros  POST Tablero
@apiName PostTablero
@apiGroup Tableros
@apiPermission Token

@apiParam {Integer} filas del Tablero
@apiParam {Integer} columnas del Tablero

@apiSuccess {Integer} id ID of the Tablero
@apiSuccess {Array} array of tablero
@apiSuccess {String} created_at
@apiSuccess {String} updated_at
@apiSuccess {Integer} filas
@apiSuccess {Integer} columnas
@apiSuccess {Integer} quedada_id

@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": "Not Authorized"
      }
=end

# PUT /quedadas/:id/tableros
=begin
@api {put} /quedadas/{:id}/tableros EDIT tablero
@apiName EditTablero
@apiGroup Tableros
@apiPermission Token

@apiParam {Integer} filas del Tablero
@apiParam {Integer} columnas del Tablero
@apiParam {String} value of the edited cell

@apiSuccessExample {json} Success-Response:
                   { "info": "put_succeeded" }

@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": "Not Authorized"
      }
=end

# DELETE /quedadas/:id/tableros
=begin
@api {delete} /quedadas/{:id}/tableros  DELETE Tablero
@apiName DeleteTablero
@apiGroup Tableros
@apiPermission Token

@apiSuccessExample {json} Success-Response:
                   { "info": "tablero_destroyed" }

@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": "Not Authorized"
      }
=end
