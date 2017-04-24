$ ->
  $(document)
    .on 'click', '.fieldSet__field', (event) ->
      return if $(this).hasClass('is-focused')
      $input = $(event.currentTarget).find('input, select').first();
      $input.focus() unless $input.is(':disabled')
    .on 'focus', 'input, select', ->
      $(this).closest('.fieldSet__field').addClass('is-focused')
    .on 'blur', 'input, select', ->
      $(this).closest('.fieldSet__field').removeClass('is-focused')
