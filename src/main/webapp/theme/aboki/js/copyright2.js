
function copydata2() {
    if ($('input[name="same2"]').prop('checked') === true) {
    	$('input[name="RECEIVER_NAME"]').val($('input[name="guestName"]').val());
         if ('select' == 'select') {
            if ($('select[name="emergency21"]').length > 0 && document.frmOrder.tempemergency21) $('select[name="emergency21"] option[value='+document.frmOrder.tempemergency21.value+']').attr("selected",true);
        } else {
            if ($('select[name="emergency21"]').length > 0 && document.frmOrder.tempemergency21) $('select[name="emergency21"]').val(document.frmOrder.tempemergency21.value);
        }
        if ($('input[name="emergency22"]').length > 0 && document.frmOrder.tempemergency22) $('input[name="emergency22"]').val(document.frmOrder.tempemergency22.value);
        if ($('input[name="emergency23"]').length > 0 && document.frmOrder.tempemergency23) $('input[name="emergency23"]').val(document.frmOrder.tempemergency23.value);
        if ('select' == 'select') {
            if ($('select[name="emergency31"]').length > 0 && $('select[name="guestPhone1"]').length > 0) $('select[name="emergency31"] option[value='+$('select[name="guestPhone1"]').val()+']').attr("selected",true); 
        } else {
            if ($('select[name="emergency31"]').length > 0 && $('select[name="guestPhone1"]').length > 0) $('select[name="emergency31"]').val($('select[name="guestPhone1"]').val()); 
        }
        if ($('input[name="emergency32"]').length > 0 && $('input[name="guestPhone2"]').length > 0) $('input[name="emergency32"]').val($('input[name="guestPhone2"]').val()); 
        if ($('input[name="emergency33"]').length > 0 && $('input[name="guestPhone3"]').length > 0) $('input[name="emergency33"]').val($('input[name="guestPhone3"]').val()); 
        if ($('input[name="guestPhone2"]').length > 0 && document.frmOrder.tempemergency2) $('input[name="emergency2"]').val(document.frmOrder.tempemergency2.value);
        if ($('input[name="guestPhone3"]').length > 0 && $('input[name="emergency"]').length > 0) $('input[name="emergency3"]').val($('input[name="emergency"]').val());
        
    } else {
    	$('input[name="RECEIVER_NAME"]').val('');
        if ('select' == 'select') {
            if ($('select[name="emergency21"]')) $('select[name="emergency21"] option[value=""]').attr("selected",true);
        } else {
            if ($('select[name="emergency21"]')) $('select[name="emergency21"]').val('');
        }
        if ($('input[name="emergency22"]')) $('input[name="emergency22"]').val('');
        if ($('input[name="emergency23"]')) $('input[name="emergency23"]').val('');
        if ('select' == 'select') {
            if ($('select[name="emergency31"]')) $('select[name="emergency31"] option[value=""]').attr("selected",true);
        } else {
            if ($('select[name="emergency31"]')) $('select[name="emergency31"]').val('');
        }
        if ($('input[name="emergency32"]')) $('input[name="emergency32"]').val('');
        if ($('input[name="emergency33"]')) $('input[name="emergency33"]').val('');
        if ($('input[name="emergency2"]')) $('input[name="emergency2"]').val('');
        if ($('input[name="emergency3"]')) $('input[name="emergency3"]').val('');
        
    }
}