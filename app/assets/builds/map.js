(() => {
  // app/javascript/map.js
  ymaps.ready(init);
  var myMap;
  function init() {
    document.addEventListener("turbo:load", () => {
      address = document.getElementById("map").getAttribute("data-address");
      myMap = new ymaps.Map("map", {
        center: [55.76, 37.64],
        zoom: 10
      });
      myGeocoder = ymaps.geocode(address);
      myGeocoder.then(
        function(res) {
          coordinates = res.geoObjects.get(0).geometry.getCoordinates();
          myMap.geoObjects.add(
            new ymaps.Placemark(
              coordinates,
              { iconContent: address },
              { preset: "islands#blueStretchyIcon" }
            )
          );
          myMap.setCenter(coordinates);
          myMap.setZoom(15);
        },
        function(err) {
          alert("error");
        }
      );
    });
  }
})();
//# sourceMappingURL=assets/map.js.map
