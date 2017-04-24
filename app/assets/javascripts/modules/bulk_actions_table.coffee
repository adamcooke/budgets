$ ->
  $bulkActionsTable = $('.js-bulkActionsTable')
  $bulkActionsBox = $('.js-bulkActionsBox')
  $checkboxes = null

  if $bulkActionsTable.length
    $bulkActionsTable.on 'change', 'input[type="checkbox"]', ->
      $checkboxes = if $checkboxes then $checkboxes else $bulkActionsTable.find('input[type="checkbox"]:not(:disabled)')
      $checked = $checkboxes.filter (i, checkbox) ->
        $(checkbox).is(':checked')
      $bulkActionsBox.toggleClass('u-hidden', !$checked.length)
  else
    $bulkActionsTable = $bulkActionsBox = null
