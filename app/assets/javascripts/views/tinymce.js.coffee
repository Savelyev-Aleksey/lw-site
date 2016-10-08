tin_obj = null
tinymce_ready = ->

  return unless $('textarea.tinymce').length

  tinymce.init
    selector: 'textarea.tinymce'
    height: 300
    language: 'ru'
    toolbar1:
       "insertfile undo redo | cut copy paste | styleselect | bold italic |
        alignleft aligncenter alignright alignjustify |
        bullist numlist outdent indent | link image"
    plugins:"
      advlist
      anchor
      autolink
      charmap
      code
      contextmenu
      insertdatetime
      fullscreen
      lists
      link
      media
      paste
      preview
      print
      searchreplace
      table
      visualblocks
      wordcount"
  return

tinymce_destructor = ->
  return unless $('textarea.tinymce').length
  tinymce.remove if tinymce


document.addEventListener 'turbolinks:load', tinymce_ready
document.addEventListener 'turbolinks:visit', tinymce_destructor
