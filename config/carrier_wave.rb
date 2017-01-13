
require 'carrierwave'
if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Configuration for Amazon S3
      :provider              => 'AWS',
      :aws_access_key_id     => 'AKIAIANYOHLGZNIVATIQ',
      :aws_secret_access_key => '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'
    }
    config.fog_directory     =  'make-mentor-bucket'
  end
end
