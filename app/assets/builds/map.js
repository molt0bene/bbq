(() => {
  // app/javascript/map.js
  document.addEventListener("turbo:load", () => {
    ymaps.ready(init);
    var myMap;
    console.log("hi 1");
    function init() {
      console.log("hi 2");
      const address = document.getElementById("map").getAttribute("data-address");
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
          alert("\u041E\u0448\u0438\u0431\u043A\u0430 \u043F\u0440\u0438 \u043E\u043F\u0440\u0435\u0434\u0435\u043B\u0435\u043D\u0438\u0438 \u043C\u0435\u0441\u0442\u043E\u043F\u043E\u043B\u043E\u0436\u0435\u043D\u0438\u044F");
        }
      );
      console.log("hi 3");
    }
  });
})();
//# sourceMappingURL=assets/map.js.map
