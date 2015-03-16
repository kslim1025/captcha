<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Insert title here</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script>
jQuery(function($) {
	$('#j_captcha_response').on('keyup', function() {
		var _self = $(this);
		var val = _self.val();
		if(val) {
			_self.val(val.toUpperCase());
		}
	});


	var _jcaptchaCarousel = $('#jcaptchaCarousel');
	$('#btnCaptchaReload').on('click', function() {
		$.ajax({
			url : 'jcaptchaImage.jsp',
			dataType : 'json',
			success : function(data, textStatus, jqXHR) {
				if(data.captchaCode) {
					
					_jcaptchaCarousel
						.empty()
						.append($('<img />', {src:'data:image/jpg;base64,' + data.captchaCode}));
				} else {
					alert('이미지 새로고침에 실패하였습니다.');
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log('jqXHR : ' + jqXHR);
				console.log('textStatus : ' + textStatus);
				console.log('errorThrown : ' + errorThrown);
				alert('ERROR : ' + textStatus);
			}
		});
	}).trigger('click');
	
});
</script>

</head>
<body>

<form action="captchaSubmit.jsp" method="post">
	<div id="jcaptchaCarousel">
<%--		<img src="image.jsp" style="border:1px solid #999;" /> --%>
	</div>
	<div>
		<input type="button" value="이미지 새로고침" id="btnCaptchaReload" />
	</div>
	<div>
		<input type="text" name="j_captcha_response" id="j_captcha_response" style="ime-mode:disabled;" />
	</div>
	<div>
		<input type="submit" value="전송" />	
	</div>
</form>

</body>
</html>