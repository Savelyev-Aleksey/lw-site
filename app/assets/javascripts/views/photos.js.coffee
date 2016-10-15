fileUploader = null
init_photo_uploader = ->
  fileUploader = new Dropzone "#photo_uploader",
    maxFilesize: 5
    paramName: "photos[picture]"
    # uploadMultiple: true
    init: ->
      this.on 'success', (file, responseText) ->
        # After successful uploading add photo in image list
        $('#photo-gallery').append responseText.thumb
        url = $(responseText.thumb).find('img').attr('data-url')
        carousel = $('#main-carousel .carousel-inner')
        # After successful uploading add photo in intialised carousel
        carousel.append new_carousel_item(url) if carousel.length

        setTimeout ->
          file.previewElement.remove()
          return
        , 1500
        return
      return

new_carousel_item = (url)->
  item = $('<div></div>').addClass('item')
  img = $('<img>').attr src: url
  item.append(img)
  item

init_carousel = ->
  # hide carousel
  $('#main-carousel .carousel-inner').on 'click', ->
    $('#main-carousel-wrapper').addClass('hidden')
    $(document.body).removeClass('overflow')
    return

  # show gallery on image click
  $('#photo-gallery').on 'click', 'img', ->
    event_img = this
    item_parent = $('#main-carousel .carousel-inner')
    # prepare image list if clicked first time
    if (!item_parent.children().length)
      $('#photo-gallery').find('img').each (i)->
        item = new_carousel_item $(this).attr('data-url')
        if (event_img == this)
          item.addClass('active')
        item_parent.append item
        return

      $('#main-carousel').carousel
        interval: 5000
        wrap: false
    else
      # select current image in already prepared carousel
      item_parent.find('.active').removeClass('active')
      $('#photo-gallery img').each (i)->
        if (event_img == this)
          $($('#main-carousel .carousel-inner .item').get(i)).addClass('active')
          return false
        return

    $('#main-carousel-wrapper').removeClass('hidden')
    $(document.body).addClass('overflow')
    return
  return


init_prevent_submiting = ->
  $('#photo-gallery').on 'submit', 'form', (e) ->
    $.rails.handleRemote $(this)
    e.preventDefault()
    return

init_delete_image_bind = ->
  $('#photo-gallery').on 'ajax:success', 'form.remove-form',
  (evt, data, status, xhr)->
    div_parent = $(this).parent('div.gallery-elem').addClass('image-deleted')
    setTimeout ->
      # Remove image from carousel if already initialized
      if $('#main-carousel .carousel-inner .item').length
        $('#photo-gallery div.gallery-elem').each (i)->
          if (div_parent[0] == this)
            $($('#main-carousel .carousel-inner .item').get(i)).remove()
            return false
          return
      div_parent.remove()
      return
    , 1300
    return
  return

init_change_cover_bind = ->
  $('#photo-gallery').on 'ajax:success', 'form.cover-form',
  (evt, data, status, xhr)->
    cover = $('#photo-gallery div.cover')
    if cover
      cover.removeClass('cover')
      cover.find('button[type=submit]').removeAttr('disabled')
    div_parent = $(this).parent('div.gallery-elem')
    div_parent.addClass('cover')
    div_parent.find('button[type=submit]').attr('disabled', true)
    return
  return

photos_ready = ->
  init_photo_uploader()
  init_carousel()
  init_prevent_submiting()
  init_delete_image_bind()
  init_change_cover_bind()
  return

document.addEventListener "turbolinks:load", photos_ready
