$(function() {
  return $('.panel-collapse.collapse input:checkbox').click(function() {
    var container, i, ids, selectors, url;
    container = $(this).closest('.list-group.copy');
    selectors = container.find('input:checkbox:checked');
    i = 0;
    ids = '';
    while (i < selectors.length) {
      ids = ids + selectors[i].value + ',';
      i++;
    }
    ids = ids.slice(0, -1);
    url = window.location.href;
    return $.ajax('/products', {
      data: {
        taxons_ids: ids
      },
      type: 'GET'
    });
  });
});
