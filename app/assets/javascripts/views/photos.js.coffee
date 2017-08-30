carousel = null
uploader = null



class FileUploader
  constructor: (uploader) ->
    @dropzone = new Dropzone uploader,
      maxFilesize: 5
      paramName: "photos[picture]"
      init: ->
        this.on 'success', (file, responseText) ->
          # After successful uploading add photo in image list
          $('#photo-gallery').append responseText.thumb
          url = $(responseText.thumb).find('img').attr('data-url')
          # After successful uploading add photo in intialised carousel
          carousel.append_image(url) if carousel? and carousel.filled()

          setTimeout ->
            file.previewElement.remove()
            return
          , 1500
          return
        return
    return



  destroy: ->
    @dropzone.destroy()
    return





class Carousel

  prevent_submiting: ->
    @gallery.on 'submit', 'form', (e) ->
      $.rails.handleRemote $(this)
      e.preventDefault()
      return
    return



  append_image: (url) ->
    item = $('<div>').addClass('carousel-item')
    img = $('<img>').attr(src: url).addClass 'd-block w-100'
    item.append(img)
    @carousel_inner.append item
    return


  fill_carousel: ->
    obj = @
    @gallery.find('img').each (i) ->
      obj.append_image this.attributes['data-url'].value
      return



  show_element: (img) ->
    obj = @
    @carousel_inner.find('.active').removeClass('active')
    @gallery.find('img').each (i) ->
      if (img == this)
        $(obj.carousel_inner.find('.carousel-item').get(i)).addClass('active')
        obj.carousel.carousel i
        return false
      return


  filled: ->
    @carousel_inner.children().length


  constructor: ->
    @carousel = $('#photo-slider')
    @carousel_inner = $('#photo-slider > .carousel-inner')
    @gallery = $('#photo-gallery')

    # hide carousel
    @carousel.on 'click', (e) =>
      return if e.target.nodeName == 'A'
      return if e.target.parentElement.nodeName == 'A'
      @carousel.carousel('pause')
      @carousel.attr('hidden', true)
      document.body.classList.remove 'overflow'
      return

    @prevent_submiting()
    @change_cover_bind()
    @delete_image_bind()

    # show gallery on image click
    obj = @
    @gallery.on 'click', 'img', ->
      # prepare image list if clicked first time
      if (!obj.filled())
        obj.fill_carousel()
        obj.carousel.carousel
          interval: 5000
          wrap: false
          ride: 'carousel'
          pause: false

      # select current image in already prepared carousel
      obj.show_element(event.target)

      # show carousel
      obj.carousel.removeAttr 'hidden'
      # show black background
      $(document.body).addClass 'overflow'
      return
    return



  change_cover_bind: ->
    obj = @
    @gallery.on 'ajax:success', 'form.cover-form',
    (evt, data, status, xhr)->
      cover = obj.gallery.find('div.cover')
      if cover
        cover.removeClass('cover')
        cover.find('button[type=submit]').removeAttr('disabled')
      div_parent = $(this).parent('div.gallery-elem')
      div_parent.addClass('cover')
      div_parent.find('button[type=submit]').attr('disabled', true)
      return
    return



  delete_image_bind: ->
    obj = @
    @gallery.on 'ajax:success', 'form.remove-form',
    (evt, data, status, xhr)->
      div_parent = $(this).parent('div.gallery-elem').addClass('image-deleted')
      setTimeout ->
        # Remove image from carousel if already initialized
        if obj.filled()
          obj.gallery.find('div.gallery-elem').each (i)->
            if (div_parent[0] == this)
              obj.carousel_inner.find('.item').get(i).remove()
              return false
            return
        div_parent.remove()
        return
      , 1300
      return
    return







document.addEventListener "turbolinks:load", ->
  if document.getElementById 'photo-slider'
    carousel = new Carousel

  if document.getElementById 'photo_uploader'
    uploader = new FileUploader '#photo_uploader'
  return

document.addEventListener "turbolinks:visit", ->
  carousel = null
  uploader.destroy() if uploader
  uploader = null
  return
