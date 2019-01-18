class FriendRequestsController < ApplicationController
  before_action :set_friend_request, except: [:index, :create]

  def create
    friend = User.find(params[:friend_id])
    @friend_request = current_user.friend_requests.new(friend: friend)

    if @friend_request.save
      render json: @friend_request, status: :created, location: @friend_request
    else
      render json: @friend_request.errors, status: :unprocessable_entity
    end
  end

  def index
    @incoming = FriendRequest.where(friend: current_user)
    @outgoing = current_user.friend_requests
    render json: {info: 'friends_requests', incoming: { results: @incoming }, outgoing: { data: @outgoing }}, status: :ok
  end

  def update
    @friend_request.accept
    render json: {info: 'request_accepted'}
    head :no_content
  end

  def destroy
    friend_request.destroy
    render json: {info: 'request_destroyed'}
    head :no_content
  end

  private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end
end

# GET /friend_requests
=begin
@api {get} /friend_requests GET FriendRequests
@apiName GetFriendRequests
@apiGroup FriendRequests
@apiPermission Token

@apiSuccess {Integer} id ID of the FriendRequest
@apiSuccess {Integer} user_id ID of the user requesting
@apiSuccess {Integer} friend_id ID of the user requested
@apiSuccess {String} created_at
@apiSuccess {String} updated_at
@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": "Not Authorized"
      }
=end
# POST /friend_requests/id
=begin
@api {post} /friend_requests  POST FriendRequests
@apiName PostFriendRequest
@apiGroup FriendRequests
@apiPermission Token

@apiParam {Integer} friend_id del amigo

@apiSuccess {Integer} id ID of the FriendRequest
@apiSuccess {Integer} user_id ID of the user requesting
@apiSuccess {Integer} friend_id ID of the user requested
@apiSuccess {String} created_at
@apiSuccess {String} updated_at

@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": "Not Authorized"
      }
=end
# PUT /friend_requests/id
=begin
@api {put} /friend_requests/:id  ACCEPT FriendRequest
@apiName AcceptFriendRequest
@apiGroup FriendRequests
@apiPermission Token

@apiParam {Number}  id ID of the friend_request

@apiSuccessExample {json} Success-Response:
                   { "info": "request_accepted" }

@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": "Not Authorized"
      }
=end
# DELETE /friend_requests/id
=begin
@api {delete} /friend_requests/:id  DELETE FriendRequests
@apiName DeleteFriendRequest
@apiGroup FriendRequests
@apiPermission Token

@apiParam {Number}  id of the friend_request

@apiSuccessExample {json} Success-Response:
                   { "info": "request_destroyed" }

@apiError NotAuthorized
@apiErrorExample Error-Response:
      HTTP/1.1 401 Unauthorized
      {
        "error": "Not Authorized"
      }
=end
