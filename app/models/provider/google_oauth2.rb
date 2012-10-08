class Provider::GoogleOauth2 < Provider::Provider
  def profile_link
    @uid
  end
end
