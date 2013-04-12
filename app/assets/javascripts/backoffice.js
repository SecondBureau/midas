//= require chosen-jquery
//= require bootstrap-datetimepicker.min

$(document).ready(function(){
  $(".chzn-select").chosen();

  $('.datetimepicker').parent().datetimepicker({
    language: 'en',
    pickTime: false
  });

  $('.show_entries_details').click(function(){
    if ($(this).next().css('display') == 'none')
    {
      $('.show_entries_details').next().css('display', 'none');
      $(this).next().css('display', 'block');
    }
    else
    {
      $('.show_entries_details').next().css('display', 'none');
    }
  });

  $('.open_details').click(function(){
    if ($("tr[rel=details"+$(this).attr('rel')+"]").length != 0)
    {
      $("tr[rel=details"+$(this).attr('rel')+"]").insertAfter($(this).closest('tr'));
      $("tr[rel=details"+$(this).attr('rel')+"]").toggle();
    }
  });
});
