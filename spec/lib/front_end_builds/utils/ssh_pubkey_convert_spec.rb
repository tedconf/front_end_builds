require 'rails_helper'
require 'front_end_builds/utils/ssh_pubkey_convert'

require'byebug'
module FrontEndBuilds
  module Utils
    RSpec.describe SSHPubKeyConvert do
      describe '.convert' do
        context "RSA Key" do
          let(:public_key) { "spec/fixtures/id_rsa.pub" }
          let(:output_pkey) { "spec/fixtures/id_rsa_as_open_ssl_pkey" }

          it "converts a RSA keys to a pkey as expected" do
            key_contents = File.read(public_key)
            expected_output = File.read(output_pkey).chomp
            conversion_output = FrontEndBuilds::Utils::SSHPubKeyConvert.convert(key_contents).to_s.chomp
            expect(conversion_output).to eq(expected_output)
          end
        end

        context "DSA Key" do
          let(:public_key) { "spec/fixtures/id_dsa.pub" }

          it "throws an error if passed an id_ecdsa key" do
            key_contents = File.read(public_key)
            expect {
              FrontEndBuilds::Utils::SSHPubKeyConvert.convert(key_contents).to_s.chomp
            }.to raise_error('Unsupported key type: ssh-dss')
          end
        end

        context "ECDSA Key" do
          let(:public_key) { "spec/fixtures/id_ecdsa.pub" }

          it "throws an error if passed an id_ecdsa key" do
            key_contents = File.read(public_key)
            expect {
              FrontEndBuilds::Utils::SSHPubKeyConvert.convert(key_contents).to_s.chomp
            }.to raise_error('Unsupported key type: ecdsa-sha2-nistp256')
          end
        end
      end
    end
  end
end
