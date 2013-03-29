//= require chosen-jquery
//= require bootstrap-datetimepicker.min

$(document).ready(function(){
  $(".chzn-select").chosen();

  $('.datetimepicker').parent().datetimepicker({
    language: 'en',
    pickTime: false
  });
});