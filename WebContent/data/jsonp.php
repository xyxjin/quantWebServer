<?php
	$con = mysql_connect("localhost:3306","root","");
	if (!$con)
  	{
  		die('Could not connect: ' . mysql_error());
  	}
	
	mysql_select_db("test", $con);
	$query ="SELECT DATE_TIME,P_CLOSE FROM " . 'tb' . $_GET['symbol'];
	$result = mysql_query($query);
	$jsondata = array();
	
	//echo $query;
	while($row = mysql_fetch_array($result))
  	{
  		$ticks = strtotime($row[0])*1000 + 3600000;
		$jsondata[] = array($ticks, (double)$row[1]);
	}
	echo json_encode($jsondata);
	mysql_close($con);
?>