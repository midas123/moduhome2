jQuery(document).ready(function() {	
	/* morenvy.com 하단 은행링크 */
	jQuery('#footer .ft_info02 .bt_bank').mouseenter(function() {
		jQuery(this).find('#banking_menu').css("display","block");
	}).mouseleave(function() {
		jQuery(this).find("#banking_menu").css("display","none");
	});
});
