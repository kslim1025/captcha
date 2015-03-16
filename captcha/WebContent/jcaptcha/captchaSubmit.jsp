<%@page import="jcaptcha.*, com.octo.captcha.service.CaptchaServiceException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Boolean isResponseCorrect = Boolean.FALSE;
	String captchaId = session.getId();
	String jCaptchaResponse = (String)request.getParameter("j_captcha_response");
	try {
	    isResponseCorrect = CaptchaServiceSingleton.getInstance().validateResponseForID(captchaId, jCaptchaResponse);
	    
	    out.print(isResponseCorrect);
	    
	} catch (CaptchaServiceException e) {
		out.print(isResponseCorrect);
	}
%>