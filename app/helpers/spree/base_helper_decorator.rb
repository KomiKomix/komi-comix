module Spree
  module BaseHelper
    def taxons_tree(root_taxon, current_taxon, max_level = 1)
      return '' if max_level < 1 || root_taxon.nil? #|| root_taxon.leaf?
      content_tag :div, class: 'list-group' do
        root_taxon.children.map do |taxon|
          css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'list-group-item active' : 'list-group-item'
          link_to(taxon.name, seo_url(taxon), class: css_class) + taxons_tree(taxon, current_taxon, max_level - 1)
        end.join("\n").html_safe
      end
    end

    def search_form
      form_for products_path, method: :get, html: {id: 'products_search'}, remote: true do
        hidden_field_tag(:taxons, params[:taxons]) +
        hidden_field_tag(:sort_by, params[:sort_by]) +
        hidden_field_tag(:page, params[:page]) +
        hidden_field_tag(:keywords, params[:keywords]) +
        content_tag(:div, class: 'input-group search') do
          search_field_tag(:keywords, params[:keywords], placeholder: 'Найди свой комикс...', class: 'form-control', type: 'text', autocomplete: 'off') do
            params[:keywords]
          end +
          content_tag(:div, search_button, class: 'input-group-btn', onclick: "$(this).closest('#products_search').submit();")
        end
      end
    end

    def search_button
      content_tag(:button, class: 'btn', type: 'button') do
        "<i class='fa fa-search'></i>".html_safe
      end
    end

    def take_your_chance_block_links
      Spree::Product.rand.collect do |product|
        link_to product_url(product), class: 'list-group-item' do
          content_tag(:h4, product.caption, class: 'list-group-item-heading') +
          content_tag(:p, product.name, class: 'list-group-item-text')
        end
      end
    end

    def formatted_news(news_description)
      html = Nokogiri::HTML::Document.parse(news_description)
      images = html.css('img')
      images.each do |i|
        i.remove_attribute('style')
        i.set_attribute('class', 'img-responsive')
        p = i.parent
        p.name = 'div'
        p.set_attribute('class', 'news_img')
      end
      raw html.css('body').children.to_s
    end

  end
end