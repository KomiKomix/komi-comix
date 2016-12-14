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
//= require ckeditor/init
//= require_tree ./ckeditor
//= require 'spree/frontend/all'
//= require_tree ./spree
//= require_tree ./lightbox

$(function() {
  $(document).ready(function(){
    lightbox.init();
  });

  $(document).on("click", "#products_sort a, #products_row .pagination a", function() {
    $.getScript(this.href);
    return false;
  });

  $(document).on("change", "#delivery_calc .radio", function() {
    calc_delivery();
    //var post_calc = $(this).find('.custom-radio').data('post-calc');

    //$.post('order/calc_delivery', {shipping_id: $(this).find('.custom-radio').attr('value')});
    //$(this).closest('#delivery_calc').children('#address_fields *').attr('disabled', !post_calc);
  });

  $(document).on('change', '.quantity input[name*=quantity]', function() {
    var variant_id = $(this).data('variant-id');
    var new_value  = $(this).val();
    var old_value  = $(this).data('value-old');
    var url        = '/orders/populate';

    if ((new_value).match(/^\d+$/)) {
      var diff = new_value - old_value;

      if (diff < 0) {
        diff = diff * (-1);
        url  = 'orders/destroy_line_item';
      };

      if (diff != 0) {
        $.ajax({
          url: url,
          type: 'POST',
          data: { variant_id: variant_id, quantity: diff },
          dataType: 'script',
          success: function() { calc_delivery(); }
        });
      };
    };
  });

  $(document).on("click", "#delivery_calc .btn.btn-primary", function() {
    calc_delivery();
  });

  function calc_delivery(){
    var parent         = $('#delivery_calc');
    var selected_radio = parent.find('.custom-radio:checked');
    var zip            = parent.find('#zip').val();

    $.post('order/calc_delivery', {shipping_id: selected_radio.attr('value'), zip: zip});
  }

  $(document).on("click", "a.js-submit", function(e) {
    e.preventDefault();

    var selector = $(this).data('target');
    clickButton(selector);
  });

  $(document).on("ajax:success", "#checkout_form_one_step", function(e) {
    var paymentMethodId = $('input[name*=payments_attributes]:checked', '#checkout_form_one_step').val();
    submitPayment(paymentMethodId);
  });

  function clickButton(selector){
    $("#"+selector).click();
  }

  function submitPayment(paymentMethodId){
    var selector = '#payment_method_' + paymentMethodId + ' ';
    var link_selector = selector + 'a';
    var button_selector = selector + 'button';
    $(link_selector + ', ' + button_selector).click();
  }

});
