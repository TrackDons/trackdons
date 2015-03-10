jQuery(document).ready(function($){
	var $form_modal = $('.cd-user-modal'),
		$form_login = $form_modal.find('#cd-login'),
		$form_signup = $form_modal.find('#cd-signup'),
		$form_forgot_password = $form_modal.find('#cd-reset-password'),
		// $form_modal_tab = $('.cd-switcher'),
		// $tab_login = $form_modal_tab.children('li').eq(0).children('a'),
		// $tab_signup = $form_modal_tab.children('li').eq(1).children('a'),
		$forgot_password_link = $form_login.find('.cd-form-bottom-message a'),
		// $back_to_login_link = $form_forgot_password.find('.cd-form-bottom-message a'),
		// $main_nav = $('.main-nav');
		$main_nav = $('.nav_personal');

	// open modal
	$('.cd-signup').on('click', function(event){
		open_modal();
	});
	$('.cd-signin').on('click', function(event){
		open_modal();
	});

	//close modal
	$('.cd-user-modal').on('click', function(event){
		if( $(event.target).is($form_modal) || $(event.target).is('.cd-close-form') ) {
			$form_modal.removeClass('is-visible');
		}	
	});
	//close modal when clicking the esc keyboard button
	$(document).keyup(function(event){
    	if(event.which=='27'){
    		$form_modal.removeClass('is-visible');
	    }
    });

	//show forgot-password form 
	$forgot_password_link.on('click', function(event){
		event.preventDefault();
		forgot_password_selected();
	});

	$('.create-account').on('click', function(event){
		event.preventDefault();
		$('#user_email').val($('#session_email').val());
		$('#user_password').val($('#session_password').val());
		signup_selected();
		$('#user_name').focus();
	});
	$('.login').on('click', function(event){
		event.preventDefault();
		login_selected();
	});
	$('#session_password').on('focus', function(event){
		event.preventDefault();
		$('.recover-password').css('visibility', 'visible');	
	});
	$('#session_password').on('blur', function(event){
		$('.recover-password').delay(500).queue(function() {
			$('.recover-password').css('visibility', 'hidden');	
		});
	});
	$('.recover-password').on('click', function(event){
		event.preventDefault();
		forgot_password_selected();
	});


	function open_modal(){
		$form_modal.addClass('is-visible');	
		login_selected();
		// ( $(event.target).is('.cd-signup') ) ? signup_selected() : login_selected();
	}

	function login_selected(){
		$form_login.addClass('is-selected');
		$form_signup.removeClass('is-selected');
		$form_forgot_password.removeClass('is-selected');
	}
	function signup_selected(){
		$form_login.removeClass('is-selected');
		$form_signup.addClass('is-selected');
		$form_forgot_password.removeClass('is-selected');	
	}
	function forgot_password_selected(){
		$form_login.removeClass('is-selected');
		$form_signup.removeClass('is-selected');
		$form_forgot_password.addClass('is-selected');
	}

	//IE9 placeholder fallback
	//credits http://www.hagenburger.net/BLOG/HTML5-Input-Placeholder-Fix-With-jQuery.html
	if(!Modernizr.input.placeholder){
		$('[placeholder]').focus(function() {
			var input = $(this);
			if (input.val() == input.attr('placeholder')) {
				input.val('');
		  	}
		}).blur(function() {
		 	var input = $(this);
		  	if (input.val() == '' || input.val() == input.attr('placeholder')) {
				input.val(input.attr('placeholder'));
		  	}
		}).blur();
		$('[placeholder]').parents('form').submit(function() {
		  	$(this).find('[placeholder]').each(function() {
				var input = $(this);
				if (input.val() == input.attr('placeholder')) {
			 		input.val('');
				}
		  	})
		});
	}

});


//credits http://css-tricks.com/snippets/jquery/move-cursor-to-end-of-textarea-or-input/
jQuery.fn.putCursorAtEnd = function() {
	return this.each(function() {
    	// If this function exists...
    	if (this.setSelectionRange) {
      		// ... then use it (Doesn't work in IE)
      		// Double the length because Opera is inconsistent about whether a carriage return is one character or two. Sigh.
      		var len = $(this).val().length * 2;
      		this.setSelectionRange(len, len);
    	} else {
    		// ... otherwise replace the contents with itself
    		// (Doesn't work in Google Chrome)
      		$(this).val($(this).val());
    	}
	});
};