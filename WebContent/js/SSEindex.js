require.config({
    paths: {
        echarts: 'echarts-2.2.1/build/dist/chart/k.js'
    }
});
 require(
[
    'echarts',
    'echarts/chart/k'
],
function(ec){
    var value = "sh000001";
    $.getJSON('http://127.0.0.1/firstWeb/data/jsonDate.php?symbol='+ value, function (date){
        $.getJSON('http://127.0.0.1/firstWeb/data/jsonOHLC.php?symbol='+ value, function (quotes){
            var myChart = ec.init(document.getElementById('ssci')); 
            var option = {
            	title : {
			        text: value
			    },
                tooltip : {
			        trigger: 'axis',
			        formatter: function (params) {
			            var res = params[0].seriesName + ' ' + params[0].name;
			            res += '<br/>  开盘 : ' + params[0].value[0] + '  最高 : ' + params[0].value[3];
			            res += '<br/>  收盘 : ' + params[0].value[1] + '  最低 : ' + params[0].value[2];
			            return res;
			        }
			    },
                legend: {
			        data:[value]
			    },
			    toolbox: {
			        show : true,
			        feature : {
			            mark : {show: true},
			            dataZoom : {show: true},
			            dataView : {show: true, readOnly: false},
			            magicType: {show: true, type: ['line', 'bar']},
			            restore : {show: true},
			            saveAsImage : {show: true}
			        }
			    },
			    dataZoom : {
			        show : true,
			        realtime: true,
			        start : 99,
			        end : 100
			    },
                xAxis : [
                    {
                        type : 'category',
			            boundaryGap : true,
			            axisTick: {onGap:false},
			            splitLine: {show:false},
                        data : date
                    }
                ],
                yAxis : [
			        {
			            type : 'value',
			            scale:true,
			            boundaryGap: [0.01, 0.01]
			        }
			    ],
                series : [
                    {
                        name:"sh000001",
                        type:"k",
                        data:quotes
                    }
                ]
            };
            myChart.setOption(option); 
		});
	});
});