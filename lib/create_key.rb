module CreateKey
  def self.call(options)
    Base64.urlsafe_encode64(Digest::SHA256.base64digest(options.to_json))[0..16]
  end
end
