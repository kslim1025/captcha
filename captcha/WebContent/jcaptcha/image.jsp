<%@ page language="java" contentType="image/jpg; charset=UTF-8" pageEncoding="UTF-8" import="jcaptcha.*, java.awt.image.BufferedImage, java.io.*, com.sun.image.codec.jpeg.*, com.octo.captcha.service.CaptchaServiceException"%>
<%
	byte[] captchaChallengeAsJpeg = null;
	ByteArrayOutputStream jpegOutputStream = new ByteArrayOutputStream();
	try {
		
		String captchaId = session.getId();
		BufferedImage challenge = CaptchaServiceSingleton.getInstance().getImageChallengeForID(captchaId, request.getLocale());
		JPEGImageEncoder jpegEncoder = JPEGCodec.createJPEGEncoder(jpegOutputStream);
		jpegEncoder.encode(challenge);
	} catch (IllegalArgumentException e) {
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
		return;
	} catch (CaptchaServiceException e) {
		response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		return;
	}
	
	captchaChallengeAsJpeg = jpegOutputStream.toByteArray();
/* 	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	response.setContentType("image/jpeg"); */
	
	out.clear();
	
	ServletOutputStream responseOutputStream = response.getOutputStream();
	responseOutputStream.write(captchaChallengeAsJpeg);
	responseOutputStream.flush();
	responseOutputStream.close();
	
%>