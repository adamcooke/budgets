initializeDatepickers = ->
  $('.js-datepicker').datepicker(dateFormat: 'yy-mm-dd')

$ ->
  initializeDatepickers()
