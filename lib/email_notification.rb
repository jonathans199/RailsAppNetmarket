module EmailNotification 
  @@global_logo = '<img alt="" title="" height="auto" src="data:image/png;base64,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
  " style="border:none;border-radius:0px;display:block;font-size:13px;outline:none;text-decoration:none;width:100%;height:auto;  margin-left: 200px;
  margin-top: -51px;
" width="150">'
  require 'sendgrid-ruby'
  include SendGrid

  def self.send_not_active_subscription(user, subscription)
    subscription.plan.subscription ? p_type = 'inscripcion a bot' : p_type = 'inversion'
    subscription.plan.subscription ? r_type = ' por tus planes de inversión y referidos' : r_type = ' por rendimiento de plan de inversión'
    from      = Email.new(email: 'noreply@tradingwaves.co')
    to        = Email.new(email: user.email)
    subject   = 'Trading Waves - Subscription canceled'
    content   = Content.new(type: 'text/html', value:"
                        <div style='font-family: sans-serif; text-align: center; width: 500px; height: auto; margin-right: auto; margin-left: auto; padding: 10px 20px 40px 20px; background-color: #06071A;'>
                        <h1 style='color: #e6cc7e; font-size: 300%; text-align: left;'>Trading Waves</h1>
                        <br/>
                        <h2 style='color: white; font-size: 200%;'>SUBSCRIPTION CANCELED</h2>
                        <h3 style='font-size: 150%; color: #e6cc7e; display: inline; margin-right: 20px;'>USER</h3>
                        <p style='font-size: 130%; color: white; display: inline;'>#{user.username.upcase}</p>
                        <br/>
                        <div style='border: 5px solid #e6cc7e; width: 420px; height: auto; margin-right: auto; margin-left: auto; margin-top: 20px; text-align: justify; padding: 20px 20px;'>
                        <p style='font-size: 120%; color: white; display: inline;'>Your subscription to the plan <span style='font-size: 130%; color: #e6cc7e;'>#{subscription.plan.name.upcase}</span> has ended.</p>
                        <br/>
                        </div>
                        </div>")
    mail  = Mail.new(from, subject, to, content)
    sg    = SendGrid::API.new(api_key: Rails.application.secrets.sendgrid_api)
    response = sg.client.mail._('send').post(request_body: mail.to_json)
  end
  
  def self.send_not_active_notification(parent, user, subs)
    from      = Email.new(email: 'noreply@tradingwaves.co')
    to        = Email.new(email: parent.email)
    subject   = 'Trading Waves - Cancel reward'

    content   = Content.new(type: 'text/html', value: "
                        <div style='font-family: sans-serif; text-align: center; width: 500px; height: auto; margin-right: auto; margin-left: auto; padding: 10px 20px 40px 20px; background-color: #06071A;'>
                        <h1 style='color: #e6cc7e; font-size: 300%; text-align: left;'>Trading Waves</h1>
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
    from      = Email.new(email: 'noreply@tradingwaves.co')
    to        = Email.new(email: user.email)
    subject   = 'Trading Waves register confirmation'
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
                                                                  <span style="font-size:22px;">Welcome to Trading Waves.</span>
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
                                                                                          <a href="https://www.facebook.com/Trading Waves-/">
                                                                                              <img alt="facebook" height="35" src="https://s3-eu-west-1.amazonaws.com/ecomail-assets/editor/social-icos/outlined/facebook.png" style="display:block;border-radius:3px;" width="35">
                                                                                          </a>
                                                                                      </td>
                                                                                  </tr>
                                                                              </tbody>
                                                                          </table>
                                                                      </td>
                                                                      <td style="padding:4px 4px 4px 0;vertical-align:middle;">
                                                                          <a href="https://www.facebook.com/Trading Waves-/  " style="text-decoration:none;text-align:left;display:block;color:#333333;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:13px;line-height:22px;border-radius:3px;"></a>
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
                                                                                          <a href="https://twitter.com/Trading Waves2">
                                                                                              <img alt="twitter" height="35" src="https://s3-eu-west-1.amazonaws.com/ecomail-assets/editor/social-icos/outlined/twitter.png" style="display:block;border-radius:3px;" width="35">
                                                                                          </a>
                                                                                      </td>
                                                                                  </tr>
                                                                              </tbody>
                                                                          </table>
                                                                      </td>
                                                                      <td style="padding:4px 4px 4px 0;vertical-align:middle;">
                                                                          <a href="https://twitter.com/Trading Waves2" style="text-decoration:none;text-align:left;display:block;color:#333333;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:13px;line-height:22px;border-radius:3px;"></a>
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
                                                          <p>You are receiving this email because you have Trading Waves&#xA0;account.
                                                              <br>If you have got this message in error or do not wish to receive any further communications, please contact support.
                                                              <br>2018 Trading Waves. All rights reserved.</p>
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
    from      = Email.new(email: 'noreply@tradingwaves.co')
    to        = Email.new(email: invoice.user.email)
    subject   = 'Trading Waves - New Subscription'
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
                                                                                            <a href="https://app.tradingwaves.co/#/login" style="text-decoration:none;background:#17284c;color:#fff;font-family:Ubuntu, Helvetica, Arial, sans-serif, Helvetica, Arial, sans-serif;font-size:19px;font-weight:normal;line-height:120%;text-transform:none;margin:0px;" target="_blank"> Login </a>
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
                                                                                                                <a href=" https://www.facebook.com/Trading Waves-/">
                                                                                                                    <img alt="facebook" height="35" src="https://s3-eu-west-1.amazonaws.com/ecomail-assets/editor/social-icos/outlined/facebook.png" style="display:block;border-radius:3px;" width="35">
                                                                                                                </a>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </tbody>
                                                                                                </table>
                                                                                            </td>
                                                                                            <td style="padding:4px 4px 4px 0;vertical-align:middle;">
                                                                                                <a href=" https://www.facebook.com/Trading Waves-/" style="text-decoration:none;text-align:left;display:block;color:#333333;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:13px;line-height:22px;border-radius:3px;"></a>
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
                                                                                <p>You are receiving this email because you have Trading Waves&#xA0;account.
                                                                                    <br>If you have got this message in error or do not wish to receive any further communications, please contact support.
                                                                                    <br>2018 Trading Waves. All rights reserved.</p>
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
    from      = Email.new(email: 'noreply@tradingwaves.co')
    to        = Email.new(email: @user.email)
    subject   = 'Trading Waves password recovery'

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
                                                                                      <span style="font-size:22px;">Password recovery  Trading Waves.</span>
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
                                                                                          <a href="https://app.tradingwaves.co/#/login" style="text-decoration:none;background:#17284c;color:#fff;font-family:Ubuntu, Helvetica, Arial, sans-serif, Helvetica, Arial, sans-serif;font-size:19px;font-weight:normal;line-height:120%;text-transform:none;margin:0px;" target="_blank"> Login </a>
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
                                                                                                              <a href="https://www.facebook.com/Trading Waves-135725870448427/">
                                                                                                                  <img alt="facebook" height="35" src="https://s3-eu-west-1.amazonaws.com/ecomail-assets/editor/social-icos/outlined/facebook.png" style="display:block;border-radius:3px;" width="35">
                                                                                                              </a>
                                                                                                          </td>
                                                                                                      </tr>
                                                                                                  </tbody>
                                                                                              </table>
                                                                                          </td>
                                                                                          <td style="padding:4px 4px 4px 0;vertical-align:middle;">
                                                                                              <a href="https://www.facebook.com/Trading Waves-135725870448427/" style="text-decoration:none;text-align:left;display:block;color:#333333;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:13px;line-height:22px;border-radius:3px;"></a>
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
                                                                                                              <a href="https://twitter.com/Trading Waves2">
                                                                                                                  <img alt="twitter" height="35" src="https://s3-eu-west-1.amazonaws.com/ecomail-assets/editor/social-icos/outlined/twitter.png" style="display:block;border-radius:3px;" width="35">
                                                                                                              </a>
                                                                                                          </td>
                                                                                                      </tr>
                                                                                                  </tbody>
                                                                                              </table>
                                                                                          </td>
                                                                                          <td style="padding:4px 4px 4px 0;vertical-align:middle;">
                                                                                              <a href="https://twitter.com/Trading Waves2" style="text-decoration:none;text-align:left;display:block;color:#333333;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:13px;line-height:22px;border-radius:3px;"></a>
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
                                                                              <p>You are receiving this email because you have Trading Waves&#xA0;account.
                                                                                  <br>If you have got this message in error or do not wish to receive any further communications, please contact support.
                                                                                  <br>2018 Trading Waves. All rights reserved.</p>
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
    from      = Email.new(email: 'noreply@tradingwaves.co')
    to        = Email.new(email: client.email)
    subject   = 'Trading Waves - Invoice created'

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
                                                                                            <p><strong>Vendor Name:</strong> tradingwaves.co
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
                                                                                        <a href="https://app.tradingwaves.co/#/login" style="text-decoration:none;background:#17284c;color:#fff;font-family:Ubuntu, Helvetica, Arial, sans-serif, Helvetica, Arial, sans-serif;font-size:19px;font-weight:normal;line-height:120%;text-transform:none;margin:0px;" target="_blank">  Login Trading Waves </a>
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
                                                                                                            <a href=" https://www.facebook.com/Trading Waves-135725870448427/">
                                                                                                                <img alt="facebook" height="35" src="https://s3-eu-west-1.amazonaws.com/ecomail-assets/editor/social-icos/outlined/facebook.png" style="display:block;border-radius:3px;" width="35">
                                                                                                            </a>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </tbody>
                                                                                            </table>
                                                                                        </td>
                                                                                        <td style="padding:4px 4px 4px 0;vertical-align:middle;">
                                                                                            <a href=" https://www.facebook.com/Trading Waves-135725870448427/" style="text-decoration:none;text-align:left;display:block;color:#333333;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:13px;line-height:22px;border-radius:3px;"></a>
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
                                                                                                            <a href="https://twitter.com/Trading Waves2">
                                                                                                                <img alt="twitter" height="35" src="https://s3-eu-west-1.amazonaws.com/ecomail-assets/editor/social-icos/outlined/twitter.png" style="display:block;border-radius:3px;" width="35">
                                                                                                            </a>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </tbody>
                                                                                            </table>
                                                                                        </td>
                                                                                        <td style="padding:4px 4px 4px 0;vertical-align:middle;">
                                                                                            <a href="https://twitter.com/Trading Waves2" style="text-decoration:none;text-align:left;display:block;color:#333333;font-family:Ubuntu, Helvetica, Arial, sans-serif;font-size:13px;line-height:22px;border-radius:3px;"></a>
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
                                                                            <p>You are receiving this email because you have Trading Waves&#xA0;account.
                                                                                <br>If you have got this message in error or do not wish to receive any further communications, please contact support.
                                                                                <br>2018 Trading Waves. All rights reserved.</p>
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