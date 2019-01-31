require 'rails_helper'

module FrontEndBuilds
  RSpec.describe Pubkey, :type => :model do
    let(:fixture_directory) { Rails.root.join('..', 'fixtures') }

    let(:ssh_public_key) do
      File.read(File.join(fixture_directory, 'id_rsa.pub'))
    end

    let(:pubkey) do
      create(:front_end_builds_pubkey, {
        pubkey: ssh_public_key
      })
    end

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:pubkey) }

    describe '#fingerprint' do
      it 'should give the finger print of the pubkey' do
        expect(pubkey.fingerprint)
          .to eq('30:b9:ee:c1:ee:ec:f3:8a:a3:e0:f1:1d:5c:fe:1e:03')
      end

      it 'should be unknown if it cannot figure out the pubkey' do
        pubkey = create(:front_end_builds_pubkey, {
          pubkey: 'badinfo'
        })

        expect(pubkey.fingerprint).to eq('Unknown')
      end
    end

    describe '#ssh_pubkey?' do
      it 'should be true for a ssh-rsa pubkey' do
        expect(pubkey.ssh_pubkey?).to be_truthy
      end

      it 'should be true even if the key has no comment' do
        # remove last part of key, which is the comment
        pubkey.pubkey = pubkey.pubkey.split(/\s/)[0..-2].join(' ')

        expect(pubkey.ssh_pubkey?).to be_truthy
      end

      it 'should be false if the type of unknown' do
        pubkey = create(:front_end_builds_pubkey, {
          pubkey: 'ssh-UNKNOWN badkeybutwhocares'
        })

        expect(pubkey.ssh_pubkey?).to be_falsey
      end

      it 'should be false if the key has no base64 encoded part' do
        pubkey = create(:front_end_builds_pubkey, {
          pubkey: 'someotherkeyformat'
        })

        expect(pubkey.ssh_pubkey?).to be_falsey
      end
    end

    describe '#to_rsa_pkey' do
      let(:rsa_pem_key) do
        "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4c7SGwMHroke/tg3BCd3\niSxJpGXd6UZiq5D8XMbwogxrkLQV1+SNLsGSszwCf17ISRZaVzOQ7OB15p4Dy3f0\nV/XDOK6wT0aFnuiBqwdnsO0davI63WuAnGb7DEWQBlBz2V/GZ+L5HiBaykWxQ0WI\ne6dpbIE6ozSgjGQ+Xs3iR1XazhytBf7O3bYRUI4qndWfSXgeIlOX+RjCXxSWExgG\n0pu1YwMj17h6SPeqWT9NpS6tS7luxlCx9sr6QXpHKlKT9fQ44m07J8mfriG86SkG\nXEUVogKCEkd1G8FhqfArbZwJydLnXUpZ3hWQ8crA5q9DwZGh2Mp+ANH8X/UxTkrl\ngwIDAQAB\n-----END PUBLIC KEY-----\n"
      end

      it 'it should convert the ssh public key into an rsa pkey' do
        expect(pubkey.to_rsa_pkey.to_s).to eq(rsa_pem_key)
      end

      it 'should raise an error if it cannot convert' do
        pubkey = create(:front_end_builds_pubkey, {
          pubkey: 'badkey'
        })

        expect { pubkey.to_rsa_pkey }.to raise_error( ArgumentError, "Invalid SSH public key 'badkey'" )
      end
    end

    describe '#verify' do
      let(:app) do
        create(:front_end_builds_app, name: 'app')
      end

      let(:endpoint) { 'http://some.external.url.ted.com/index.html' }

      let(:build) do
        FactoryBot.build(:front_end_builds_build, {
          app: app,
          endpoint: endpoint
        })
      end

      it 'should verify the signature is valid for a build' do
        build.signature = create_signature("#{app.name}-#{endpoint}")
        expect(pubkey.verify(build)).to be_truthy
      end

      it 'should verify the signature + html for a build without an endpoint' do
        build = create(:front_end_builds_build, {
          app: app,
          html: 'some html',
          endpoint: nil,
          signature: create_signature('some html')
        })

        expect(pubkey.verify(build)).to be_truthy
      end

      it 'should not verify a bad signature for a build' do
        build.signature = create_signature('bad-verybad')
        expect(pubkey.verify(build)).to be_falsey
      end

      it 'should not verify a bad html signature for a build' do
        build = create(:front_end_builds_build, {
          app: app,
          html: 'some html',
          endpoint: nil,
          signature: create_signature('verybad')
        })

        expect(pubkey.verify(build)).to be_falsey
      end
    end

    describe '#last_build' do
      let(:pubkey) { create(:front_end_builds_pubkey) }

      it 'should be nil if this pubkey was never used in a build' do
        expect(pubkey.last_build).to be_nil
      end

      it 'should be the most recently created build' do
        build = create(:front_end_builds_build, {
          pubkey: pubkey,
          created_at: 2.hours.ago
        })

        create(:front_end_builds_build, {
          pubkey: pubkey,
          created_at: 3.hours.ago
        })

        expect(pubkey.last_build).to eq(build)
      end
    end

    describe '#serialize' do
      subject { pubkey.serialize }
      its([:id]) { should eq(pubkey.id) }
      its([:name]) { should eq(pubkey.name) }
      its([:fingerprint]) { should eq(pubkey.fingerprint) }
    end
  end
end
