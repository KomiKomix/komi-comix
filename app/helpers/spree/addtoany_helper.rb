module Spree
  module AddtoanyHelper
    def add_to_any_buttons
      codes = Spree::AddtoanyConfig[:codes_str].strip || []
      codes = codes.split(',').map{|code| code.strip}
      if codes.length > 0
        content_tag(:div, class: 'a2a_kit a2a_kit_size_32 a2a_default_style') do
          codes.collect {|code|
            "<a class=\"a2a_button_#{code}\"></a>".html_safe
          }
              .join('')
              .html_safe +
              '<script async src="https://static.addtoany.com/menu/page.js"></script>'.html_safe
          # '<a class="a2a_dd" href="https://www.addtoany.com/share"></a>'.html_safe +
          # '<script async src="https://static.addtoany.com/menu/page.js"></script>'.html_safe
        end
      end
    end
  end
end
