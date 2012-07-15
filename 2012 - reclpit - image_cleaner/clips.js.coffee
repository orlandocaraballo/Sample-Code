class ImagePicker
  constructor:(elem,images) ->
    @index = 0
    @root = $(elem)
    @field = @root.find('.img-picker-field')
    @imgTag = @root.find('.img-picker-image')
    @info = @root.find('.img-picker-info')
    @root.find('.img-picker-btn-prev').click => @clickPrev()
    @root.find('.img-picker-btn-next').click => @clickNext()
    @rendered = false
    @imageDumper = null
    @cleanImages(images)
  
  render: ->
    image = @images[@index]
    @field.attr('value',image)
    @imgTag.attr('src',image)
    @info.html((@index+1) + ' of ' + @images.length + ' images')
    
  forceRender:(images) ->
    @rendered = true
    @imageDumper.remove()
    @images = images
    @render()
  
  clickPrev: ->
    @index--
    @index = @images.length-1 if @index < 0
    @render()
    
  clickNext: ->
    @index++
    @index = 0 if @index >= @images.length
    @render()
    
  cleanImages: (images, minWidth = 25, minHeight = 25) ->
    _this = this
    imagesLoaded = 0
    parsedImages = []
    
    # append div to store new images
    @imageDumper = $('body').append('<div id="image-dumper"/>').find('#image-dumper').css
      position: 'absolute'
      left: '-999999px'
    
    # iterate through images array and add image to dom
    i = 0
    for image in images
      @imageDumper.append('<img/>').find('img:last').attr('src', image).attr('id', i)
      i++
    
    # force display of images if more than 3 seconds have elapsed
    setTimeout( ->
      if not @rendered
        _this.forceRender(parsedImages)
    , 3000)
    
    @imageDumper.find('img').load(->
      imagesLoaded++
      if $(this).height() > minHeight or $(this).width() > minWidth
        parsedImages.push($(this).attr('src'))
      if imagesLoaded == images.length and not @rendered
        _this.forceRender(parsedImages)
    ).bind('error', ->
      imagesLoaded++
      if imagesLoaded == images.length and not @rendered
        _this.forceRender(parsedImages)
    )