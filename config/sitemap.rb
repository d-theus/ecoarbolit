# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.example.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end


  add price_path, priority: 0.5, changefreq: 'weekly'
  add delivery_path, priority: 0.5, changefreq: 'weekly'
  add contacts_path, priority: 0.5, changefreq: 'weekly'
  add level_pros_path, priority: 0.5, changefreq: 'weekly'
  add insulating_pros_path, priority: 0.5, changefreq: 'weekly'
  add solid_pros_path, priority: 0.5, changefreq: 'weekly'
  add waterproof_pros_path, priority: 0.5, changefreq: 'weekly'
  add eco_pros_path, priority: 0.5, changefreq: 'weekly'
  add rot_free_pros_path, priority: 0.5, changefreq: 'weekly'
  add crack_free_pros_path, priority: 0.5, changefreq: 'weekly'
  add shrink_free_pros_path, priority: 0.5, changefreq: 'weekly'
  add fastenable_pros_path, priority: 0.5, changefreq: 'weekly'
  add simple_pros_path, priority: 0.5, changefreq: 'weekly'
  add cuttable_pros_path, priority: 0.5, changefreq: 'weekly'
  add beneficial_pros_path, priority: 0.5, changefreq: 'weekly'
  add absorbing_pros_path, priority: 0.5, changefreq: 'weekly'
  add fireproof_pros_path, priority: 0.5, changefreq: 'weekly'
  add pros_path, priority: 0.9, changefreq: 'weekly'
  add stroitelstvo_iz_blokov_nesjomnoy_opalubki_i_sverckhprochnogo_arbolita_articles_path, priority: 0.7, changefreq: 'weekly'
  add teploprovodnost_articles_path, priority: 0.7, changefreq: 'weekly'
  add articles_path, priority: 0.9, changefreq: 'weekly'
end
