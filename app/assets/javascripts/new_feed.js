$(document).ready(function() {
	$('form#new_feed').bind("ajax:success", function(data, status, xhr) {
		$('#feed_url').val('');
		$('#feed_tags').val('');

		$('#addFeed-modal-content').modal('hide');
	});

	$('form#new_feed').bind("ajax:failure", function(data, status, xhr) {
		//TODO: Log this
		//alert(status);
	});
});