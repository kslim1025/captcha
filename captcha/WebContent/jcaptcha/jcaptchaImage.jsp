<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" import="org.apache.commons.codec.binary.Base64InputStream, java.net.*,jcaptcha.*, java.awt.image.BufferedImage, java.io.*, com.sun.image.codec.jpeg.*, com.octo.captcha.service.CaptchaServiceException"%>
<%
	response.setHeader("Pragma-directive", "no-cache");
	response.setHeader("Cache-directive", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires",0);
%>
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
		throw e;
	} catch (CaptchaServiceException e) {
		response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		throw e;
	}
	
	BufferedInputStream bis = null;
	ByteArrayOutputStream baos = null; 
	
	try {
		captchaChallengeAsJpeg = jpegOutputStream.toByteArray();
		BufferedInputStream captchaBis = new BufferedInputStream(new ByteArrayInputStream(captchaChallengeAsJpeg));
		Base64InputStream in = new Base64InputStream(captchaBis, true);
		
		bis = new BufferedInputStream(in);
		baos = new ByteArrayOutputStream();
		byte[] buffer = new byte[4096];
		int read = 0;
		while ((read = bis.read(buffer)) != -1) {
			baos.write(buffer, 0, read);
		}
		
		out.print("{\"captchaCode\":\""+baos.toString().replaceAll("(\r\n|\n)", "")+"\"}"); 
	} finally {
		if(baos != null) {
			baos.close();
		}
		if(bis != null) {
			bis.close();
		}
	}
%>