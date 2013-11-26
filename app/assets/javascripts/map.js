/**
 * Created with JetBrains RubyMine.
 * User: jakeforaker
 * Date: 11/25/13
 * Time: 7:55 PM
 * To change this template use File | Settings | File Templates.
 */

load("forecasts#show", function (controller, action) {

        jQuery.getJSON('/', {}, function(data) {

            console.log(data);

            var userLocation = data.location;

            var geocoder = L.mapbox.geocoder('jakeforaker83.gcl07fp8'),
                map = L.mapbox.map('map', 'jakeforaker83.gcl07fp8');


            geocoder.query(userLocation, showMap);

            function showMap(err, data) {
                map.fitBounds(data.lbounds);
                map.setZoom(12);

            }
        });

});
