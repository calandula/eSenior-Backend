class FriendsController < ApplicationController
  before_action :set_friend, only: :destroy

  def index
    @friends = current_user.friends
    render json: {status: 'SUCCESS', results: @friends}, status: :ok
  end

  def destroy
    current_user.friends.destroy(@friend)
    render json: {status: 'SUCCESS', message: 'friend removed'}
  end

  private

  def set_friend
    @friend = current_user.friends.find(params[:id])
  end
end

# GET /friends/index
=begin
@api {get} /friends/index GET Friends
@apiName GetFriends
@apiGroup Friends
@apiPermission Token

@apiSuccess {Integer} id ID del usuario como amigo.
@apiSuccess {String} name Nombre del amigo.
@apiSuccess {String} email correo electŕónico del usuario.
@apiSuccess {String} password_digest
@apiSuccess {String} bio Bio del amigo
@apiSuccess {Datetime} created_at Creation Date of Quedada.
@apiSuccess {Datetime} update_at Last Update Date of Quedada.

@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": {
          "user_authentication": [
              "invalid credentials"
          ]
        }
      }s
=end

# GET /friends/destroy
=begin
@api {get} /friends/destroy DELETE Friend
@apiName DeleteFriend
@apiGroup Friends
@apiPermission Token

@apiParam {Number}  id ID del amigo

@apiSuccess SUCCESS
@apiSuccess Success-Response:
      HTTP/1.1 200 OK
      {
        "status": "SUCCESS",
        "message": "friend removed"
      }

@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": {
          "user_authentication": [
              "invalid credentials"
          ]
        }
      }
=end
