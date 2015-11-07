require 'front_end_builds/utils/ssh_pubkey_convert'
require 'base64'
require 'openssl'

module FrontEndBuilds
  class Pubkey < ActiveRecord::Base
    if defined?(ProtectedAttributes) || ::ActiveRecord::VERSION::MAJOR < 4
      attr_accessible :name,
                      :pubkey
    end

    validates :name, presence: true
    validates :pubkey, presence: true

    has_many :builds, class_name: "FrontEndBuilds::Build"

    def fingerprint
      content = pubkey.split(/\s/)[1]

      if content
        Digest::MD5.hexdigest(Base64.decode64(content))
          .scan(/.{1,2}/)
          .join(":")
      else
        'Unknown'
      end
    end

    def ssh_pubkey?
      (type, b64, _) = pubkey.split(/\s/)
      %w{ssh-rsa ssh-dss}.include?(type) && b64.present?
    end

    # Public: In order to verify a signature we need the key to be an OpenSSL
    # RSA PKey and not a string that you would find in an ssh pubkey key. Most
    # people are going to be adding ssh public keys to their build system, this
    # method will covert them to OpenSSL RSA if needed.
    def to_rsa_pkey
      FrontEndBuilds::Utils::SSHPubKeyConvert
        .convert(pubkey)
    end

    # Public: Will verify that the sigurate has access to deploy the build
    # object. The signature includes the endpoint and app name.
    #
    # Returns boolean
    def verify(build)
      # TODO might as well cache this and store in the db so we dont have to
      # convert every time
      pkey = to_rsa_pkey
      signature = Base64.decode64(build.signature)
      digest = OpenSSL::Digest::SHA256.new

      # If the user submits html were going to expect the
      # signature to match the html they are submitting.
      # However, if the user gives a url where we can download
      # the html, we're going to expect the signature to match
      # the app name and the url.
      if build.endpoint.present?
        expected = "#{build.app.name}-#{build.endpoint}"
      else
        expected = build.html
      end

      match = expected &&
        signature &&
        pkey.verify(digest, signature, expected)
      # Bug in ruby's OpenSSL implementation.
      # SSL connection with PostgreSQL can fail, after a call to
      # OpenSSL::X509::Certificate#verify with result 'false'. Root cause is
      # the thread local error queue of OpenSSL, that is used to transmit
      # textual error messages to the application after a failed crypto
      # operation. A failure in Certificate#verify leaves some messages on the
      # error queue, which can lead to errors in a SSL communication of other
      # parts of the application. The only solution at the moment is running:
      # OpenSSL.errors.clear after certificate verifying. This clears OpenSSL
      # errors array and keeps database connection alive.
      # From https://bugs.ruby-lang.org/issues/7215
      OpenSSL.errors.clear
      match # return true/false
    end

    def last_build
      builds
        .order('created_at desc')
        .limit(1)
        .first
    end

    def serialize
      {
        id: id,
        name: name,
        fingerprint: fingerprint,
        lastUsedAt: last_build.try(:created_at)
      }
    end
  end
end
