class MessagesController < ApplicationController
  before_action :set_mail, only: [:show, :update, :destroy]

  def sendMail
    @mail = Message.create({
      :title => params[:title], 
      :sender => current_user.email,
      :receiver => params[:receiver], 
      :message => params[:message]
    })
    if @mail.save
      render json: {status: 'SUCCESS', message: 'Message sended'}, status: :ok
    else
      render json: {status: 'ERROR', message: 'Message not sended'}, status: :unprocessable_entity
    end
  end

  def getMails
    @mails = Message.order('created_at DESC').where(:receiver => @current_user.email)
    render json: {results: @mails}, status: :ok
  end

  def getSendedMails
    @mails = Message.order('created_at DESC').where(:sender => @current_user.email)
    render json: {results: @mails}, status: :ok
  end

  def getMailsNotReaded
    @mails = Message.order('created_at DESC').where(:receiver => @current_user.email, read: false)
    render json: {results: @mails}, status: :ok
  end

  def markAsReaded
    mail = Message.find(params[:id])
    mail.read = 'true'
    if mail.save
      render json: {status: 'SUCCESS', message: 'Message marked as read'}, status: :ok
    else
      render json: {status: 'ERROR', message: 'Message not marked'}, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mail
      @mail = Message.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mail_params
      params.permit(:id, :receiver, :message, :title)
    end
end

# POST /sendMail
=begin
@api {post} /sendMail  POST sendMessage
@apiName PostSendMessage
@apiGroup Mails
@apiPermission Token

@apiParam {String} receiver Mail from the receiver.
@apiParam {String} message  The message itself.
@apiParam {Text} title Title from the message.

@apiSuccess SUCCESS
@apiSuccess Success-Response:
      HTTP/1.1 200 OK
      {
        "status": "SUCCESS",
        "message": "Message sended"
      }
@apiError unprocessable_entity
@apiErrorExample Error-Response:
      HTTP/1.1 422 Unprocessable Entity
      {
        "status": "ERROR",
        "message": "Message not sended"
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

# GET /getMails
=begin
@api {get} /getMails GET Mails
@apiName GetMails
@apiGroup Mails
@apiPermission Token

@apiSuccess {Object[]} results       List mails from the user.
@apiSuccess {Number}   id   Mail id.
@apiSuccess {String}   sender   the mail from the sender.
@apiSuccess {String}   receiver   the mail from the user asking the mails.
@apiSuccess {String}   message   the message itself.
@apiSuccess {Datetime} created_at Creation Date of User.
@apiSuccess {Datetime} update_at Last Update Date of User.
@apiSuccess {String}   title   Title from the mail.
@apiSuccess {Boolean}   read   is the mail already readed?.


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


# GET /getSendedMails
=begin
@api {get} /getMails GET MailsSendedMails
@apiName GetMails
@apiGroup Mails
@apiPermission Token

@apiSuccess {Object[]} results       List mails from the user.
@apiSuccess {Number}   id   Mail id.
@apiSuccess {String}   sender   the mail from the sender.
@apiSuccess {String}   receiver   the mail from the user asking the mails.
@apiSuccess {String}   message   the message itself.
@apiSuccess {Datetime} created_at Creation Date of User.
@apiSuccess {Datetime} update_at Last Update Date of User.
@apiSuccess {String}   title   Title from the mail.
@apiSuccess {Boolean}   read   is the mail already readed?.


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

# GET /getMailsNotReaded
=begin
@api {get} /getMailsNotReaded GET MailsNotReaded
@apiName getMailsNotReaded
@apiGroup Mails
@apiPermission Token

@apiSuccess {Object[]} results       List mails from the user that is/are not readed.
@apiSuccess {Number}   id   Mail id.
@apiSuccess {String}   sender   the mail from the sender.
@apiSuccess {String}   receiver   the mail from the user asking the mails.
@apiSuccess {String}   message   the message itself.
@apiSuccess {Datetime} created_at Creation Date of User.
@apiSuccess {Datetime} update_at Last Update Date of User.
@apiSuccess {String}   title   Title from the mail.
@apiSuccess {Boolean}   read   column marked as false.


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

# POST /markAsReaded
=begin
@api {post} /markAsReaded  POST markAsReaded
@apiName PostMarkMailAsReaded
@apiGroup Mails
@apiPermission Token

@apiSuccess {Number}   id   Mail id.

@apiSuccess SUCCESS
@apiSuccess Success-Response:
      HTTP/1.1 200 OK
      {
        "status": "SUCCESS",
        "message": "Message marked as read"
      }
@apiError unprocessable_entity
@apiErrorExample Error-Response:
      HTTP/1.1 422 Unprocessable Entity
      {
        "status": "ERROR",
        "message": "Message not marked"
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