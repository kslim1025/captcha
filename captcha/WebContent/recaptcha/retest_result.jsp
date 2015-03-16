<%@ page contentType="text/html; charset=utf-8" language="java" import="net.tanesha.recaptcha.*" errorPage="" %><%
	String check = "Y";
	ReCaptchaImpl reCaptcha = new ReCaptchaImpl();
	reCaptcha.setPrivateKey("구글에서 받은 private key");
	String host = request.getParameter("host");
	String challenge = request.getParameter("challenge");
	String res = request.getParameter("response");
	ReCaptchaResponse reCaptchaResponse = reCaptcha.checkAnswer(host, challenge, res);
	if (reCaptchaResponse.isValid()) {
		System.out.println("true");
		check = "Y";
	} else {
		System.out.println("false");
		check = "N";
	}
	out.print(check);
%>