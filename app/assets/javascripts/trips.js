(function(){

  $(document).ready(init);

  var map;
  var loc = {};
  var markers = [];

  function init(){
    var isMap = $('#map').length;

    if(isMap){
      //$('#geolocate').click(geolocate);
      //$('#geocode').click(geocode);
      //$('#search').click(search);
      displayMap(39.8282, -98.5795, 4);
    }

    function displayMap(lat, lng, zoom){
      var mapOptions = { zoom: zoom, center: new google.maps.LatLng(lat, lng)};
      map = new google.maps.Map(document.getElementById('map'),
      mapOptions);
    }
  }

  // Try HTML5 geolocation
  if(navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = new google.maps.LatLng(position.coords.latitude,
                                       position.coords.longitude);

      var infowindow = new google.maps.InfoWindow({
        map: map,
        position: pos,
        content: 'Location found using HTML5.'
      });

      map.setCenter(pos);
    }, function() {
      handleNoGeolocation(true);
    });
  } else {
    // Browser doesn't support Geolocation
    handleNoGeolocation(false);
  }


})();
