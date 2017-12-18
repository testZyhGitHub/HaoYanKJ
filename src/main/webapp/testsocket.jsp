<%--
  Created by IntelliJ IDEA.
  User: TommyYang
  Date: 2017/12/18
  Time: 23:06
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Insert title here</title>
</head>
<body>
<script type="text/javascript" src="http://cdn.bootcss.com/jquery/3.1.0/jquery.min.js"></script>
<script type="text/javascript" src="http://cdn.bootcss.com/sockjs-client/1.1.1/sockjs.js"></script>

<script type="text/javascript">

    var msgDiv = document.getElementById("#msgDiv");
    var websocket = null;
    if ('WebSocket' in window) {
        websocket = new WebSocket("ws://localhost:8080/websocket/socketServer.do");
    }
    else if ('MozWebSocket' in window) {
        websocket = new MozWebSocket("ws://localhost:8080/websocket/socketServer.do");
    }
    else {
        websocket = new SockJS("http://localhost:8080/sockjs/socketServer.do");
    }
    websocket.onopen = onOpen;
    websocket.onmessage = onMessage;
    websocket.onerror = onError;
    websocket.onclose = onClose;

    function onOpen(openEvt) {
        //alert(openEvt.Data+"onOpen");
    }

    function onMessage(evt) {
        alert(evt.data+"onMessage");
    }
    function onError() {
        alert("出错"+"onError");
    }
    function onClose() {
        alert("关闭"+"onClose");
    }

    function doSend() {
        if (websocket.readyState == websocket.OPEN) {
            var msg = document.getElementById("inputMsg").value;
            websocket.send(msg); //调用后台handleTextMessage方法
            alert("发送成功!");
        } else {
            alert("连接失败!");
        }
    }
    window.close=function(){
        websocket.onclose();
    }
</script>
<body align="center">
<h3>消息推送</h3>
请输入：<textarea rows="8" cols="50" id="inputMsg" name="inputMsg"></textarea>
<button onclick="doSend();">发送</button>
<hr/>
<textarea rows="10" cols="70" id="msgDiv"></textarea>
</body>
</html>
