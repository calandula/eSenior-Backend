class UserPleasureController < ApplicationController
    

    # POST /definirGusto
    def definirGusto
        if Pleasure.where(:title => params[:title]).exists?
            pleasure = Pleasure.find_by_title(params[:title])
            user = User.find_by_email(current_user.email)
            id = user.id
            idP = pleasure.id
            UserPleasure.create({:user_id => id, :pleasure_id => idP})
            render json: {status: 'SUCCESS', message: 'Se ha definido tu gusto'}, status: :ok
        else
            render json: {status: 'ERROR', message: 'El gusto no existe'}, status: :unprocessable_entity
        end
    end
    
    # GET /usuariosMismoGusto/:title
    def usuariosMismoGusto
        user = User.find_by_sql("SELECT *
            FROM users u, user_pleasures up, pleasures p
            WHERE u.id = up.user_id AND up.pleasure_id = p.id AND p.title = '#{params[:title]}'")
        render json: {results: user}, status: :ok
    end

    def usuariosSimilares
        #discutir con David que criterio seguir para esta funcionalidad
    end
    
    private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_pleasure_params
      params.permit(:title)
    end
end

# POST /definirGusto
=begin
@api {post} /definirGusto  POST UserPleasure
@apiName /definirGusto
@apiGroup GustosUsuarios

@apiParam {String} title ID of the pleasure name.

@apiSuccess SUCCESS
@apiSuccess Success-Response:
      HTTP/1.1 200 OK
      {
        "SUCCESS": "Se ha definido tu gusto"
      }

@apiError unprocessable_entity
@apiErrorExample Error-Response:
      HTTP/1.1 422 Unprocessable Entity
      {
        "error": "El gusto no existe"
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

# GET /usuariosMismoGusto/:title
=begin
@api {get} /usuariosMismoGusto/:title GET Usuarios buscados por gusto
@apiName usuariosMismoGusto
@apiGroup GustosUsuarios
@apiPermission Token

@apiParam {String}  title ID of the pleasure name.

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