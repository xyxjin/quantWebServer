<?php
	$con = mysql_connect("localhost:3306","root","");
	if (!$con)
  	{
  		die('Could not connect: ' . mysql_error());
  	}
	
	mysql_select_db("test", $con);
	$query ="SELECT DATE_TIME FROM " . 'tb' . $_GET['symbol'] . " ORDER BY `ID` ASC";
	//echo $query;
	$result = mysql_query($query);
	$jsondata = array();
	while($row = mysql_fetch_array($result))
  	{
  		//$ticks = strtotime($row[0])*1000 + 3600000;
  		$date = explode(' ', $row[0]);
		array_push($jsondata, $date[0]);
	}
	echo json_encode($jsondata);
	mysql_close($con);
?>