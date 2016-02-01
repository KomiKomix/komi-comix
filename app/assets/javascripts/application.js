// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require ckeditor/init
//= require_tree ./ckeditor
//= require 'spree/frontend/all'
//= require_tree .


$(function() {
  $(document).on("click", "#products_sort a, #products_row .pagination a", function() {
    $.getScript(this.href);
    return false;
  });

  $(document).on("change", "#delivery_calc .radio", function() {
    var post_calc = $(this).find('.custom-radio').data('post-calc');

    $.get('order/calc_delivery', {shipping_id: $(this).find('.custom-radio').attr('value')});
    $(this).closest('#delivery_calc').children('#address_fields *').attr('disabled', !post_calc);
  });

  $(document).on("click", "#delivery_calc.btn.btn-primary", function() {
    var parent         = $(this).closest('#delivery_calc');
    var selected_radio = parent.find('.custom-radio:checked');
    var zip            = $(this).closest('.row').find('#zip').val();

    $.get('order/calc_delivery', {shipping_id: selected_radio.attr('value'), zip: zip});
  });
});
