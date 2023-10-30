$(document).ready(function() {
  $('#new_authorization_handler #authorization_handler_document_number').on('focusout', function() {
      var value = $(this).val();
      var regex = /^[0-9]{8}$/;

      if (!regex.test(value)) {
        const message = $('html').attr('lang') == 'es' ?
          'No tiene el formato correcto de un DNI/NIE sin la letra final. Si es un pasaporte no hagas caso de la advertencia'
          : "No té el format correcte d'un DNI/NIE sense lletra final. Si es un passaport no facis cas de l'advertència"
        alert(message);
      }
  });
});
