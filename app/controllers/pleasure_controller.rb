class PleasureController < ApplicationController

    def createGusto
        if Pleasure.where(:title => params[:title]).exists?
          render json: {status: 'ERROR', message: 'Pleasure already exist'}, status: :unprocessable_entity
        else
          Pleasure.create({
            :title => params[:title]
          })
          render json: {status: 'SUCCESS', message: 'Saved pleasure'}, status: :ok
        end
    end

    def getGustos
        @gustos = Pleasure.all
        render json: {results: @gustos}, status: :ok
    end
      
    private
        # Never trust parameters from the scary internet, only allow the white list through.
      def pleasure_params
        params.permit(:title)
      end
end

# POST /createGusto
=begin
@api {post} /createGusto  POST Pleasure
@apiName PostCreatePleasure
@apiGroup Gustos

@apiParam {String} title  Title of the pleasure.

@apiSuccess SUCCESS
@apiSuccess Success-Response:
      HTTP/1.1 200 OK
      {
        "SUCCESS": "Saved pleasure"
      }

@apiError unprocessable_entity
@apiErrorExample Error-Response:
      HTTP/1.1 422 Unprocessable Entity
      {
        "error": "Pleasure already exist"
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

# GET /getGustos
=begin
@api {get} /getGustos GET Gustos
@apiName GetPleasures
@apiGroup Gustos
@apiPermission Token

@apiSuccess {Object[]} results       List of pleasures.
@apiSuccess {Number}   results.id   Gusto id.
@apiSuccess {String}   results.title   Gustos's name.

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