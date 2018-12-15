function sendGoods() {
	 if ($('#order-name').val().length == 0) {
	        alert("주문자의 성함을 입력하세요.");	       
	        $('#order-name').focus();
	        return false;
	    }  
	 
	 if ($('#emergency12').val().length == 0 || $('#emergency13').val().length == 0) {
	        alert("주문자의 연락처을 입력하세요.");	       
	        $('#emergency12').focus();
	        return false;
	    }
	 if ($('#input-mail').val().length == 0) {
	        alert("주문자의 이메일을 입력하세요.");	       
	        $('#input-mail').focus();
	        return false;
	    } 
	 
	 if ($('#receiver').val().length == 0) {
	        alert("수령인의 이름을 입력하세요.");	       
	        $('#receiver').focus();
	        return false;
	    }
	 
	 if ($('#emergency32').val().length == 0 || $('#emergency33').val().length == 0) {
	        alert("수령인의 연락처을 입력하세요.");	       
	        $('#emergency32').focus();
	        return false;
	    }
	 
	 if ($('#sample6_postcode').val().length == 0 || $('#sample6_address').val().length == 0 || $('#sample6_address').val().length == 0) {
	        alert("수령인의  주소를 입력하세요.");	       
	        $('#sample6_postcode').focus();
	        return false;
	    }
	 if(document.getElementById("agree").checked != true){
		 alert("정보수집에 동의하셔야합니다.");
		 document.getElementById("agree").focus();
		 return false;
	 }
	 else {
	    	$('#frmOrder').submit();
	 }
	 

}