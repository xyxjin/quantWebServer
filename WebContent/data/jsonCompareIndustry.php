<?php
	$fator = 3;
	$con = mysql_connect("localhost:3306","root","");
	if (!$con)
  	{
  		die('Could not connect: ' . mysql_error());
  	}
	mysql_select_db("test", $con);
	$query ="SELECT sdb_id FROM conceptionindustry where gn_name=" . "'gn_" . $_GET['gn'] . "'";
	//echo $query;
	$result = mysql_query($query);
	$stocks = array();
	while($row = mysql_fetch_array($result))
  	{
		array_push($stocks, $row[0]);
	}
	$start = $_GET['start'].'  00:00:00';
	$end = $_GET['end'].'  00:00:00';
	$increase = array();
	for($i=0;$i<count($stocks);$i++){
		$query ="SELECT P_CLOSE FROM " . 'tb' . $stocks[$i] . " where DATE_TIME>="."'".$start."'"." and DATE_TIME<="."'".$end."'";
		$result = mysql_query($query);
		$row = mysql_fetch_array($result);
		$start_value = $row[0]; 
		while($row = mysql_fetch_array($result))
	  	{
			$end_value = $row[0];
		}
		if($start_value==$end_value or $start_value==0){
			//echo $stocks[$i].'   ';
			continue;			
		}
		//echo 'stock info: '.$stocks[$i].'   ';
		$increase[$stocks[$i]] = ($end_value-$start_value)/$start_value * 100;
	}
	arsort($increase);
	//echo json_encode($increase);
	$interstedCount = (integer)(count($stocks)/$fator + 1);
	//echo $interstedCount;
	$interstedStock = array_slice($increase, 0, $interstedCount, true);
	//echo "intersterd";
	//echo json_encode($interstedStock);
	
	//echo json_encode(array_keys($interstedStock));
	
	$resultAllStocks = array();
	for($i=0;$i<count($interstedStock);$i++){
		$query ="SELECT P_CLOSE,DATE_TIME FROM " . 'tb' . array_keys($interstedStock)[$i] . " where DATE_TIME>="."'".$start."'"." and DATE_TIME<="."'".$end."'";
		//echo $query;
		$result = mysql_query($query);
		$row = mysql_fetch_array($result);
		$start_value = $row[0];
		$resultPerStock = array();
		while($row = mysql_fetch_array($result))
	  	{
			$end_value = $row[0];
			$tmp = ($end_value-$start_value)/$start_value * 100;
			$resultPerStock[substr($row[1],0,10)] = round($tmp,2);
			//$start_value = $end_value;
		}
		$resultAllStocks[array_keys($interstedStock)[$i]] = $resultPerStock;
		//echo json_encode($resultPerStock);
	}
	
	echo json_encode($resultAllStocks);
	mysql_close($con);
?>