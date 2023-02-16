$(document ).ready(function() {
  $('#new_authorization_handler #authorization_handler_document_number').attr('pattern', '^[0-9]{8}$|^[a-zA-Z][0-9]{7}$');
});
