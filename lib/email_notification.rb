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