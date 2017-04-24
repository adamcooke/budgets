$ ->
  $('a[rel=dialog]').on 'click',(event) ->
    event.preventDefault()
    Nifty.Dialog.open
      url: $(this).attr('href')
