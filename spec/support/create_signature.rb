require 'openssl'
require 'base64'

module CreateSignature
  def create_signature(text)
    private_key = File.read(Rails.root.join('..', 'fixtures', 'id_rsa'))
    pkey = OpenSSL::PKey::RSA.new(private_key)
    digest = OpenSSL::Digest::SHA256.new
    signature = pkey.sign(digest, text)

    Base64.encode64(signature)
  end
end
