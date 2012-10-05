class Provider::Linkedin < Provider::Provider
  def profile_link
    if @uid
      @uid =~ /^http/ ? @uid : "http://www.linkedin.com/pub/#{@uid}"
    end
  end
end
