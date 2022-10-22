// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")

$(document).ready(function() {
  $('[data-js-start-link]').click(function(event){
    alert('Sensor reading and publish to earth started');
    $.get('/temperature_readings/start', function(data) {
          let output = data;
          console.log(output)
          alert('Sensor reading and publish to earth started');
        });
    event.preventDefault(); 
  });
});

$(document).ready(function() {
  $('[data-js-toggle-link]').click(function(event){
    $.get('/temperature_readings/toggle_comms', function(data) {
          let output = data;
          console.log(output)
          alert('Comms status changed to '+ output.comms);
    });
    event.preventDefault(); 
  });
});

$(document).ready(function() {
  $('[data-js-csv-link]').click(function(event){
    alert('You clicked the CSV link');
    $.get('/temperature_readings/csv', function(data) {
          let output = data;
          console.log(output)
    });
    event.preventDefault(); 
  });
});