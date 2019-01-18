class WallMessagesController < ApplicationController
  before_action :set_wall_message, only: [:update, :destroy]
  # GET /wall_messages
  def index
    @wall_messages = WallMessage.where(user_id: @current_user).reverse_order

    render json: {muro: @wall_messages}
  end

  # GET /wall_messages/1
  def show
    @friends = Friendship.where(user_id: current_user.id, friend_id: params[:id])
    @user = User.where(id: params[:id])
    if @user && @friends.size != 0
      @wall_messages = WallMessage.where(user_id: params[:id]).reverse_order
      render json: {muro: @wall_messages}
    else
      render json: {status: 'ERROR', message: 'Not a friend of the user or user does not exist'}, status: :unprocessable_entity
    end
  end

  # POST /wall_messages
  # hace un post de un mensaje en tu muro
  def create
    @wall_message = current_user.wall_messages.new(texto: params[:texto],user_id: @current_user,from: current_user.id)

    if @wall_message.save
      render json: @wall_message, status: :created, location: @wall_message
    else
      render json: @wall_message.errors, status: :unprocessable_entity
    end
  end

  # POST /wall_messages/1
  # hace un post de un mensaje en el muro de otro usuario si estos son amigos
  def create_specific
    @user = User.where(id: params[:id])
    @friends = Friendship.where(user_id: current_user.id, friend_id: params[:id])
    if @user && @friends.size != 0
      @wall_message = WallMessage.new(texto: params[:texto],user_id: params[:id],from: current_user.id)
      if @wall_message.save
        render json: @wall_message, status: :created, location: @wall_message
      else
        render json: @wall_message.errors, status: :unprocessable_entity
      end
    else
      render json: {status: 'ERROR', message: 'Not a friend of the user or user does not exist'}, status: :unprocessable_entity
    end
  end

  #DELETE /wall_messages
  def deleteAll
    t = WallMessage.all
    for index in 0 ... t.size
      t[index].destroy
    end
  end

  # PATCH/PUT /wall_messages/1
  # modifica un mensaje con el id = params[:id]
  def update

    if @wall_message.update(wall_message_params) && @wall_message.from == current_user.id
      render json: @wall_message
    else
      render json: @wall_message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /wall_messages/1
  def destroy
    if @wall_message.from == current_user.id
      @wall_message.destroy
    else
      render json: @wall_message.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wall_message
      @wall_message = WallMessage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def wall_message_params
      params.permit(:texto, :user_id, :from)
    end
end

# GET /wall_messages
=begin
@api {get} /wall_messages GET WallMessages
@apiName GetWallMessagesByYouOrToYou
@apiGroup WallMessages
@apiPermission Token

@apiSuccess {Object[]} muro   Lista de mensajes colgados por ti o enviados a ti
@apiSuccess {Number}   id   WallMessage id.
@apiSuccess {String}   texto   Texto del mensaje.
@apiSuccess {String}   user_id   muro de usuario al que pertenece el mensaje, muro de usuario = id de su usuario.
@apiSuccess {Datetime} created_at Creation Date of WallMessage.
@apiSuccess {Datetime} update_at Last Update Date of WallMessage.
@apiSuccess {Number}   from   quién envió el mensaje.

@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": "Not Authorized"
      }
=end

# GET /wall_messages/1
=begin
@api {get} /wall_messages/:id GET WallMessages
@apiName GetWallMessagesFromSpecificUser
@apiGroup WallMessages
@apiPermission Token

@apiParam {Number}  id ID of the user

@apiSuccess {Object[]} muro   Lista de mensajes colgados por ti o enviados a ti
@apiSuccess {Number}   id   WallMessage id.
@apiSuccess {String}   texto   Texto del mensaje.
@apiSuccess {String}   user_id   muro de usuario al que pertenece el mensaje, muro de usuario = id de su usuario.
@apiSuccess {Datetime} created_at Creation Date of WallMessage.
@apiSuccess {Datetime} update_at Last Update Date of WallMessage.
@apiSuccess {Number}   from   quién envió el mensaje.

@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": "Not Authorized"
      }

@apiError unprocessable_entity
@apiErrorExample Error-Response:
      HTTP/1.1 422 Unprocessable Entity
      {
        "error": "Not a friend of the user or user does not exist"
      }
=end

# POST /wall_messages
=begin
@api {post} /wall_messages  POST WallMessages
@apiName PostOwnWallMessage
@apiGroup WallMessage

@apiParam {String} texto Texto del mensaje.

@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": "Not Authorized"
      }

=end

# POST /wall_messages/:id
=begin
@api {post} /wall_messages/:id  POST WallMessages
@apiName PostWallMessageToOthers
@apiGroup WallMessage

@apiParam {Number}  id ID of the user who you want to post the message to
@apiParam {String} texto Texto del mensaje.

@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": "Not Authorized"
      }

@apiError unprocessable_entity
@apiErrorExample Error-Response:
      HTTP/1.1 422 Unprocessable Entity
      {
        "error": "Not a friend of the user or user does not exist"
      }

=end

# DELETE /wall_messages/:id
=begin
@api {delete} /wall_messages/:id  DELETE WallMessage
@apiName DeleteWallMessage
@apiGroup WallMessage
@apiPermission Token

@apiParam {Number}  id ID of Wall Message which has to be created by you


@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": "Not Authorized"
      }
=end

# PUT /wall_messages/:id
=begin
@api {put} /wall_messages/:id  PUT WallMessage
@apiName PutUpdateYourWallMessage
@apiGroup WallMessage
@apiPermission Token

@apiParam {Number}  id ID of Wall Message which has to be created by you
@apiParam {String} texto Texto del mensaje a cambiar.

@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": "Not Authorized"
      }
=end
