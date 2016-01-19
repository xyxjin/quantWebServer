<?php
	$con = mysql_connect("localhost:3306","root","");
	if (!$con)
  	{
  		die('Could not connect: ' . mysql_error());
  	}
	
	mysql_select_db("test", $con);
	$query ="SELECT P_OPEN,P_CLOSE,P_LOW,P_HIGH FROM " . 'tb' . $_GET['symbol'] . " ORDER BY `ID` ASC";
	$result = mysql_query($query);
	$jsondata = array();
	while($row = mysql_fetch_array($result))
  	{
		$jsondata[] = array((double)$row[0], (double)$row[1], (double)$row[2], (double)$row[3]);
	}
	echo json_encode($jsondata);
	mysql_close($con);
?>