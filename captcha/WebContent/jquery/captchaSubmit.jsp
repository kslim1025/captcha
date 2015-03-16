<%@page import="nl.captcha.Captcha"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	if (rpHash(request.getParameter("defaultReal")).equals(
			request.getParameter("defaultRealHash"))) {
		// Accepted
		out.print("일치");
	}
	else {
		// Rejected
		out.print("불일치");
	}
    
    %>
    
    <%!
	private String rpHash(String value) {
		int hash = 5381;
		value = value.toUpperCase();
		for(int i = 0; i < value.length(); i++) {
			hash = ((hash << 5) + hash) + value.charAt(i);
		}
		return String.valueOf(hash);
	}
    %>