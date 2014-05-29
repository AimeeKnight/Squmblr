require 'spec_helper'
require 'carrierwave/test/matchers'

describe ImageUploader do
  include CarrierWave::Test::Matchers

  before do
    image_path = 'spec/data/Capybara.jpg'
    @post = Post.create!(content: "This is some test content", user_id: 1)
    ImageUploader.enable_processing = true
    @uploader = ImageUploader.new(@post, :image)
    @uploader.store!(File.open(image_path))
  end

  after do
    ImageUploader.enable_processing = false
    @uploader.remove!
  end

  context 'the thumb version' do
    it "should scale down a landscape image to be exactly 64 by 64 pixels" do
      @uploader.thumb.should have_dimensions(75, 75)
    end
  end

end
