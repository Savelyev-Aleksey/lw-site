tin_obj = null
tinymce_ready = ->

  tin_obj = tinyMCE.init
    selector: 'textarea.tinymce'
    language: 'ru'
    toolbar:
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

clean_tiny = ->
  tin_obj.destroy()
  return

$(document).on 'ready page:load', tinymce_ready
$(document).on 'page:after-remove', clean_tiny

# $(document).on 'page:restore', tinymce_ready
