class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
                    storage: :s3,
                    s3_credentials: {
                      access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
                      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
                      bucket:            ENV['S3_BUCKET'],
                      region: 'us-east-1'
                    },
                    url: 'ckeditor_assets/pictures/:id/:style_:basename.:extension',
                    path: 'ckeditor_assets/pictures/:id/:style_:basename.:extension'

  validates_attachment_presence :data
  validates_attachment_size :data, less_than: 2.megabytes
  validates_attachment_content_type :data, content_type: /\Aimage/

  def url_content
    url(:content)
  end
end
