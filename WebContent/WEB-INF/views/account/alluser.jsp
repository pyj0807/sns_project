<%@ page language="java" contentType="text/html; charset=UTF-8"
   	  pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<h2>모든 유저 보기</h2>
<c:forEach var="in" items="${list }"><a href="${pageContext.servletContext.contextPath }/account.do?id=${in.ID}">☆ ${in.NAME }/${in.ID }/${in.EMAIL }/${in.BIRTH }/${in.GENDER }/${in.INTEREST }</a><br/></c:forEach>


	