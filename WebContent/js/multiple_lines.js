$(function () {
	var query = location.search.substring(1);
	var pos  = query.indexOf('=');
	var gn_name = query.substring(pos+1);
	var displayCount = 0;
	$.getJSON('http://127.0.0.1/firstWeb/data/jsonConceptStock.php?industry=' + gn_name, function (symbol) {
		$.each(symbol, function(i, item){
			$('<div id="'+item[0]+'" style="height: 400px; width: 50%"></div>"').appendTo($("#container"));
			$.getJSON('http://127.0.0.1/firstWeb/data/jsonp.php?symbol='+ item[0], function (quote)
			{
				$("#"+item[0]).highcharts('StockChart', {
				rangeSelector : {
					selected : 1
				},
	
				title : {
					text : item[0]
				},
	
				series : [{
					name : item[0],
					data : quote,
					tooltip: {
						valueDecimals: 2
						}
					}]
				});
			});
			i++;
		});
	});	
});