<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<h4>Chat Room <small id="ho">(${depart })</small></h4>
<div style="height: 520px; overflow-y: scroll; " id="chatView">
	<c:forEach var="v" items="${publicchatAll }">
		
			
			<div class="alert alert-secondary" role="alert" style="padding:3px; margin-bottom:3px;">
			?: ?  / <small><b>?</b></small>
			</div>
		
	</c:forEach>
</div>
<div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon1">CHAT</span>
  </div>
  <input type="text" class="form-control" aria-describedby="basic-addon1"
  	id="input" >
</div>

<script>



</script>

