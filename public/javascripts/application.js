$(document).ready(function() {

  $('#menu-toggle').click(function() {
    var closeLabel = '- Commands';
    var showLabel  = '+ Commands';

    if ($(this).text() == closeLabel) {
      $('#menu div').hide();
      $(this).text(showLabel);
    } else {
      $('#menu div').show();
      $(this).text(closeLabel);
    }
    return false;
  });

}); // $(document).ready()
