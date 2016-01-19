require.config({
    paths: {
        echarts: 'echarts-2.2.1/build/dist/chart/line.js'
    }
});
 require(
[
    'echarts',
    'echarts/chart/line'
],
function (echart) {
	$.extend({
	  getUrlVars: function(){
	    var vars = [], hash;
	    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
	    for(var i = 0; i < hashes.length; i++)
	    {
	      hash = hashes[i].split('=');
	      vars.push(hash[0]);
	      vars[hash[0]] = hash[1];
	    }
	    return vars;
	  },
	  getUrlVar: function(name){
	    return $.getUrlVars()[name];
	  }
	});
	var gn_name = $.getUrlVar('gn');
	var start = $.getUrlVar('start');
	var end = $.getUrlVar('end');

	$.getJSON('http://127.0.0.1/firstWeb/data/jsonCompareIndustry.php?gn=' + gn_name + "&start="+ start +"&end="+ end, function (str) {
		var myChart = echart.init(document.getElementById('container'));
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
			            magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},
			            restore : {show: true},
			            saveAsImage : {show: true}
			        }
			    },
			    calculable : true,
			    dataZoom: {
			        show: true,
			        start : 40
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