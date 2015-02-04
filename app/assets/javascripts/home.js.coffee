# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


main = () ->
  handler = Gmaps.build("Google")
  handler.buildMap
    provider: {}
    internal:
      id: "map"
  , ->
    contentString =
      '<div id="content">'+
      '<h3>Hotel Les Bruyères</h1>'+
      '<p>78 route de la barrière</p>'+
      '<p>6971 Tenneville</p></div>'

    markers = handler.addMarkers([
      lat: 50.105
      lng: 5.576
      picture:
        width: 36
        height: 36
      infowindow: contentString
    ],
    [
      lat: 50.105
      lng: 5.576
      picture:
        width: 36
        height: 36
      infowindow: contentString
    ])
    handler.bounds.extendWith markers
    handler.fitMapToBounds()
    handler.getMap().setZoom(12)
    return

$(document).ready(main)
