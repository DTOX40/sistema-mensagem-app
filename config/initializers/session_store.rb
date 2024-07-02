Rails.application.config.session_store :cookie_store, key: '_sistema_mensagem_app_session', secure: Rails.env.production?, expire_after: 30.minutes
