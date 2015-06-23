require 'digest/md5'

module Devise
  module Encryptor
    def self.digest_md5(password, stretches, salt, pepper)
      Digest::MD5.hexdigest(password + salt)
    end
  end
end
