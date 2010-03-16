$(document).ready(function() {

  $('#menu-toggle').click(function() {
    if ($(this).text() == 'Hide') {
      $('#menu div').hide();
      $(this).text('Menu');
    } else {
      $('#menu div').show();
      $(this).text('Hide');
    }
    return false;
  });

}); // $(document).ready()
