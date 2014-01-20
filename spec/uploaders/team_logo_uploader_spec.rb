require 'spec_helper'

require 'carrierwave/test/matchers'

describe TeamLogoUploader do
  include CarrierWave::Test::Matchers

  let(:uploader) do
    TeamLogoUploader.new(FactoryGirl.build(:team),
      :team_logo)
  end

  let(:path) do
    Rails.root.join('spec/file_fixtures/default_photo.jpg')
  end

  before do
    TeamLogoUploader.enable_processing = true
  end

  after do
    TeamLogoUploader.enable_processing = false
  end

  it 'stores without error' do
    expect(lambda { uploader.store!(File.open(path)) }).to_not raise_error
  end
end
