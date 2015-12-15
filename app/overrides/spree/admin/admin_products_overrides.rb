Deface::Override.new(virtual_path:  'spree/admin/products/_form',
                     insert_before: "[data-hook='admin_product_form_name']",
                     text:          "
                                      <div data-hook='admin_product_form_caption'>
                                      <%= f.field_container :caption do %>
                                      <%= f.label :caption, Spree.t(:caption) %>
                                      <%= f.text_field :caption, :class => 'form-control title' %>
                                      <% end %>",
                     name:          'product_form_caption')
