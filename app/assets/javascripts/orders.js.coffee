# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

main = ->
  $('unpaid').click (event) ->
    event.preventDefaut()
    $(this).tab "show"
    return

  $('paid').click (event) ->
    event.preventDefaut()
    $(this).tab "show"
    return


  $('validated').click (event) ->
    event.preventDefaut()
    $(this).tab "show"
    return


$(document).ready(main)
