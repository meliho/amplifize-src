$(document).ready(function() {

	$('form#add_share_by_link').bind("ajax:success", function(data, status, xhr) {
		$('#summary').val('');
		$('#url').val('');

		$('#startNewConversation-modal-content').modal('hide');
	});

	$('form#add_share_by_link').bind("ajax:failure", function(data, status, xhr) {
		//TODO: Log this
		//alert(status);
	});
	
});