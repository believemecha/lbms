# config/initializers/session_store.rb

Rails.application.config.session_store :cookie_store, 
                                       key: '_lbms_app_session', 
                                       secure: Rails.env.production?, 
                                       httponly: true, 
                                       same_site: :lax