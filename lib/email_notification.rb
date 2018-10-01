module EmailNotification 
  @@global_logo = '<img alt="" title="" height="auto" src="data:image/png;base64,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" style="border:none;border-radius:0px;display:block;font-size:13px;outline:none;text-decoration:none;width:100%;height:auto;  margin-left: 200px;margin-top: -51px;" width="150">'

  require 'sendgrid-ruby'
  include SendGrid

  def self.send_not_active_subscription(user, subscription)
    subscription.plan.subscription ? p_type = 'inscripcion a bot' : p_type = 'inversion'
    subscription.plan.subscription ? r_type = ' por tus planes de inversión y referidos' : r_type = ' por rendimiento de plan de inversión'
    from      = Email.new(email: 'noreply@netmarketcap.co')
    to        = Email.new(email: user.email)
    subject   = 'Net Market Cap - Plan expired'
    content   = Content.new(type: 'text/html', value:"
                        <div style='font-family: sans-serif; text-align: center; width: 500px; height: auto; margin-right: auto; margin-left: auto; padding: 10px 20px 40px 20px; background-color: #06071A;'>
                        <h1 style='color: #e6cc7e; font-size: 300%; text-align: left;'>Net Market Cap</h1>
                        <br/>
                        <h2 style='color: white; font-size: 200%;'>Plan Expired</h2>
                        <h3 style='font-size: 150%; color: #e6cc7e; display: inline; margin-right: 20px;'>USER</h3>
                        <p style='font-size: 130%; color: white; display: inline;'>#{user.username.upcase}</p>
                        <br/>
                        <div style='border: 5px solid #e6cc7e; width: 420px; height: auto; margin-right: auto; margin-left: auto; margin-top: 20px; text-align: justify; padding: 20px 20px;'>
                        <p style='font-size: 120%; color: white; display: inline;'>Your Plan to the plan <span style='font-size: 130%; color: #e6cc7e;'>#{subscription.plan.name.upcase}</span> has ended.</p>
                        <br/>
                        </div>
                        </div>")
    mail  = Mail.new(from, subject, to, content)
    sg    = SendGrid::API.new(api_key: Rails.application.secrets.sendgrid_api)
    response = sg.client.mail._('send').post(request_body: mail.to_json)
  end
  
  def self.send_not_active_notification(parent, user, subs)
    from      = Email.new(email: 'noreply@netmarketcap.co')
    to        = Email.new(email: parent.email)
    subject   = 'Net Market Cap - Reward Caneled'

    content   = Content.new(type: 'text/html', value: "
                        <div style='font-family: sans-serif; text-align: center; width: 500px; height: auto; margin-right: auto; margin-left: auto; padding: 10px 20px 40px 20px; background-color: #06071A;'>
                        <h1 style='color: #e6cc7e; font-size: 300%; text-align: left;'>Net Market Cap</h1>
                        <br/>
                        <h2 style='color: white; font-size: 200%;'>REWARD CANCELADO</h2>
                        <h3 style='font-size: 150%; color: #e6cc7e; display: inline; margin-right: 20px;'>USUARIO</h3>
                        <p style='font-size: 130%; color: white; display: inline;'>#{parent.username.upcase}</p>
                        <br/>
                        <div style='border: 5px solid #e6cc7e; width: 420px; height: auto; margin-right: auto; margin-left: auto; margin-top: 20px; text-align: justify; padding: 20px 20px;'>
                        <p style='font-size: 120%; color: white; display: inline;'>Se ha generado un reward por <span style='font-size: 130%; color: #e6cc7e;'>#{subs.plan.subscription ? 'COMPRA DE BOT' : 'COMPRA DE PLAN DE INVERSION'}</span> de tu referido <span style='font-size: 130%; color: #e6cc7e;'>#{user.username.upcase}</span> de valor <span style='font-size: 130%; color: #e6cc7e;'>$#{subs.price} USD</span>.</p>
                        <br/>
                        <p style='font-size: 120%; color: white; display: inline;'>Este no podrá hacerse efectivo debido a que no tienes planes de bot activos.</p>
                        <br/>
                        <p style='font-size: 120%; color: white; display: inline;'>Compra un plan de inscripción a Bot para seguir generando rewards por tus referidos.</p>
                        <br/>
                        </div>
                        </div>")
    mail  = Mail.new(from, subject, to, content)
    sg    = SendGrid::API.new(api_key: Rails.application.secrets.sendgrid_api)
    response = sg.client.mail._('send').post(request_body: mail.to_json)
  end
  
  def self.send_confirmation_email(password,user)
    from      = Email.new(email: 'noreply@netmarketcap.co')
    to        = Email.new(email: user.email)
    subject   = 'Net Market Cap - Email Confirmation'
    shref     = Rails.application.secrets.confirm_route + user.confirmation_token
    content   = Content.new(type: 'text/html', value:'
    <!DOCTYPE html>
      <html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">
      <head>
          <title></title>
          <meta http-equiv="X-UA-Compatible" content="IE=edge">
          <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <style type="text/css">
              .ReadMsgBody {
                  width: 100%;
              }

              .ExternalClass {
                  width: 100%;
              }

              .ExternalClass * {
                  line-height: 100%;
              }

              body {
                  margin: 0;
                  padding: 0;
                  -webkit-text-size-adjust: 100%;
                  -ms-text-size-adjust: 100%;
              }

              table,
              td {
                  border-collapse: collapse;
              }

              img {
                  border: 0;
                  height: auto;
                  line-height: 100%;
                  outline: none;
                  text-decoration: none;
                  -ms-interpolation-mode: bicubic;
              }

              p {
                  display: block;
                  margin: 13px 0;
              }
          </style>
          <style type="text/css">
              @media only screen and (max-width:480px) {
                  @viewport {
                      width: 320px;
                  }
              }
          </style>
          <link href="https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700" rel="stylesheet" type="text/css">
          <style type="text/css">
              @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);
          </style>
      </head>

      <body style="background: transparent !important;">
          <div style="background-color:transparent;">
              <table role="presentation" cellpadding="0" cellspacing="0" style="font-size:0px;width:100%;" border="0">
                  <tbody>
                      <tr>
                          <td>
                              <div style="margin:0px auto;max-width:600px;">
                                  <table role="presentation" cellpadding="0" cellspacing="0" style="font-size:0px;width:100%;" align="center" border="0">
                                      <tbody>
                                          <tr>
                                              <td style="text-align:center;vertical-align:top;direction:ltr;font-size:0px;padding:9px 0px 9px 0px;">
                                                  <div style="vertical-align:top;display:inline-block;direction:ltr;font-size:13px;text-align:left;width:100%;">
                                                      <table role="presentation" cellpadding="0" cellspacing="0" width="100%" border="0">
                                                          <tbody>
                                                              <tr>
                                                                  <td style="word-wrap:break-word;font-size:0px;padding:0px 20px 0px 20px;" align="left">
                                                                      <div style="cursor:auto;color:#000000;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:22px;text-align:left;">
                                                                          <p>
                                                                              <span style="color:#17284c;">
                                                                                  <span style="font-size:26px;">Dear customer!</span>
                                                                              </span>
                                                                          </p>
                                                                      </div>
                                                                  </td>
                                                              </tr>
                                                          </tbody>
                                                      </table>
                                                  </div>
                                                  <div style="vertical-align:top;display:inline-block;direction:ltr;font-size:13px;text-align:left;width:100%;">
                                                      <table role="presentation" cellpadding="0" cellspacing="0" width="100%" border="0">
                                                          <tbody>
                                                              <tr>
                                                                  <td style="word-wrap:break-word;font-size:0px;padding:0px 0px 0px 0px;" align="center">
                                                                      <table role="presentation" cellpadding="0" cellspacing="0" style="border-collapse:collapse;border-spacing:0px;" align="center" border="0">
                                                                          <tbody>
                                                                              <tr>
                                                                              <td style="width:200px;">
                                                                                  ' + @@global_logo + '
                                                                              </td>
                                                                              </tr>
                                                                          </tbody>
                                                                      </table>
                                                                  </td>
                                                              </tr>
                                                          </tbody>
                                                      </table>
                                                  </div>
                                              </td>
                                          </tr>
                                      </tbody>
                                  </table>
                              </div>
                          </td>
                      </tr>
                  </tbody>
              </table>
              <div style="margin:0px auto;max-width:600px;">
                  <table role="presentation" cellpadding="0" cellspacing="0" style="font-size:0px;width:100%;" align="center" border="0">
                      <tbody>
                          <tr>
                              <td style="text-align:center;vertical-align:top;direction:ltr;font-size:0px;padding:9px 0px 9px 0px;">
                                  <div style="vertical-align:top;display:inline-block;direction:ltr;font-size:13px;text-align:left;width:100%;">
                                      <table role="presentation" cellpadding="0" cellspacing="0" width="100%" border="0">
                                          <tbody>
                                              <tr>
                                                  <td style="word-wrap:break-word;font-size:0px;padding:10px 25px;padding-top:10px;padding-bottom:10px;padding-right:10px;padding-left:10px;">
                                                      <p style="font-size:1px;margin:0px auto;border-top:4px solid #17284c;width:100%;"></p>
                                                  </td>
                                              </tr>
                                              <tr>
                                                  <td style="word-wrap:break-word;font-size:0px;padding:0px 20px 0px 20px;" align="center">
                                                      <div style="cursor:auto;color:#000000;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:22px;text-align:center;">
                                                          <h2 style="line-height: 100%;">
                                                              <span style="color:#17284c;">
                                                                  <span style="font-size:22px;">Welcome to Net Market Cap.</span>
                                                              </span>
                                                              <br>&#xA0;</h2>
                                                          <p></p>
                                                          <p>
                                                              <span style="font-size:20px;">Your account has been successfully created</span>
                                                          </p>
                                                          <p>
                                                              <small style="font-size:20px;">Username: ' +  user.username + ' </small>
                                                          </p>
                                                          <p>
                                                              <small style="font-size:20px;">Password: ' +  password + '</small>
                                                          </p>
                                                      </div>
                                                  </td>
                                              </tr>
                                              <tr>
                                                <td style="word-wrap:break-word;font-size:0px;padding:13px 25px 13px 25px;padding-top:10px;padding-left:25px;" align="center">
                                                  <table role="presentation" cellpadding="0" cellspacing="0" style="border-collapse:separate;" align="center" border="0">
                                                    <tbody>
                                                      <tr>
                                                      <td style="border:none;border-radius:none;color:#fff;cursor:auto;padding:10px 25px;" align="center" valign="middle" bgcolor="#17284c">
                                                          <a href="' + shref + '" style="text-decoration:none;background:#17284c;color:#fff;font-family:Ubuntu, Helvetica, Arial, sans-serif, Helvetica, Arial, sans-serif;font-size:19px;font-weight:normal;line-height:120%;text-transform:none;margin:0px;" target="_blank">Confirm my email!</a>
                                                      </td>
                                                      </tr>
                                                    </tbody>
                                                  </table>
                                                </td>
                                              </tr>
                                              <tr>
                                                  <td style="word-wrap:break-word;font-size:0px;padding:10px 25px;padding-top:12px;padding-bottom:12px;padding-right:9px;padding-left:9px;">
                                                      <p style="font-size:1px;margin:0px auto;border-top:4px solid #17284c;width:100%;"></p>
                                                  </td>
                                              </tr>
                                              <tr>
                                                  <td style="word-wrap:break-word;font-size:0px;padding:10px 25px;" align="center">
                                                      <div>
                                                          <table role="presentation" cellpadding="0" cellspacing="0" style="float:none;display:inline-table;" align="center" border="0">
                                                              <tbody>
                                                                  <tr>
                                                                      <td style="padding:4px;vertical-align:middle;">
                                                                          <table role="presentation" cellpadding="0" cellspacing="0" style="background:none;border-radius:3px;width:35px;" border="0">
                                                                              <tbody>
                                                                                  <tr>
                                                                                      <td style="vertical-align:middle;width:35px;height:35px;">
                                                                                          <a href="https://www.facebook.com/Net Market Cap-/">
                                                                                              <img alt="facebook" height="35" src="https://s3-eu-west-1.amazonaws.com/ecomail-assets/editor/social-icos/outlined/facebook.png" style="display:block;border-radius:3px;" width="35">
                                                                                          </a>
                                                                                      </td>
                                                                                  </tr>
                                                                              </tbody>
                                                                          </table>
                                                                      </td>
                                                                      <td style="padding:4px 4px 4px 0;vertical-align:middle;">
                                                                          <a href="https://www.facebook.com/Net Market Cap-/  " style="text-decoration:none;text-align:left;display:block;color:#333333;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:13px;line-height:22px;border-radius:3px;"></a>
                                                                      </td>
                                                                  </tr>
                                                              </tbody>
                                                          </table>
                                                          <table role="presentation" cellpadding="0" cellspacing="0" style="float:none;display:inline-table;" align="center" border="0">
                                                              <tbody>
                                                                  <tr>
                                                                      <td style="padding:4px;vertical-align:middle;">
                                                                          <table role="presentation" cellpadding="0" cellspacing="0" style="background:none;border-radius:3px;width:35px;" border="0">
                                                                              <tbody>
                                                                                  <tr>
                                                                                      <td style="vertical-align:middle;width:35px;height:35px;">
                                                                                          <a href="https://twitter.com/Net Market Cap2">
                                                                                              <img alt="twitter" height="35" src="https://s3-eu-west-1.amazonaws.com/ecomail-assets/editor/social-icos/outlined/twitter.png" style="display:block;border-radius:3px;" width="35">
                                                                                          </a>
                                                                                      </td>
                                                                                  </tr>
                                                                              </tbody>
                                                                          </table>
                                                                      </td>
                                                                      <td style="padding:4px 4px 4px 0;vertical-align:middle;">
                                                                          <a href="https://twitter.com/Net Market Cap2" style="text-decoration:none;text-align:left;display:block;color:#333333;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:13px;line-height:22px;border-radius:3px;"></a>
                                                                      </td>
                                                                  </tr>
                                                              </tbody>
                                                          </table>
                                                      </div>
                                                  </td>
                                              </tr>
                                              <tr>
                                                  <td style="word-wrap:break-word;font-size:0px;padding:0px 20px 0px 20px;" align="center">
                                                      <div style="cursor:auto;color:#000000;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:22px;text-align:center;">
                                                          <p>You are receiving this email because you have Net Market Cap&#xA0;account.
                                                              <br>If you have got this message in error or do not wish to receive any further communications, please contact support.
                                                              <br>2018 Net Market Cap. All rights reserved.</p>
                                                      </div>
                                                  </td>
                                              </tr>
                                          </tbody>
                                      </table>
                                  </div>
                              </td>
                          </tr>
                      </tbody>
                  </table>
              </div>
          </div>
      </body>
  </html>')

    mail  = Mail.new(from, subject, to, content)
    sg    = SendGrid::API.new(api_key: Rails.application.secrets.sendgrid_api)
    response = sg.client.mail._('send').post(request_body: mail.to_json)
  end

  def self.send_notification(invoice)
    from      = Email.new(email: 'noreply@netmarketcap.co')
    to        = Email.new(email: invoice.user.email)
    subject   = 'Net Market Cap - Plan Activated'
    content   = Content.new(type: 'text/html', value:'
                          <!DOCTYPE html>
                            <html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">
                            <head>
                                <title></title>
                                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                <style type="text/css">
                                    .ReadMsgBody {
                                        width: 100%;
                                    }

                                    .ExternalClass {
                                        width: 100%;
                                    }

                                    .ExternalClass * {
                                        line-height: 100%;
                                    }

                                    body {
                                        margin: 0;
                                        padding: 0;
                                        -webkit-text-size-adjust: 100%;
                                        -ms-text-size-adjust: 100%;
                                    }

                                    table,
                                    td {
                                        border-collapse: collapse;
                                    }

                                    img {
                                        border: 0;
                                        height: auto;
                                        line-height: 100%;
                                        outline: none;
                                        text-decoration: none;
                                        -ms-interpolation-mode: bicubic;
                                    }

                                    p {
                                        display: block;
                                        margin: 13px 0;
                                    }
                                </style>
                                <style type="text/css">
                                    @media only screen and (max-width:480px) {
                                        @viewport {
                                            width: 320px;
                                        }
                                    }
                                </style>
                                <style type="text/css">
                                    .promos {
                                        margin: 50px auto;
                                    }

                                    .promo {
                                        width: 60%;
                                        background: #fff;
                                        color: #fff;
                                        padding-bottom: 10px;
                                        box-shadow: 0 0 15px rgba(0, 0, 0, 0.05);
                                        -webkit-transition-duration: 0.05s;
                                        transition-duration: 0.05s;
                                    }

                                    .promo:hover {
                                        box-shadow: 2px 4px 17px 4px #d1d1d1;
                                        -webkit-box-shadow: 2px 4px 17px 4px #d1d1d1;
                                    }

                                    .ic {
                                        display: block;
                                        position: absolute;
                                        top: -40px;
                                        left: 50%;
                                        margin-left: -40px;
                                        border-radius: 200px;
                                        font-size: 30px;
                                        font-weight: bold;
                                        color: #fff;
                                        padding: 19px 0;
                                        width: 80px;
                                        height: 80px;
                                        box-sizing: border-box;
                                        text-align: center;
                                    }

                                    .deal {
                                        padding: 50px 10px -2px;
                                        position: relative;
                                    }

                                    .features {
                                        display: block;
                                        margin: 20px 0 10px 0;
                                        padding: 0;
                                        list-style-type: none;
                                        text-align: center;
                                        color: #999999;
                                    }

                                    .features li {
                                        display: block;
                                        padding: 10px 0;
                                        border-bottom: 1px solid #efefef;
                                    }

                                    .plan-1 .ic,
                                    .plan-1 .promo .price {
                                        background-color: #17284c;
                                    }
                                </style>
                                <link href="https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700" rel="stylesheet" type="text/css">
                                <style type="text/css">
                                    @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);
                                </style>
                                <style type="text/css">
                                    @import url(https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css);
                                </style>
                            </head>

                            <body style="background: transparent !important;">
                                <div style="background-color:transparent;">
                                    <table role="presentation" cellpadding="0" cellspacing="0" style="font-size:0px;width:100%;" border="0">
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <div style="margin:0px auto;max-width:600px;">
                                                        <table role="presentation" cellpadding="0" cellspacing="0" style="font-size:0px;width:100%;" align="center" border="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td style="text-align:center;vertical-align:top;direction:ltr;font-size:0px;padding:9px 0px 9px 0px;">
                                                                        <div style="vertical-align:top;display:inline-block;direction:ltr;font-size:13px;text-align:left;width:100%;">
                                                                            <table role="presentation" cellpadding="0" cellspacing="0" width="100%" border="0">
                                                                                <tbody>
                                                                                    <tr>
                                                                                        <td style="word-wrap:break-word;font-size:0px;padding:0px 20px 0px 20px;" align="left">
                                                                                            <div style="cursor:auto;color:#000000;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:22px;text-align:left;">
                                                                                                <p>
                                                                                                    <span style="color:#17284c;">
                                                                                                        <span style="font-size:26px;">Dear customer!</span>
                                                                                                    </span>
                                                                                                </p>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                </tbody>
                                                                            </table>
                                                                        </div>
                                                                        <div style="vertical-align:top;display:inline-block;direction:ltr;font-size:13px;text-align:left;width:100%;">
                                                                            <table role="presentation" cellpadding="0" cellspacing="0" width="100%" border="0">
                                                                                <tbody>
                                                                                    <tr>
                                                                                        <td style="word-wrap:break-word;font-size:0px;padding:0px 0px 0px 0px;" align="center">
                                                                                            <table role="presentation" cellpadding="0" cellspacing="0" style="border-collapse:collapse;border-spacing:0px;" align="center" border="0">
                                                                                                <tbody>
                                                                                                    <tr>
                                                                                                    <td style="width:200px;">
                                                                                                        ' + @@global_logo + '
                                                                                                    </td>
                                                                                                    </tr>
                                                                                                </tbody>
                                                                                            </table>
                                                                                        </td>
                                                                                    </tr>
                                                                                </tbody>
                                                                            </table>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <div style="margin:0px auto;max-width:600px;">
                                        <table role="presentation" cellpadding="0" cellspacing="0" style="font-size:0px;width:100%;" align="center" border="0">
                                            <tbody>
                                                <tr>
                                                    <td style="text-align:center;vertical-align:top;direction:ltr;font-size:0px;padding:9px 0px 9px 0px;">
                                                        <div style="vertical-align:top;display:inline-block;direction:ltr;font-size:13px;text-align:left;width:100%;">
                                                            <table role="presentation" cellpadding="0" cellspacing="0" width="100%" border="0">
                                                                <tbody>
                                                                    <tr>
                                                                        <td style="word-wrap:break-word;font-size:0px;padding:10px 25px;padding-top:10px;padding-bottom:10px;padding-right:10px;padding-left:10px;">
                                                                            <p style="font-size:1px;margin:0px auto;border-top:4px solid #17284c;width:100%;"></p>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="word-wrap:break-word;font-size:0px;padding:0px 20px 0px 20px;" align="center">
                                                                            <div style="cursor:auto;color:#000000;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:22px;text-align:center;">
                                                                                <h2 style="line-height: 100%;">

                                                                                    <span style="font-size:22px;">Your payment for plan ' + invoice.plan.name +  '  has been recieved</span>
                                                                                    </span>
                                                                                    <br>&#xA0;</h2>
                                                                                <p></p>

                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="word-wrap:break-word;font-size:0px;padding:0px 20px 0px 20px;" align="center">
                                                                            <div style="cursor:auto;color:#000000;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:22px;text-align:center;">
                                                                                <h2 style="line-height: 100%;">

                                                                                    <span style="font-size:12px;">Txid: ' + invoice.txid +  '  </span>
                                                                                    </span>
                                                                                    <br>&#xA0;</h2>
                                                                                <p></p>

                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="word-wrap:break-word;font-size:0px;padding:0px 20px 0px 20px;" align="center">
                                                                            <div style="cursor:auto;color:#000000;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:22px;text-align:center;">
                                                                                <h2 style="line-height: 100%;">

                                                                                    <span style="font-size:12px;">Plan price: $' + invoice.price.to_s +  ' USD </span>
                                                                                    </span>
                                                                                    <br>&#xA0;</h2>
                                                                                <p></p>

                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="word-wrap:break-word;font-size:0px;padding:13px 25px 13px 25px;padding-top:10px;padding-left:25px;" align="center">
                                                                            <table role="presentation" cellpadding="0" cellspacing="0" style="border-collapse:separate;" align="center" border="0">
                                                                                <tbody>
                                                                                    <tr>
                                                                                        <td style="border:none;border-radius:none;color:#fff;cursor:auto;padding:10px 25px;" align="center" valign="middle" bgcolor="#17284c">
                                                                                            <a href="https://app.netmarketcap.co/#/login" style="text-decoration:none;background:#17284c;color:#fff;font-family:Ubuntu, Helvetica, Arial, sans-serif, Helvetica, Arial, sans-serif;font-size:19px;font-weight:normal;line-height:120%;text-transform:none;margin:0px;" target="_blank"> Login </a>
                                                                                        </td>
                                                                                    </tr>
                                                                                </tbody>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="word-wrap:break-word;font-size:0px;padding:10px 25px;padding-top:12px;padding-bottom:12px;padding-right:9px;padding-left:9px;">
                                                                            <p style="font-size:1px;margin:0px auto;border-top:4px solid #17284c;width:100%;"></p>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="word-wrap:break-word;font-size:0px;padding:10px 25px;" align="center">
                                                                            <div>
                                                                                <table role="presentation" cellpadding="0" cellspacing="0" style="float:none;display:inline-table;" align="center" border="0">
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td style="padding:4px;vertical-align:middle;">
                                                                                                <table role="presentation" cellpadding="0" cellspacing="0" style="background:none;border-radius:3px;width:35px;" border="0">
                                                                                                    <tbody>
                                                                                                        <tr>
                                                                                                            <td style="vertical-align:middle;width:35px;height:35px;">
                                                                                                                <a href=" https://www.facebook.com/Net Market Cap-/">
                                                                                                                    <img alt="facebook" height="35" src="https://s3-eu-west-1.amazonaws.com/ecomail-assets/editor/social-icos/outlined/facebook.png" style="display:block;border-radius:3px;" width="35">
                                                                                                                </a>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </tbody>
                                                                                                </table>
                                                                                            </td>
                                                                                            <td style="padding:4px 4px 4px 0;vertical-align:middle;">
                                                                                                <a href=" https://www.facebook.com/Net Market Cap-/" style="text-decoration:none;text-align:left;display:block;color:#333333;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:13px;line-height:22px;border-radius:3px;"></a>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                </table>
                                                                                <table role="presentation" cellpadding="0" cellspacing="0" style="float:none;display:inline-table;" align="center" border="0">
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td style="padding:4px;vertical-align:middle;">
                                                                                                <table role="presentation" cellpadding="0" cellspacing="0" style="background:none;border-radius:3px;width:35px;" border="0">
                                                                                                    <tbody>
                                                                                                        <tr>
                                                                                                            <td style="vertical-align:middle;width:35px;height:35px;">
                                                                                                                <a href="https://www.twitter.com/PROFILE">
                                                                                                                    <img alt="twitter" height="35" src="https://s3-eu-west-1.amazonaws.com/ecomail-assets/editor/social-icos/outlined/twitter.png" style="display:block;border-radius:3px;" width="35">
                                                                                                                </a>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </tbody>
                                                                                                </table>
                                                                                            </td>
                                                                                            <td style="padding:4px 4px 4px 0;vertical-align:middle;">
                                                                                                <a href="https://www.twitter.com/PROFILE" style="text-decoration:none;text-align:left;display:block;color:#333333;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:13px;line-height:22px;border-radius:3px;"></a>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </tbody>
                                                                                </table>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="word-wrap:break-word;font-size:0px;padding:0px 20px 0px 20px;" align="center">
                                                                            <div style="cursor:auto;color:#000000;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:22px;text-align:center;">
                                                                                <p>You are receiving this email because you have Net Market Cap&#xA0;account.
                                                                                    <br>If you have got this message in error or do not wish to receive any further communications, please contact support.
                                                                                    <br>2018 Net Market Cap. All rights reserved.</p>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </body>

                            </html>


                        ')
    mail  = Mail.new(from, subject, to, content)
    sg    = SendGrid::API.new(api_key: Rails.application.secrets.sendgrid_api)
    response = sg.client.mail._('send').post(request_body: mail.to_json)
  end

  def self.send_recovery_email(user,new_password)
    @new_password = new_password
    @user         = user
    from      = Email.new(email: 'noreply@netmarketcap.co')
    to        = Email.new(email: @user.email)
    subject   = 'Net Market Cap - Password Changed'

    content   = Content.new(type: 'text/html', value:'
                        <!DOCTYPE html>
                          <html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">
                          <head>
                              <title></title>
                              <meta http-equiv="X-UA-Compatible" content="IE=edge">
                              <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                              <meta name="viewport" content="width=device-width, initial-scale=1.0">
                              <style type="text/css">
                                  .ReadMsgBody {
                                      width: 100%;
                                  }
                                  .ExternalClass {
                                      width: 100%;
                                  }
                                  .ExternalClass * {
                                      line-height: 100%;
                                  }
                                  body {
                                      margin: 0;
                                      padding: 0;
                                      -webkit-text-size-adjust: 100%;
                                      -ms-text-size-adjust: 100%;
                                  }

                                  table,
                                  td {
                                      border-collapse: collapse;
                                  }

                                  img {
                                      border: 0;
                                      height: auto;
                                      line-height: 100%;
                                      outline: none;
                                      text-decoration: none;
                                      -ms-interpolation-mode: bicubic;
                                  }

                                  p {
                                      display: block;
                                      margin: 13px 0;
                                  }
                              </style>
                              <style type="text/css">
                                  @media only screen and (max-width:480px) {
                                      @viewport {
                                          width: 320px;
                                      }
                                  }
                              </style>
                              <link href="https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700" rel="stylesheet" type="text/css">
                              <style type="text/css">
                                  @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);
                              </style>
                          </head>

                          <body style="background: transparent !important;">
                              <div style="background-color:transparent;">
                                  <table role="presentation" cellpadding="0" cellspacing="0" style="font-size:0px;width:100%;" border="0">
                                      <tbody>
                                          <tr>
                                              <td>
                                                  <div style="margin:0px auto;max-width:600px;">
                                                      <table role="presentation" cellpadding="0" cellspacing="0" style="font-size:0px;width:100%;" align="center" border="0">
                                                          <tbody>
                                                              <tr>
                                                                  <td style="text-align:center;vertical-align:top;direction:ltr;font-size:0px;padding:9px 0px 9px 0px;">
                                                                      <div style="vertical-align:top;display:inline-block;direction:ltr;font-size:13px;text-align:left;width:100%;">
                                                                          <table role="presentation" cellpadding="0" cellspacing="0" width="100%" border="0">
                                                                              <tbody>
                                                                                  <tr>
                                                                                      <td style="word-wrap:break-word;font-size:0px;padding:0px 20px 0px 20px;" align="left">
                                                                                          <div style="cursor:auto;color:#000000;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:22px;text-align:left;">
                                                                                              <p>
                                                                                                  <span style="color:#17284c;">
                                                                                                      <span style="font-size:26px;">Dear customer!</span>
                                                                                                  </span>
                                                                                              </p>
                                                                                          </div>
                                                                                      </td>
                                                                                  </tr>
                                                                              </tbody>
                                                                          </table>
                                                                      </div>
                                                                      <div style="vertical-align:top;display:inline-block;direction:ltr;font-size:13px;text-align:left;width:100%;">
                                                                          <table role="presentation" cellpadding="0" cellspacing="0" width="100%" border="0">
                                                                              <tbody>
                                                                                  <tr>
                                                                                      <td style="word-wrap:break-word;font-size:0px;padding:0px 0px 0px 0px;" align="center">
                                                                                          <table role="presentation" cellpadding="0" cellspacing="0" style="border-collapse:collapse;border-spacing:0px;" align="center" border="0">
                                                                                              <tbody>
                                                                                                  <tr>

                                                                                                  <td style="width:200px;">
                                                                                                        ' + @@global_logo + '
                                                                                                    </td>

                                                                                                  </tr>
                                                                                              </tbody>
                                                                                          </table>
                                                                                      </td>
                                                                                  </tr>
                                                                              </tbody>
                                                                          </table>
                                                                      </div>
                                                                  </td>
                                                              </tr>
                                                          </tbody>
                                                      </table>
                                                  </div>
                                              </td>
                                          </tr>
                                      </tbody>
                                  </table>
                                  <div style="margin:0px auto;max-width:600px;">
                                      <table role="presentation" cellpadding="0" cellspacing="0" style="font-size:0px;width:100%;" align="center" border="0">
                                          <tbody>
                                              <tr>
                                                  <td style="text-align:center;vertical-align:top;direction:ltr;font-size:0px;padding:9px 0px 9px 0px;">
                                                      <div style="vertical-align:top;display:inline-block;direction:ltr;font-size:13px;text-align:left;width:100%;">
                                                          <table role="presentation" cellpadding="0" cellspacing="0" width="100%" border="0">
                                                              <tbody>
                                                                  <tr>
                                                                      <td style="word-wrap:break-word;font-size:0px;padding:10px 25px;padding-top:10px;padding-bottom:10px;padding-right:10px;padding-left:10px;">
                                                                          <p style="font-size:1px;margin:0px auto;border-top:4px solid #17284c;width:100%;"></p>
                                                                      </td>
                                                                  </tr>
                                                                  <tr>
                                                                      <td style="word-wrap:break-word;font-size:0px;padding:0px 20px 0px 20px;" align="center">
                                                                          <div style="cursor:auto;color:#000000;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:22px;text-align:center;">
                                                                              <h2 style="line-height: 100%;">
                                                                                  <span style="color:#17284c;">
                                                                                      <span style="font-size:22px;">Password recovery  Net Market Cap.</span>
                                                                                  </span>
                                                                                  <br>&#xA0;</h2>
                                                                              <p></p>
                                                                              <p>
                                                                                  <span style="font-size:20px;">
                                                                                    This is the new password for your account
                                                                                  </span>
                                                                                  <br/>
                                                                                  <h1> ' + @new_password + '</h1>
                                                                              </p>
                                                                          </div>
                                                                      </td>
                                                                  </tr>
                                                                  <tr>
                                                                      <td style="word-wrap:break-word;font-size:0px;padding:13px 25px 13px 25px;padding-top:10px;padding-left:25px;" align="center">
                                                                          <table role="presentation" cellpadding="0" cellspacing="0" style="border-collapse:separate;" align="center" border="0">
                                                                              <tbody>
                                                                                  <tr>
                                                                                      <td style="border:none;border-radius:none;color:#fff;cursor:auto;padding:10px 25px;" align="center" valign="middle" bgcolor="#17284c">
                                                                                          <a href="https://app.netmarketcap.co/#/login" style="text-decoration:none;background:#17284c;color:#fff;font-family:Ubuntu, Helvetica, Arial, sans-serif, Helvetica, Arial, sans-serif;font-size:19px;font-weight:normal;line-height:120%;text-transform:none;margin:0px;" target="_blank"> Login </a>
                                                                                      </td>
                                                                                  </tr>
                                                                              </tbody>
                                                                          </table>
                                                                      </td>
                                                                  </tr>
                                                                  <tr>
                                                                      <td style="word-wrap:break-word;font-size:0px;padding:10px 25px;padding-top:12px;padding-bottom:12px;padding-right:9px;padding-left:9px;">
                                                                          <p style="font-size:1px;margin:0px auto;border-top:4px solid #17284c;width:100%;"></p>
                                                                      </td>
                                                                  </tr>
                                                                  <tr>
                                                                      <td style="word-wrap:break-word;font-size:0px;padding:10px 25px;" align="center">
                                                                          <div>
                                                                              <table role="presentation" cellpadding="0" cellspacing="0" style="float:none;display:inline-table;" align="center" border="0">
                                                                                  <tbody>
                                                                                      <tr>
                                                                                          <td style="padding:4px;vertical-align:middle;">
                                                                                              <table role="presentation" cellpadding="0" cellspacing="0" style="background:none;border-radius:3px;width:35px;" border="0">
                                                                                                  <tbody>
                                                                                                      <tr>
                                                                                                          <td style="vertical-align:middle;width:35px;height:35px;">
                                                                                                              <a href="https://www.facebook.com/Net Market Cap-135725870448427/">
                                                                                                                  <img alt="facebook" height="35" src="https://s3-eu-west-1.amazonaws.com/ecomail-assets/editor/social-icos/outlined/facebook.png" style="display:block;border-radius:3px;" width="35">
                                                                                                              </a>
                                                                                                          </td>
                                                                                                      </tr>
                                                                                                  </tbody>
                                                                                              </table>
                                                                                          </td>
                                                                                          <td style="padding:4px 4px 4px 0;vertical-align:middle;">
                                                                                              <a href="https://www.facebook.com/Net Market Cap-135725870448427/" style="text-decoration:none;text-align:left;display:block;color:#333333;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:13px;line-height:22px;border-radius:3px;"></a>
                                                                                          </td>
                                                                                      </tr>
                                                                                  </tbody>
                                                                              </table>
                                                                              <table role="presentation" cellpadding="0" cellspacing="0" style="float:none;display:inline-table;" align="center" border="0">
                                                                                  <tbody>
                                                                                      <tr>
                                                                                          <td style="padding:4px;vertical-align:middle;">
                                                                                              <table role="presentation" cellpadding="0" cellspacing="0" style="background:none;border-radius:3px;width:35px;" border="0">
                                                                                                  <tbody>
                                                                                                      <tr>
                                                                                                          <td style="vertical-align:middle;width:35px;height:35px;">
                                                                                                              <a href="https://twitter.com/Net Market Cap2">
                                                                                                                  <img alt="twitter" height="35" src="https://s3-eu-west-1.amazonaws.com/ecomail-assets/editor/social-icos/outlined/twitter.png" style="display:block;border-radius:3px;" width="35">
                                                                                                              </a>
                                                                                                          </td>
                                                                                                      </tr>
                                                                                                  </tbody>
                                                                                              </table>
                                                                                          </td>
                                                                                          <td style="padding:4px 4px 4px 0;vertical-align:middle;">
                                                                                              <a href="https://twitter.com/Net Market Cap2" style="text-decoration:none;text-align:left;display:block;color:#333333;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:13px;line-height:22px;border-radius:3px;"></a>
                                                                                          </td>
                                                                                      </tr>
                                                                                  </tbody>
                                                                              </table>
                                                                          </div>
                                                                      </td>
                                                                  </tr>
                                                                  <tr>
                                                                      <td style="word-wrap:break-word;font-size:0px;padding:0px 20px 0px 20px;" align="center">
                                                                          <div style="cursor:auto;color:#000000;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:22px;text-align:center;">
                                                                              <p>You are receiving this email because you have Net Market Cap&#xA0;account.
                                                                                  <br>If you have got this message in error or do not wish to receive any further communications, please contact support.
                                                                                  <br>2018 Net Market Cap. All rights reserved.</p>
                                                                          </div>
                                                                      </td>
                                                                  </tr>
                                                              </tbody>
                                                          </table>
                                                      </div>
                                                  </td>
                                              </tr>
                                          </tbody>
                                      </table>
                                  </div>
                              </div>
                          </body>

                          </html>')
    
    mail  = Mail.new(from, subject, to, content)
    sg    = SendGrid::API.new(api_key: Rails.application.secrets.sendgrid_api)
    response = sg.client.mail._('send').post(request_body: mail.to_json)
  end

  def self.send_invoice(client,invoice)
    @invoice    = invoice
    invoice     = Invoice.find_by(uuid: @invoice.uuid)
    total       = invoice.price + invoice.fees
    from      = Email.new(email: 'noreply@netmarketcap.co')
    to        = Email.new(email: client.email)
    subject   = 'Net Market Cap - Payment Due'

    content   = Content.new(type: 'text/html', value:'
                        <!DOCTYPE html>
                        <html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">

                        <head>
                            <title></title>
                            <meta http-equiv="X-UA-Compatible" content="IE=edge">
                            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                            <style type="text/css">
                                .ReadMsgBody {
                                    width: 100%;
                                }

                                .ExternalClass {
                                    width: 100%;
                                }

                                .ExternalClass * {
                                    line-height: 100%;
                                }

                                body {
                                    margin: 0;
                                    padding: 0;
                                    -webkit-text-size-adjust: 100%;
                                    -ms-text-size-adjust: 100%;
                                }

                                table,
                                td {
                                    border-collapse: collapse;
                                }

                                img {
                                    border: 0;
                                    height: auto;
                                    line-height: 100%;
                                    outline: none;
                                    text-decoration: none;
                                    -ms-interpolation-mode: bicubic;
                                }

                                p {
                                    display: block;
                                    margin: 13px 0;
                                }
                            </style>
                            <style type="text/css">
                                .print-container {
                                    max-width: 900px;
                                    margin: 30px auto;
                                    background: white;
                                    padding: 10px 30px;
                                    .header {
                                        margin-bottom: 20px;
                                        border-bottom: 1px solid #dbdbdb;
                                        padding-bottom: 20px;
                                    }
                                    table {
                                        margin-top: 30px;
                                        tbody tr.no-border:first-child {
                                            opacity: 0.6!important;
                                        }
                                    }
                                    .summary-table {
                                        border: 1px solid #DDE1E4;
                                        & tr td:last-child {
                                            text-align: right;
                                        }
                                        & tr th:last-child {
                                            text-align: right;
                                        }
                                        td {
                                            border-left: 1px solid #dbdbdb;
                                        }
                                        th {
                                            border-left: 1px solid #dbdbdb;
                                        }
                                        thead {
                                            color: #737F8B;
                                            text-transform: uppercase;
                                        }
                                    }
                                    .ft-18 {
                                        font-size: 20px;
                                        margin-bottom: 10px;
                                    }
                                    .adder {
                                        font-size: 16px;
                                        font-weight: 500;
                                        text-align: right;
                                        border-left: 0;
                                        border-right: 0;
                                        border-bottom: 0;
                                    }
                                    .total {
                                        font-size: 22px;
                                    }
                                    .mega {
                                        font-size: 33px;
                                        margin-bottom: 10px;
                                    }
                                }

                                .invoice-logo {
                                    height: 80px;
                                    width: auto;
                                }

                                .other-rates {
                                    float: right;
                                    width: 350px;
                                    text-align: right;
                                    dl {
                                        width: 100%;
                                        margin-bottom: 5px;
                                        &.total {
                                            border-top: 1px solid #dbdbdb;
                                            padding-top: 10px;
                                        }
                                    }
                                    dt {
                                        width: 50%;
                                        float: left;
                                    }
                                    dd {
                                        width: 50%;
                                        float: left;
                                        padding-right: 10px;
                                        margin: 0;
                                    }
                                }

                                .invoice-from {
                                    float: right;
                                }

                                .summary-info {
                                    border-bottom: 1px solid #dbdbdb;
                                    margin-bottom: 20px;
                                    padding-bottom: 10px;
                                }

                                @media print {
                                    .print-container {}
                                    h1,
                                    h2,
                                    h3,
                                    h4,
                                    h5,
                                    h6 {
                                        font-weight: bold;
                                        &:first-letter {
                                            font-size: inherit;
                                        }
                                    }
                                }
                            </style>
                            <style type="text/css">
                                @media only screen and (max-width:480px) {
                                    @viewport {
                                        width: 320px;
                                    }
                                }
                            </style>
                            <link href="https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700" rel="stylesheet" type="text/css">
                            <style type="text/css">
                                @import url(https://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700);
                                @import url(https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css);
                            </style>
                        </head>

                        <body style="background: transparent !important;">
                            <div style="background-color:transparent;">
                                <table role="presentation" cellpadding="0" cellspacing="0" style="font-size:0px;width:100%;" border="0">
                                    <tbody>
                                        <tr>
                                            <td>
                                                <div style="margin:0px auto;max-width:600px;">
                                                    <table role="presentation" cellpadding="0" cellspacing="0" style="font-size:0px;width:100%;" align="center" border="0">
                                                        <tbody>
                                                            <tr>
                                                                <td style="text-align:center;vertical-align:top;direction:ltr;font-size:0px;padding:9px 0px 9px 0px;">
                                                                    <div style="vertical-align:top;display:inline-block;direction:ltr;font-size:13px;text-align:left;width:100%;">
                                                                        <table role="presentation" cellpadding="0" cellspacing="0" width="100%" border="0">
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td style="word-wrap:break-word;font-size:0px;padding:0px 20px 0px 20px;" align="left">
                                                                                        <div style="cursor:auto;color:#000000;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:22px;text-align:left;">
                                                                                            <p>
                                                                                                <span style="color:#17284c;">
                                                                                                    <span style="font-size:26px;">Dear ' + client.username + '!</span>
                                                                                                </span>
                                                                                            </p>
                                                                                        </div>
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                    <div style="vertical-align:top;display:inline-block;direction:ltr;font-size:13px;text-align:left;width:100%;">
                                                                        <table role="presentation" cellpadding="0" cellspacing="0" width="100%" border="0">
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td style="word-wrap:break-word;font-size:0px;padding:0px 0px 0px 0px;" align="center">
                                                                                        <table role="presentation" cellpadding="0" cellspacing="0" style="border-collapse:collapse;border-spacing:0px;" align="center" border="0">
                                                                                            <tbody>
                                                                                                <tr>
                                                                                                <td style="width:200px;">
                                                                                                    ' + @@global_logo + '                                                                                                 </td>
                                                                                                </tr>
                                                                                            </tbody>
                                                                                        </table>
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div style="margin:0px auto;max-width:600px;">
                                    <table role="presentation" cellpadding="0" cellspacing="0" style="font-size:0px;width:100%;" align="center" border="0">
                                        <tbody>
                                            <tr>
                                                <td style="text-align:center;vertical-align:top;direction:ltr;font-size:0px;padding:9px 0px 9px 0px;">
                                                    <div style="vertical-align:top;display:inline-block;direction:ltr;font-size:13px;text-align:left;width:100%;">
                                                        <table role="presentation" cellpadding="0" cellspacing="0" width="100%" border="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td style="word-wrap:break-word;font-size:0px;padding:10px 25px;padding-top:10px;padding-bottom:10px;padding-right:10px;padding-left:10px;">
                                                                        <p style="font-size:1px;margin:0px auto;border-top:4px solid #17284c;width:100%;"></p>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="word-wrap:break-word;font-size:0px;padding:0px 20px 0px 20px;" align="center">
                                                                        <div style="cursor:auto;color:#000000;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:22px;text-align:center;">
                                                                            <h2 style="line-height: 100%;">
                                                                                <span style="color:#17284c;">
                                                                                    <span style="font-size:22px;">Invoice for Payment plan - '  + invoice.plan.name +  '</span>
                                                                                </span>
                                                                                <br>&#xA0;</h2>
                                                                            <p></p>
                                                                            <p>
                                                                                <span style="font-size:20px;">
                                                                                    This is your plan payment support. It is important that you contact us if you have any problems.
                                                                                </span>
                                                                                <span style="font-size: 20px;">
                                                                                    <b>Plans activate Time after purchase</b>
                                                                                </span>
                                                                                <div class="print-container" style="font-size: 16px;">
                                                                                    <div class="body">
                                                                                        <h4 style="font-size: 26px;">Summary</h4>
                                                                                        <div class="summary-info" style="margin-left: 20px">
                                                                                            <table class="table summary-table">
                                                                                                <thead>

                                                                                                </thead>
                                                                                                <tbody>

                                                                                                </tbody>
                                                                                            </table>
                                                                                            <div class="row">
                                                                                                <div class="col-md-12">
                                                                                                    <div class="other-rates clearfix">
                                                                                                        <dl class="dl-horizontal clearfix">
                                                                                                            <dt>Price</dt>
                                                                                                            <dd>' + invoice.price.to_s + ' ' + invoice.currency.name.to_s + '</dd>
                                                                                                        </dl>
                                                                                                        <dl class="dl-horizontal clearfix">
                                                                                                            <dt>Fees</dt>
                                                                                                            <dd>' + invoice.fees.to_s + ' ' + invoice.currency.name.to_s + '</dd>
                                                                                                        </dl>
                                                                                                        <dl class="dl-horizontal total clearfix">
                                                                                                            <dt class="blue">Total</dt>
                                                                                                            <dd>' + total.to_s + ' ' + invoice.currency.name.to_s + '</dd>
                                                                                                        </dl>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>

                                                                                        <h4>Details</h4>
                                                                                        <div class="break-d">
                                                                                            <p><strong>Vendor Name:</strong> netmarketcap.co
                                                                                                <br />
                                                                                                <strong>Invoice No:</strong> ' + invoice.uuid + '
                                                                                            </p>
                                                                                            <br />
                                                                                            <br />
                                                                                            <strong>Payment wallet</strong>
                                                                                            <br />
                                                                                            <p>' + invoice.wallet + '</p>
                                                                                        </div>

                                                                                    </div>

                                                                                </div>
                                                                            </p>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="word-wrap:break-word;font-size:0px;padding:13px 25px 13px 25px;padding-top:10px;padding-left:25px;" align="center">
                                                                        <table role="presentation" cellpadding="0" cellspacing="0" style="border-collapse:separate;" align="center" border="0">
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td style="border:none;border-radius:none;color:#fff;cursor:auto;padding:10px 25px;" align="center" valign="middle" bgcolor="#17284c">
                                                                                        <a href="https://app.netmarketcap.co/#/login" style="text-decoration:none;background:#17284c;color:#fff;font-family:Ubuntu, Helvetica, Arial, sans-serif, Helvetica, Arial, sans-serif;font-size:19px;font-weight:normal;line-height:120%;text-transform:none;margin:0px;" target="_blank">  Login Net Market Cap </a>
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="word-wrap:break-word;font-size:0px;padding:10px 25px;padding-top:12px;padding-bottom:12px;padding-right:9px;padding-left:9px;">
                                                                        <p style="font-size:1px;margin:0px auto;border-top:4px solid #17284c;width:100%;"></p>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="word-wrap:break-word;font-size:0px;padding:10px 25px;" align="center">
                                                                        <div>
                                                                            <table role="presentation" cellpadding="0" cellspacing="0" style="float:none;display:inline-table;" align="center" border="0">
                                                                                <tbody>
                                                                                    <tr>
                                                                                        <td style="padding:4px;vertical-align:middle;">
                                                                                            <table role="presentation" cellpadding="0" cellspacing="0" style="background:none;border-radius:3px;width:35px;" border="0">
                                                                                                <tbody>
                                                                                                    <tr>
                                                                                                        <td style="vertical-align:middle;width:35px;height:35px;">
                                                                                                            <a href=" https://www.facebook.com/Net Market Cap-135725870448427/">
                                                                                                                <img alt="facebook" height="35" src="https://s3-eu-west-1.amazonaws.com/ecomail-assets/editor/social-icos/outlined/facebook.png" style="display:block;border-radius:3px;" width="35">
                                                                                                            </a>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </tbody>
                                                                                            </table>
                                                                                        </td>
                                                                                        <td style="padding:4px 4px 4px 0;vertical-align:middle;">
                                                                                            <a href=" https://www.facebook.com/Net Market Cap-135725870448427/" style="text-decoration:none;text-align:left;display:block;color:#333333;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:13px;line-height:22px;border-radius:3px;"></a>
                                                                                        </td>
                                                                                    </tr>
                                                                                </tbody>
                                                                            </table>
                                                                            <table role="presentation" cellpadding="0" cellspacing="0" style="float:none;display:inline-table;" align="center" border="0">
                                                                                <tbody>
                                                                                    <tr>
                                                                                        <td style="padding:4px;vertical-align:middle;">
                                                                                            <table role="presentation" cellpadding="0" cellspacing="0" style="background:none;border-radius:3px;width:35px;" border="0">
                                                                                                <tbody>
                                                                                                    <tr>
                                                                                                        <td style="vertical-align:middle;width:35px;height:35px;">
                                                                                                            <a href="https://twitter.com/Net Market Cap2">
                                                                                                                <img alt="twitter" height="35" src="https://s3-eu-west-1.amazonaws.com/ecomail-assets/editor/social-icos/outlined/twitter.png" style="display:block;border-radius:3px;" width="35">
                                                                                                            </a>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </tbody>
                                                                                            </table>
                                                                                        </td>
                                                                                        <td style="padding:4px 4px 4px 0;vertical-align:middle;">
                                                                                            <a href="https://twitter.com/Net Market Cap2" style="text-decoration:none;text-align:left;display:block;color:#333333;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:13px;line-height:22px;border-radius:3px;"></a>
                                                                                        </td>
                                                                                    </tr>
                                                                                </tbody>
                                                                            </table>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="word-wrap:break-word;font-size:0px;padding:0px 20px 0px 20px;" align="center">
                                                                        <div style="cursor:auto;color:#000000;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:11px;line-height:22px;text-align:center;">
                                                                            <p>You are receiving this email because you have Net Market Cap&#xA0;account.
                                                                                <br>If you have got this message in error or do not wish to receive any further communications, please contact support.
                                                                                <br>2018 Net Market Cap. All rights reserved.</p>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </body>
                        </html>')
    mail  = Mail.new(from, subject, to, content)
    sg    = SendGrid::API.new(api_key: Rails.application.secrets.sendgrid_api)
    response = sg.client.mail._('send').post(request_body: mail.to_json)
  end
end