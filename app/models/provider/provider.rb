class Provider::Provider
  PRINTABLE_NAMES = {
    :facebook => "Facebook",
    :vkontakte => "Vkontakte",
    :google_oauth2 => "Google",
    :twitter => "Twitter",
    :github => "Github",
    :linkedin => "Linkedin"
  }

  def initialize(uid)
    @uid = uid.to_s if uid
  end

  def printable_name
    PRINTABLE_NAMES[self.provider_name] || class_without_namespace
  end

  def provider_name
    class_without_namespace.underscore.to_sym
  end

  private

  def class_without_namespace
    self.class.name.split('::').last
  end
end
