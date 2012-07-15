jQuery =>
  @Clipmarklet = new Clipmarklet()
  
class Clipmarklet
  constructor: ->
    @root = $('.clipmarklet-popup')
    @resizeWindow(@root.data('page-type'))
    
  resizeWindow: (type) =>
    switch type
      when 'new-clip', 'failure'
        window.resizeTo(@root.width() + 20, @root.height() + 60)
      when 'duplicate'
        window.resizeTo(@root.outerWidth() + 20, @root.height() + 70)
      when 'success'
        window.resizeTo(window.outerWidth, @root.height() + 50)
      when 'login'
        window.resizeTo(@root.width(), @root.height() + 90)
