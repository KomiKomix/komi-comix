$ ->
  $('.panel-collapse.collapse input:checkbox').click ->
    container = $(this).closest('.list-group.copy')
    selectors = container.find('input:checkbox:checked')

    i = 0
    ids = []
    while i < selectors.length
      ids.push(selectors[i].value)
      i++

    $.ajax '/products',
      data: {taxons: ids}
      type: 'GET'

    return

  $('#cart_modal').on 'show.bs.modal', (event) ->
    button = $(event.relatedTarget)

    product = button.data('product')

    modal = $(this)
    modal.find('.product_name').text product.name

    return
