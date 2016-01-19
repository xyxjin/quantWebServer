<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>main</title>
		<script type="text/javascript" src="jquery/jquery.min.js"></script>
		<script src="js/json2.js"></script>
		<script src="js/basic_line.js"></script>
		<script>
			$(document).ready(function(){
				$("#ind").empty();
				$("<option id=##>industry</option>").appendTo($("#ind"));
				$.getJSON("http://127.0.0.1/firstWeb/data/jsonConception.php", function(data){
					$.each(data, function(i, item){
						$("<option></option>").val(item).text(item[0].substring(3)).appendTo($("#ind"));
					});
				});
			});
		</script>
	</head>
	<body>
		<script src="http://127.0.0.1/Highstock-2.1.3/js/highstock.js"></script>
		<script src="http://127.0.0.1/Highstock-2.1.3/js/modules/exporting.js"></script>
		<form name="input" action="SingleStock" method="get" target="_blank">
  			<p>Stock Symbol: <input type="text" id="stockId" name="symbol" />
  			<input type="submit" value="Submit" />
  			</p>
  		</form>
  		<form name="input" action="WebContent/industry.html" method="get" target="_blank">
  			<p>Industry: 
 			<select id="ind" name="industry" onchange="submit();">
			</select>
			</p>
  		</form>
  		<form name="input" action="WebContent/compare_industry.html" method="get" target="_blank">
  			<p>Industry Name: <input type="text" id="ind1" name="gn" />
  			<input type="date" id="startDate" name="start" />
  			<input type="date" id="endDate" name="end" />
  			<input type="submit" id="" value="Submit" />
  			</p>
  		</form>
  		<!---
  		<button>向页面发送 HTTP GET 请求，然后获得返回的结果</button>
  		<script>
  			$(document).ready(function(){
  				$("button").click(function(){
  					//alert("here");
  					//style="height:400px; width: 33%"
	  				$.getJSON("http://data.gtimg.cn/flashdata/hushen/daily/15/sh000001.js", function(data){
	  					alert("Data Loaded: " + data);
					});
				});
			});
  		</script>
  		--->
  		<!---
  		<div>
	  		<div id="ssci" style="height:400px; width: 33%; float:left"></div>
	  		<div id="szci" style="height:400px; width: 33%; float:left"></div>
	  		<div id="cyci" style="height:400px; width: 33%; float:left"></div>
  		</div>
  		--->
  		<script src="WebContent/echarts-2.2.1/build/dist/echarts.js"></script>
  		<script src="WebContent/echarts-2.2.1/build/dist/chart/k.js"></script>
  		<script src="WebContent/echarts-2.2.1/build/dist/chart/line.js"></script>
  		<script src="WebContent/js/SSEindex.js"></script>
  		<script src="WebContent/js/SZEindex.js"></script>
  		<script src="WebContent/js/CYBindex.js"></script>
  		
  		<button>向页面发送 HTTP GET 请求，然后获得返回的结果</button>
  		<div id="container" style="height:400px"></div>
  		<script>
  			//$(document).ready(function(){
  				//$("button").click(function(){
  					//alert("data");
  			require.config({
			    paths: {
			        echarts: 'WebContent/echarts-2.2.1/build/dist/chart/line.js'
			    }
				});
				 require(
				[
				    'echarts',
				    'echarts/chart/line'
				],
				function (ec){
					var myChart = ec.init(document.getElementById('container'));
  					$.getJSON('http://127.0.0.1/quantWeb/WebContent/data/jsonCompareIndustry.php?gn=scp&start=2015-01-25&end=2015-04-01', function (str) {  					
  						var option = {
						    tooltip : {
						        trigger: 'axis'
						    },
						    legend: {
						        data: new Array()
						    },
						    toolbox: {
						        show : true,
						        feature : {
						            mark : {show: true},
						            dataView : {show: true, readOnly: false},
						            magicType : {show: true, type: ['line']},
						            restore : {show: true},
						            saveAsImage : {show: true}
						        }
						    },
						    calculable : true,
						    dataZoom: {
						        show: true,
						        start : 70
						    },
						    xAxis : [
						        {
						            type : 'category',
						            boundaryGap : false,
						            data : new Array()
						        }
						    ],
						    yAxis : [
						        {
						            type : 'value',
						            axisLabel : {
						                formatter: '{value}'
						            }
						        }
						    ],
						    series : new Array()
						};
						//var stock = "002345";
						var flag = 0;
						for(stock in str){
							option.legend.data.push(stock);
							mydata = new Array();
							for(date in str[stock]){
								if(flag == 0){
									option.xAxis[0].data.push(date);
								}
								mydata.push((str[stock][date]));
							}
							flag = 1;
							mySeries = new Object();
							mySeries.name = stock;
							mySeries.type = 'line';
							//mySeries.stack = '总量';
							mySeries.data = mydata;	
							option.series.push(mySeries);						
						}

						myChart.setOption(option);
					});
				});
  		</script>
  		<p id="data">hehe</p>
	</body>
</html>
