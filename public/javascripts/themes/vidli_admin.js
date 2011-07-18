var uploadStarted = false;
window.onbeforeunload = function() { 
  if (uploadStarted) {
    return 'You have an upload in progress.\nIf you navigate away from this page you will loose your upload!';
  }
}

var myQueue = null;

var queueChangeHandler = function(queue){
	// alert('Uploading Started');
	myQueue = queue;
	console.log("COLLECTION CHANGE!");
	// Add the new
	for (i = 0; i < queue.files.length; i++) {
	  $('#upload_file').html(queue.files[i].name);
	  $('#StartButton').show();
	  $('#ResetButton').show();
//  		addFileToTodoList(queue.files[i].name, queue.files[i].size, i);
	}
};

var uploadingStartHandler = function(){
  uploadStarted = true;
	$('#upload_progress').show();
};

var progressHandler = function(progress_event){
  var current_percentage = Math.floor((parseInt(progress_event.bytesLoaded)/parseInt(progress_event.bytesTotal))*100) + '%';
	$('.video_upload_meter_value').css('width', current_percentage);
  $('.video_upload_meter_text').html(current_percentage);
};

var queueReset = function() {
  $('#StartButton').hide();
  $('#ResetButton').hide();
  $('#upload_file').empty();
  $('#upload_progress').empty();
  s3_swf_1_object.clearQueue();
};

var queueUpload = function() {
  s3_swf_1_object.startUploading();
  $('#StartButton').hide();
  $('#ResetButton').hide();
};

var uploadCompleteHandler = function(upload_options,event,video_id) {
  uploadStarted = false;
  var file_name = upload_options.FileName;
  $('.video_upload_meter_text').html('Finished!');
  // update the video with the new video path
  $.ajax({
    type: 'POST',
    url: '/admin/videos/' + video_id + '/update_s3_path',
    data: {file_name: file_name},
    success: function() {
      console.log('succesfully updated video');
    },
    dataType: 'json'
  });
};

var readableBytes = function(bytes) {
  var s = ['bytes', 'kb', 'MB', 'GB', 'TB', 'PB'];
  var e = Math.floor(Math.log(bytes)/Math.log(1024));
  return (bytes/Math.pow(1024, Math.floor(e))).toFixed(2)+" "+s[e];
}

// Video
$(document).ready(function() {
	
	$('#video_downloadable').change(function() {
	  if ($(this).is(':checked')) {
	    $('#field_price_download').show();
	  } else {
	    $('#field_price_download').hide();
	  }
	});

	$('#video_streamable').change(function() {
	  if ($(this).is(':checked')) {
	    $('#field_price_streaming').show();
	  } else {
	    $('#field_price_streaming').hide();
	  }
	});

});
