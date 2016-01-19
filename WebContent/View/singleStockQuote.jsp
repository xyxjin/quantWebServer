<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>Stock info</title>
		<script type="text/javascript" src="jquery/jquery.min.js"></script>
		<script src="js/basic_line.js"></script>
	</head>
	<body>
		<p id="data">start</p>
		<%
			String stockId = (String)request.getAttribute("stockId");
			String stockQuote = (String)request.getAttribute("stockQuote");
		%>
		<script src="http://127.0.0.1/Highstock-2.1.3/js/highstock.js"></script>
		<script src="http://127.0.0.1/Highstock-2.1.3/js/modules/exporting.js"></script>
		<h1>It works!</h1> 	
			
  		<div id="container" style="height: 400px; width: 50%"></div>
  		<p id="data">hehe</p>
	</body>
</html>
