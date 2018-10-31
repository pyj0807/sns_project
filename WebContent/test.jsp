<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<head>
<title>test</title>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />

<link rel="stylesheet" type="text/css" media="screen" href="css/jquery-ui-1.8.23.custom.css"/>

</head>

<body>

    <p>First open a modal <a href="http://ibm.com" class="example"> dialog</a></p>
    <div id="dialog"></div>
</body>

<!--jQuery-->
<script src="http://code.jquery.com/jquery-latest.pack.js"></script>
<script src="js/jquery-ui-1.8.23.custom.min.js"></script>

<script type="text/javascript">

$(function(){
//modal window start
$(".example").unbind('click');
$(".example").bind('click',function(){
    showDialog();
    var titletext=$(this).attr("title");
    var openpage=$(this).attr("href");
    $("#dialog").dialog( "option", "title", titletext );
    $("#dialog").dialog( "option", "resizable", false );
    $("#dialog").dialog( "option", "buttons", { 
        "Close": function() { 
            $(this).dialog("close");
            $(this).dialog("destroy");
        } 
    });
    $("#dialog").load(openpage);
    return false;
});

//modal window end

//Modal Window Initiation start

function showDialog(){
    $("#dialog").dialog({
        height: 400,
        width: 500,
        modal: true 
    }
</script>

</html>