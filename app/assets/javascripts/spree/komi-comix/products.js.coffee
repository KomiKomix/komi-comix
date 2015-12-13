$ ->
  $('.panel-collapse.collapse input:checkbox').click ->
    container = $(this).closest('.list-group.copy')
    selectors = container.find('input:checkbox:checked')

    i = 0
    ids = ''
    while i < selectors.length
      ids = ids + selectors[i].value + ','
      i++
    ids = ids.slice(0,-1)
    url = window.location.href

    $.ajax '/products',
      data: {taxons_ids: ids}
      type: 'GET'

