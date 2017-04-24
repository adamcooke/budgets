$ ->
  $('.js-toggler').on 'change', ->
    $this = $(this)
    target = $(this).data('target')
    tagName = $this.prop('tagName').toLowerCase();

    if tagName == 'select'
      condition = $this.data('value').toString() == $this.val()
    else if tagName == 'input' && $this.prop('type') == 'checkbox'
      condition = !$this.is(':checked')

    $(target).toggleClass('u-hidden', condition)
