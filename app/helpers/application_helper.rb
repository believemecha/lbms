module ApplicationHelper
    require 'fcm'
    def fcm_push_notification(title="",body="",duration=5,token)
        server_key="AAAAgoqm9GI:APA91bGQnpAMd9yDxRzskIaLRbQtoyEX4I0GUAwi8McR5TBntLUxOKNuOHSVSXVosqryFqsatUuMN-8-rhV7AYrlN6IjC63BuLvc1XrhL-fQQ4RriH1R-1yT_QMCgWoaqzstmq2q0i-N"
        fcm = FCM.new(
            server_key
        )
        options = { priority: 'high',
                    data: { title: title, body: body, image: "token",action: "play",duration: duration },
                    notification: { 
                        title: title,
                        body: body,
                        sound: 'default',
                    }
                  }
        response = fcm.send(token, options)
        response
    end

    def fcm_send_message_push_notification(phone,message,token)
        server_key="AAAAgoqm9GI:APA91bGQnpAMd9yDxRzskIaLRbQtoyEX4I0GUAwi8McR5TBntLUxOKNuOHSVSXVosqryFqsatUuMN-8-rhV7AYrlN6IjC63BuLvc1XrhL-fQQ4RriH1R-1yT_QMCgWoaqzstmq2q0i-N"
        fcm = FCM.new(
            server_key
        )
        options = { priority: 'high',
                    data: { title: "Send Message", body: "To #{phone}", image: "token",action: "send_message",phone: phone,message: message },
                  }
        response = fcm.send(token, options)
        response
    end
end
