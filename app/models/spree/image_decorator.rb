Spree::Image.class_eval do
  attachment_definitions[:attachment][:styles] = {
    mini: '40x40>', # thumbs under image
    small: '180x270>',  # images on category view
    product: '640x640>', # full product image
    large: '720x720>',  # light box image
    recommend_small: '158x152>',  # light box image
    basket_image: '132x132>'
  }

end
