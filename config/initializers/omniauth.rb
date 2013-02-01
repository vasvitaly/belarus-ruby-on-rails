Devise.setup do |config|

  credentials = SOCIAL_CONFIG['github'] || {}
  config.omniauth :github, credentials['app_id'], credentials['secret_key'],
                { :client_options => { :ssl => { :ca_path => "/etc/ssl/certs" }}}

  credentials = SOCIAL_CONFIG['facebook'] || {}
  config.omniauth :facebook, credentials['app_id'], credentials['secret_key'],
                { :scope => 'email',
                  :client_options => { :ssl => { :ca_path => "/etc/ssl/certs" }}}

  credentials = SOCIAL_CONFIG['vkontakte'] || {}
  config.omniauth :vkontakte, credentials['app_id'], credentials['secret_key']

  credentials = SOCIAL_CONFIG['twitter'] || {}
  config.omniauth :twitter, credentials['app_id'], credentials['secret_key']

  credentials = SOCIAL_CONFIG['google'] || {}
  config.omniauth :google_oauth2, credentials['app_id'], credentials['secret_key']

  credentials = SOCIAL_CONFIG['linkedin'] || {}
  config.omniauth :linkedin, credentials['app_id'], credentials['secret_key'],
                  :site => 'https://api.linkedin.com/',
                  :authorize_path => '/uas/oauth/authorize',
                  :access_token_path => '/uas/oauth/accessToken'
end
