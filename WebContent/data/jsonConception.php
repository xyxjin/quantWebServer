<?php
	$con = mysql_connect("localhost:3306","root","");
	if (!$con)
  	{
  		die('Could not connect: ' . mysql_error());
  	}
	
	mysql_select_db("test", $con);
	$query ="SELECT distinct GN_NAME FROM conceptionindustry";
	$result = mysql_query($query);
	$jsondata = array();
	while($row = mysql_fetch_array($result))
  	{
		$jsondata[] = array($row[0]);
	}
	echo json_encode($jsondata);
	mysql_close($con);
?>