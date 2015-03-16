<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>Google Recaptcha Test</title>
</head>
<body>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript" src="http://www.google.com/recaptcha/api/js/recaptcha_ajax.js"></script>
<script>
$(function(){
	//Site key
	var siteKey = "구글에서 발급받은 site key";
	var div = "recaptcha";
	Recaptcha.create(siteKey, div, {theme: "red"});
	$("#recaptchaCheck").click(function(){
		var challenge = Recaptcha.get_challenge();
		var response = Recaptcha.get_response();
		var host = $(location).attr('host');
		$.ajax({
			type: "POST",
			url: "<%=request.getContextPath()%>/recaptcha/retest_result.jsp",
			async: false,
			data: {
				host: host,
				challenge: challenge,
				response: response
			},
			success: function(data) {
				if(data == "Y") {
					document.getElementById("message").innerHTML = "Success!";
				}else{
					document.getElementById("message").innerHTML = "Incorrect Recaptcha! Please try again!";
					Recaptcha.reload();
				}
			}
		}); 
	});
}); 
</script>
<div id="message" style="color:#ff0000; "></div>
<div id="recaptcha"></div>
<input id="recaptchaCheck" type="button" value="Check">
<div id="recaptcha_widget" style="display:none">
	<div id="recaptcha_image"></div>
	<div class="recaptcha_only_if_incorrect_sol" style="color:red">Incorrect please try again</div>
	<span class="recaptcha_only_if_image">Enter the words above:</span>
	<span class="recaptcha_only_if_audio">Enter the numbers you hear:</span>
	<input type="text" id="recaptcha_response_field" name="recaptcha_response_field" />
	<div><a href="javascript:Recaptcha.reload()">Get another CAPTCHA</a></div>
	<div class="recaptcha_only_if_image"><a href="javascript:Recaptcha.switch_type('audio')">Get an audio CAPTCHA</a></div>
	<div class="recaptcha_only_if_audio"><a href="javascript:Recaptcha.switch_type('image')">Get an image CAPTCHA</a></div>
	<div><a href="javascript:Recaptcha.showhelp()">Help</a></div>
</div>
</body>
</html>