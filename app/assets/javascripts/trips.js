(function(){

  $(document).ready(init);

  var map;
  // google converted lat long
  var latLngStart;
  var latLngEnd;
  //
  var latStart;
  var latEnd;
  var lngStart;
  var lngEnd;
  var mpg;
  var GAS_PRICE = 3.65;

  //////////////////// START MAP STYLE ////////////////////

  function init(){
    var map_style = [
      {
          "featureType": "landscape",
          "stylers": [
              {
                  "hue": "#F1FF00"
              },
              {
                  "saturation": -27.4
              },
              {
                  "lightness": 9.4
              },
              {
                  "gamma": 1
              }
          ]
      },
      {
          "featureType": "road.highway",
          "stylers": [
              {
                  "hue": "#0099FF"
              },
              {
                  "saturation": -20
              },
              {
                  "lightness": 36.4
              },
              {
                  "gamma": 1
              }
          ]
      },
      {
          "featureType": "road.arterial",
          "stylers": [
              {
                  "hue": "#00FF4F"
              },
              {
                  "saturation": 0
              },
              {
                  "lightness": 0
              },
              {
                  "gamma": 1
              }
          ]
      },
      {
          "featureType": "road.local",
          "stylers": [
              {
                  "hue": "#FFB300"
              },
              {
                  "saturation": -38
              },
              {
                  "lightness": 11.2
              },
              {
                  "gamma": 1
              }
          ]
      },
      {
          "featureType": "water",
          "stylers": [
              {
                  "hue": "#00B6FF"
              },
              {
                  "saturation": 4.2
              },
              {
                  "lightness": -63.4
              },
              {
                  "gamma": 1
              }
          ]
      },
      {
          "featureType": "poi",
          "stylers": [
              {
                  "hue": "#9FFF00"
              },
              {
                  "saturation": 0
              },
              {
                  "lightness": 0
              },
              {
                  "gamma": 1
              }
          ]
      }
    ];

    //////////////////// END MAP STYLE ////////////////////

    var isMap = $('#map');

    if(isMap){
      //$('#geolocate').click(geolocate);
      $('#geocode').click(geocode);
      //$('#search').click(search);
      displayMap(39.8282, -98.5795, 4);
    }

    function displayMap(lat, lng, zoom){
      var mapOptions = { zoom: zoom, center: new google.maps.LatLng(lat, lng), styles: map_style};
      map = new google.maps.Map(document.getElementById('map'),
      mapOptions);
    }

    $('.showGeo').click(displayRoute);
  }

  function geocode(){
    var start = $('#trip_location_start').val();
    var end = $('#trip_location_end').val();

    geocodeLocal(start, function(startGeo){
      geocodeDest(end, function(endGeo){

        var drivePath = new google.maps.Polyline({
          path: [startGeo, endGeo],
          geodesic: true,
          strokeColor: '#E8A122',
          strokeOpacity: 1.0,
          Strokeweight: 2
        });

        drivePath.setMap(map);

        calculateDistances();

      });
    });

  }

  function geocodeLocal(start, fn) {
    $.getJSON('https://maps.googleapis.com/maps/api/geocode/json?address=' + start + '&key=AIzaSyAmN0r1eJV2qHS3UZUpS8ytISU7etkg0ZI',
    function(data){
      if(data.status == "OK"){
        var lat_lng = data.results[0].geometry.location;
        latEnd = lat_lng.lat;
        lngEnd = lat_lng.lng;
        $('#trip_lat_local').val(lat_lng.lat);
        $('#trip_lng_local').val(lat_lng.lng);

        latLngStart = new google.maps.LatLng(lat_lng.lat, lat_lng.lng);
        addMarker(start, latLngStart);

      }else{
        console.log("LOCATION ERROR");
      }
      fn(latLngStart);
    });
  }

  function geocodeDest(end, fn) {
    $.getJSON('https://maps.googleapis.com/maps/api/geocode/json?address=' + end + '&key=AIzaSyAmN0r1eJV2qHS3UZUpS8ytISU7etkg0ZI',
    function(data){
      if(data.status == "OK"){
        var lat_lng = data.results[0].geometry.location;
        latStart = lat_lng.lat;
        lngStart = lat_lng.lng;
        $('#trip_lat_dest').val(lat_lng.lat);
        $('#trip_lng_dest').val(lat_lng.lng);

        latLngEnd = new google.maps.LatLng(lat_lng.lat, lat_lng.lng);
        addMarker(end, latLngEnd);

      }else{
        console.log("LOCATION ERROR");
      }
      fn(latLngEnd);
    });
  }

  function addMarker(loc, LatLng){
    var marker = new google.maps.Marker({
      animation: google.maps.Animation.DROP,
      position: LatLng,
      map: map,
      title: loc,
      icon: "../assets/car.jpeg"
    });
  }

  ///////////// DISTANCE CALCULATION //////////////
  function calculateDistances() {
    var service = new google.maps.DistanceMatrixService();
    service.getDistanceMatrix(
    {
      origins: [latLngStart],
      destinations: [latLngEnd],
      travelMode: google.maps.TravelMode.DRIVING,
      unitSystem: google.maps.UnitSystem.IMPERIAL,
      avoidHighways: false,
      avoidTolls: false
    }, callback);
  }

  function callback(response, status){
    if(status == 'OK'){
      console.log(response.rows[0].elements[0]);
      var distance = response.rows[0].elements[0].distance.text;
      var time = response.rows[0].elements[0].duration.text;
      mpg = $('#trip_mpg').val();
      var totalCost = Math.floor(((response.rows[0].elements[0].distance.value / 1609) / mpg) * GAS_PRICE);
      totalCost = numeral(totalCost).format('$0,0.00');
      $('#trip_distance').val(distance);
      $('#trip_time').val(time);
      $('#trip_cost').val(totalCost);

      $('#travel_info').empty();
      $div = $('<div>');
      $distance = $('<h4>').text(distance);
      $time = $('<h4>').text(time);
      $mpg = $('<h4>').text('Estimated Cost: ' + totalCost);

      $('#travel_info').addClass('animated flip');
      $('#travel_info').append($div.append($distance, $time, $mpg));

    }
  }

  function displayRoute(){
      var geoId = $('.tripId').text();
      var latStart = $('.latStart'+geoId).text();
      var lngStart = $('.lngStart'+geoId).text();
      var latEnd = $('.latEnd'+geoId).text();
      var lngEnd = $('.lngEnd'+geoId).text();
      console.log(geoId);

  }














})();
