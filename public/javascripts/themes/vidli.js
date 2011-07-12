$(document).ready(function(){
	// Add a confirmation dialog to logout
  if ($('.logout').length > 0) {
    $('.logout').click(function(e) {
      if (confirm('Are you sure you want to log out?')) {
        return true;
      } else {
        return false;
      }
    })
  }
});