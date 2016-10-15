editor = null

MCEsettings =
  height: 300
  language: 'ru'
  content_css: '/assets/application.css'
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
    wordcount "

tinymce_ready = ->

  return unless $('textarea.tinymce').length
  unless tinymce
    console.log "Not init tinyMCE"
    return

  id = $('textarea.tinymce')[0].id
  editor = tinymce.createEditor id, MCEsettings

  editor.render()
  return

tinymce_destructor = ->
  return unless editor
  editor.destroy()
  editor = null
  return


document.addEventListener 'turbolinks:load', tinymce_ready
document.addEventListener 'turbolinks:before-visit', tinymce_destructor
