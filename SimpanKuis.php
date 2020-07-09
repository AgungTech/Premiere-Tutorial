<?php
if(!empty($_POST['xml_data']))
{
	$data_xml = $_POST['xml_data'];
	$fileName = "Quiz.".date(DATE_ATOM, time()).".xml";
	$filePath = "../simpan/".$fileName;
	$fp = fopen($filePath, 'w') or die("<response><message>error</message></response>");
	fwrite($fp,$data_xml,strlen($data_xml));
	fclose($fp);
    echo "<response><message>success</message><fileName>".$fileName."</fileName></response>";
} else 
{
    echo "<response><message>error</message></response>";
}
?>  