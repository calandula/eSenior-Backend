class UsersController < ApplicationController

      #before_action :set_user, only: [:show, :edit, :update, :destroy]   
      skip_before_action :authenticate_request, :only => [:create, :confirm_email]
  
      # GET /users
      def index
        users = User.order('created_at DESC')
        render json: {status: 'SUCCESS', message: 'Loaded users', results: users}, status: :ok
      end

      # GET /users/1
      def show
        @user = User.find(params[:id])
        render json: {status: 'SUCCESS', message: 'Loaded user', results: @user}, status: :ok
      end

      # POST /users
      def create
        if User.where(:email => params[:email]).exists?
          render json: {status: 'ERROR', message: 'User not saved, it already exist'}, status: :unprocessable_entity
        else
          new_user = User.create({
            :name => params[:name], 
            :email => params[:email], 
            :password => params[:password],
            :password_confirmation => params[:password],
            :bio => params[:bio]
          })
          UsersMailer.NewUser(new_user).deliver_now
          render json: {status: 'SUCCESS', message: 'Saved user'}, status: :ok
        end
      end

      def updateUsers
        user = User.find_by_id(current_user.id)
        if user.update(user_params)
          render json: {status: 'SUCCESS', message: 'User Modified'}, status: :ok
        else
          render json: {status: 'ERROR', message: 'User not modified'}, status: :unprocessable_entity
        end
      end

      # DELETE /users/1
      def destroy
        user = User.find(params[:id])
        if user.destroy
          render json: {status: 'SUCCESS', message: 'User Deleted'}, status: :ok
        else
          render json: {status: 'ERROR', message: 'User was not deleted'}, status: :unprocessable_entity
        end
      end

      def searchUserByName
        if User.where(:name => params[:name]).exists?
          #user = User.where(:name => params[:name])
          user = User.find_by_sql("SELECT *
                                  FROM users u
                                  WHERE u.name = '#{params[:title]}' and u.id != '#{current_user.id}' AND NOT EXISTS(select * 
                                                                                                                    from friendships f
                                                                                                                    where f.user_id = '#{current_user.id}' and f.friend_id = u.id)")
          render json: {results: user}, status: :ok
        else 
          #user = User.where("name LIKE '%#{params[:name]}%'")
          user = User.find_by_sql("SELECT *
                                  FROM users u
                                  WHERE u.name LIKE '%#{params[:name]}%' and u.id != '#{current_user.id}' AND NOT EXISTS(select * 
                                                                                                                        from friendships f
                                                                                                                        where f.user_id = '#{current_user.id}' and f.friend_id = u.id)")
          render json:  {results: user}, status: :ok
        end
      end

      def searchUserByMail
        if User.where(:email => params[:email]).exists?
          #user = User.where(:email => params[:email])
          user = User.find_by_sql("SELECT *
                                  FROM users u
                                  WHERE u.email = '#{params[:email]}' and u.id != '#{current_user.id}' AND NOT EXISTS(select * 
                                                                                                                      from friendships f
                                                                                                                      where f.user_id = '#{current_user.id}' and f.friend_id = u.id)")
          render json: {results: user}, status: :ok
        else 
          #user = User.where("email LIKE '%#{params[:email]}%'")
          user = User.find_by_sql("SELECT *
                                  FROM users u
                                  WHERE u.email LIKE '%#{params[:email]}%' and u.id != '#{current_user.id}' AND NOT EXISTS(select * 
                                                                                                                          from friendships f
                                                                                                                          where f.user_id = '#{current_user.id}' and f.friend_id = u.id)")
          render json:  {results: user}, status: :ok
        end
      end

      def confirm_email
        user = User.find_by_confirm_token(params[:id])
        if user
          user.email_activate
          render plain: "Tu correo ha sido confirmado."
        else
          render plain: "No existe es correo"
        end
    end

      def myProfile
        render json:  {results: current_user}, status: :ok
      end

      rescue_from ActiveRecord::RecordNotFound, with: :show_not_found_errors
      def show_not_found_errors(exception)
          render  json:({ status: :not_found, code: 404, message: 'No se ha encontrado el objeto solicitado' }), status: 404
      end
  
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
          @user = User.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def user_params
          params.permit(:name, :email, :password, :bio )
        end

end


# GET /users
=begin
@api {get} /users GET Usuarios
@apiName GetUsuarios
@apiGroup Usuarios
@apiPermission Token

@apiSuccess {Object[]} data       List of user profiles.
@apiSuccess {Number}   id   Users id.
@apiSuccess {String}   name   Users name.
@apiSuccess {String}   email   Users email.
@apiSuccess {String}   password_digest   Users password_digest.
@apiSuccess {String}   bio   Users bio.
@apiSuccess {Datetime} created_at Creation Date of User.
@apiSuccess {Datetime} update_at Last Update Date of User.

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

# GET /users/1
=begin
@api {get} /users/:id GET Usuario
@apiName GetUsuario
@apiGroup Usuarios
@apiPermission Token

@apiParam {Number}  id ID of the User

@apiSuccess {Number}   id   Users id.
@apiSuccess {String}   name   Users name.
@apiSuccess {String}   email   Users email.
@apiSuccess {String}   password_digest   Users password_digest.
@apiSuccess {String}   bio   Users bio.
@apiSuccess {String}   updated_at   Users updated_at.
@apiSuccess {Datetime} created_at Creation Date of User.
@apiSuccess {Datetime} update_at Last Update Date of User.

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

@apiError not_found
@apiErrorExample Error-Response:
      HTTP/1.1 404 not_found
      {
        "status": "not_found",
        "code": 404,
        "message": "No se ha encontrado el objeto solicitado"
      }
=end

# GET /myProfile
=begin
@api {get} /myProfile GET MyProfile
@apiName GetmyProfile
@apiGroup Usuarios
@apiPermission Token

@apiSuccess {Number}   id   Users id.
@apiSuccess {String}   name   Users name.
@apiSuccess {String}   email   Users email.
@apiSuccess {String}   password_digest   Users password_digest.
@apiSuccess {String}   bio   Users bio.
@apiSuccess {String}   updated_at   Users updated_at.
@apiSuccess {Datetime} created_at Creation Date of User.
@apiSuccess {Datetime} update_at Last Update Date of User.

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

# POST /users
=begin
@api {post} /users  POST Usuario
@apiName PostCreateUser
@apiGroup Usuarios

@apiParam {String} name User name.
@apiParam {String} email  User email.
@apiParam {String} password User password.
@apiParam {String} password_confirmation User password.
@apiParam {String} bio  User's biography.

@apiSuccess SUCCESS
@apiSuccess Success-Response:
      HTTP/1.1 200 OK
      {
        "status": "SUCCESS",
        "message": "Saved user"
      }

@apiError unprocessable_entity
@apiErrorExample Error-Response:
      HTTP/1.1 422 Unprocessable Entity
      {
        "status": "ERROR",
        "message": "User not saved, it already exist"
      }
=end

# DELETE /users/:id
=begin
@api {delete} /users/:id  DELETE User
@apiName DeleteUser
@apiGroup Usuarios
@apiPermission Token

@apiParam {Number}  id ID of User

@apiSuccess SUCCESS
@apiSuccess Success-Response:
      HTTP/1.1 200 OK
      {
        "status": "SUCCESS",
        "message": "User Deleted"
      }

@apiError unprocessable_entity
@apiErrorExample Error-Response:
      HTTP/1.1 422 Unprocessable Entity
      {
        "status": "ERROR",
        "message": "User was not deleted"
      }
=end

# GET /searchUserByName
=begin
@api {get} /searchUserByName GET Usuarios buscados por nombre
@apiName searchUserByName
@apiGroup Usuarios
@apiPermission Token

@apiParam {String}  name Name from the user that is looking for

@apiSuccess {Object[]} results       List of user profiles.
@apiSuccess {Number}   results.id   Users id.
@apiSuccess {String}   results.name   Users name.
@apiSuccess {String}   results.email   Users email.
@apiSuccess {String}   results.password_digest   Users password_digest.
@apiSuccess {String}   results.bio   Users bio.
@apiSuccess {String}   results.id   Users id.
@apiSuccess {Datetime} results.created_at Creation Date of User.
@apiSuccess {Datetime} results.update_at Last Update Date of User.

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

# GET /searchUserByMail
=begin
@api {get} /searchUserByMail GET Usuarios buscados por email
@apiName searchUserByMail
@apiGroup Usuarios
@apiPermission Token

@apiParam {String}  email Email from the user that is looking for

@apiSuccess {Object[]} results       List of user profiles.
@apiSuccess {Number}   results.id   Users id.
@apiSuccess {String}   results.name   Users name.
@apiSuccess {String}   results.email   Users email.
@apiSuccess {String}   results.password_digest   Users password_digest.
@apiSuccess {String}   results.bio   Users bio.
@apiSuccess {String}   results.id   Users id.
@apiSuccess {Datetime} results.created_at Creation Date of User.
@apiSuccess {Datetime} results.update_at Last Update Date of User.

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

# PUT /updateUsers
=begin
@api {put} /updateUsers  PUT modificarUsuario
@apiName PutUpdateUser
@apiGroup Usuarios
@apiPermission Token

@apiDescription modifica los parametros del usuario, no modificara los parametros que no enviemos, en caso de modificar el password deberemos pasarle los dos parametros de password.

@apiParam {String} name User name.
@apiParam {String} password User password.
@apiParam {String} password_confirmation User password.
@apiParam {String} bio  User's biography.

@apiSuccess SUCCESS
@apiSuccess Success-Response:
      HTTP/1.1 200 OK
      {
        "status": "SUCCESS",
        "message": "User Modified"
      }
@apiError unprocessable_entity
@apiErrorExample Error-Response:
      HTTP/1.1 422 Unprocessable Entity
      {
        "status": "ERROR",
        "message": "User not modified"
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
