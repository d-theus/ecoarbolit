ready = ->
  adjustTable()
  $(window).resize(adjustTable)

adjustTable = ->
  $('#beneficial_table_container tr').each (row)->
    td = $(this).find('td:first-child,th:first-child')
    td2 = $(this).find('td:nth-child(2)')
    $(this).height(1.275*td.height())
    td2.height(1.3*td.height())

$(document).ready(ready)
$(document).on 'page:load', ready

