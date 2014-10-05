function initialize() {

  	var place_lat = $('#place_lat').val();
  	var place_lng = $('#place_lng').val();

  	// Create the map center on the location or on SF by default
  	if (place_lat && place_lng){
  		center = { lat: place_lat, lng: place_lng}
  	} else {
  		center = { lat: 37.7597727, lng: -122.427063}
  	}
  	var mapOptions = {
  		center: center,
  		zoom: 12
  	};
  	var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  	var marker;

    // Create the pin of the place if the location is determine when display page
    if (place_lat && place_lng){
    	createPin(place_lat, place_lng)
    }

    function clearPin(){
		if(marker){
    		marker.setMap(null);
    	}
    }

    function createPin(lat, lng){
    	var myLatlng = new google.maps.LatLng(place_lat, place_lng);
    	marker = new google.maps.Marker({
    		position: myLatlng,
    		map: map,
    		title: "Hello"
    		// title: $('#place_name').val()
    	});
    	map.setCenter(myLatlng);
    }

	// Add an event when click on the map to update the address
	google.maps.event.addListener(map, 'click', function(event) {
		var click_lat = event.latLng.k;
		var click_lng = event.latLng.B;
		clearPin();
		createPin(click_lat, click_lng);
		$('#place_lat').val(click_lat);
		$('#place_lng').val(click_lng);
	});

	// Update the pin on the map when entering an address
	$('#pin_map').click(function(e){
		e.preventDefault();
	  	var address = $('#place_address').val();
	  	var geo_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + address + "&key=AIzaSyBMjQW_pHVa_SJleQQX2BC51pJ4UyhVbK0"
	  	var request = $.ajax({
	  		url: geo_url,
	  		type: "GET",
	  		dataType: "json"
	  	});

	  	request.done(function(data){
	  		if(data.results.length == 0){
	  			alert("INVALID ADDRESS")
	  		} else {
	  			var geo_lat = data.results[0].geometry.location.lat;
	  			var geo_lng = data.results[0].geometry.location.lng;
	  			clearPin();
	  			createPin(geo_lat, geo_lng);
	  		}
	  	});
	});
}

// google.maps.event.addDomListener(window, 'load', initialize);