$ ->
  $('.panel-collapse.collapse input:checkbox').click ->
    container = $(this).closest('.list-group.copy')
    selectors = container.find('input:checkbox:checked')

    i = 0
    ids = []
    while i < selectors.length
      ids.push(selectors[i].value)
      i++

    url = window.location.href
    if url.match(/\?/)
      url = url + '&taxons='+ids
    else
      url = url + '?taxons='+ids

    $.get( url )

    return

  $('#cart_modal').on 'show.bs.modal', (event) ->
    button = $(event.relatedTarget)

    product = button.data('product')

    modal = $(this)
    modal.find('.product_name').text product.name

    return
