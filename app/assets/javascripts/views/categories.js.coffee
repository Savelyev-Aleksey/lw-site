class Category
  constructor: ->
    return unless $('input[name="category[title]"]').length

    $(document).on 'change', 'input[name="category[color]"]', ->
      color = this.value

      r = parseInt(color.substring(1,3),16)
      g = parseInt(color.substring(3,5),16)
      b = parseInt(color.substring(5,7),16)
      l = 0.213 * r + 0.815 * g + 0.072 * b

      el = $(this).parents('.input-group').find('input[name="category[title]"]')
      el.css('background-color', this.value)

      if l < 127
        el.css('color', 'white')
      else
        el.css('color', 'black')
      return
    return


category = null

document.addEventListener "turbolinks:load", ->
  category = new Category
