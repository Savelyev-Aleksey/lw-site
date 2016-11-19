class Activity
  constructor: ->
    select_activity = $('#activity_photo_album_id')
    return unless select_activity.length

    $(select_activity).selectize
      valueField: 'id',
      labelField: 'title_with_year',
      searchField: 'title_with_year',
      options: [],
      create: false,
      load: (query, callback) ->
        return callback() if (!query.length)
        $.ajax(
          url: '/activities/search.json',
          type: 'POST',
          dataType: 'json',
          data: {
            search: query,
          },
          error: () -> callback()
          success: (res) -> callback(res)
  			)
        return
    return


activity = null

document.addEventListener "turbolinks:load", ->
  activity = new Activity
