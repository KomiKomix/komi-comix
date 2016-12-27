SitemapGenerator::Sitemap.default_host = "http://#{Spree::Store.default.url}"

##
## If using Heroku or similar service where you want sitemaps to live in S3 you'll need to setup these settings.
##

## Pick a place safe to write the files
SitemapGenerator::Sitemap.public_path = '/home/komi-comix/apps/komi-comix/shared/public'

## Store on S3 using Fog - Note must add fog to your Gemfile.
# SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(aws_access_key_id:     Spree::Config[:s3_access_key],
#                                                                     aws_secret_access_key: Spree::Config[:s3_secret],
#                                                                     fog_provider:          'AWS',
#                                                                     fog_directory:         Spree::Config[:s3_bucket])

## Inform the map cross-linking where to find the other maps.
# SitemapGenerator::Sitemap.sitemaps_host = "http://#{Spree::Config[:s3_bucket]}.s3.amazonaws.com/"

## Pick a namespace within your bucket to organize your maps. Note you'll need to set this directory to be public.
# SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.add_links do

  Spree::Page.visible.find_each do |page|
    if page.show_in_header? || page.show_in_footer
      add page_path(page), priority: 0.9, lastmod: page.updated_at, changefreq: 'weekly'
    end
  end

  add posts_path, priority: 0.7, changefreq: 'weekly'

  Spree::Post.published.find_each do |post|
    add post_path(post), lastmod: post.updated_at, changefreq: 'weekly'
  end

  add_products
end
