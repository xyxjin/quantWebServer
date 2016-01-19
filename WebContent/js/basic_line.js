$(function () {
	//var query = location.search.substring(1);
	//var pos  = query.indexOf('=');
	//var value = query.substring(pos+1);
	var stockId ='<%=stockId%>';
	var data = '<%=stockQuote%>';
	//$.getJSON('http://127.0.0.1/firstWeb/data/jsonp.php?symbol='+ value, function (data) {
	//	});	
	$("#container").highcharts('StockChart', {
		rangeSelector : {
			selected : 1
		},

		title : {
			text : value
		},

		series : [{
			name : value,
			data : data,
			tooltip: {
				valueDecimals: 2
			}
		}]
	});
});