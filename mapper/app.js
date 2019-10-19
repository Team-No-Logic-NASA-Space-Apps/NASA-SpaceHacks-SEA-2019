const mymap = L.map("mapid").setView([34.05436610955981, -118.24207305908203], 9);

L.tileLayer("https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=0iL58C3joBavrwkf1Vgs",
{
    attribution: '<a href="https://www.maptiler.com/copyright/" target="_blank">&copy; MapTiler</a> <a href="https://www.openstreetmap.org/copyright" target="_blank">&copy; OpenStreetMap contributors</a>',
    maxZoom: 18
}).addTo(mymap);