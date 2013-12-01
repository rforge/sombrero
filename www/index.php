
<!-- This is the project specific website template -->
<!-- It can be changed as liked or replaced by other content -->

<?php

$domain=ereg_replace('[^\.]*\.(.*)$','\1',$_SERVER['HTTP_HOST']);
$group_name=ereg_replace('([^\.]*)\..*$','\1',$_SERVER['HTTP_HOST']);
$themeroot='r-forge.r-project.org/themes/rforge/';

echo '<?xml version="1.0" encoding="UTF-8"?>';
?>
<!DOCTYPE html
	PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en   ">

  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title><?php echo $group_name; ?></title>
	<link href="http://<?php echo $themeroot; ?>styles/estilo1.css" rel="stylesheet" type="text/css" />
  </head>

<body>

<!-- R-Forge Logo -->
<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tr><td>
<a href="http://r-forge.r-project.org/"><img src="http://<?php echo $themeroot; ?>/imagesrf/logo.png" border="0" alt="R-Forge Logo" /> </a> </td> </tr>
</table>


<!-- get project title  -->
<!-- own website starts here, the following may be changed as you like -->

<table border="0" width="100%" cellspacing="0" cellpadding="0">
<tr><td>
<a href=""><img src="http://tuxette.nathalievilla.org/wp-content/uploads/2013/06/sombrero.png" border="0" alt="SOMbrero" width="250" /> </a></td>
<td>
<?php if ($handle=fopen('http://'.$domain.'/export/projtitl.php?group_name='.$group_name,'r')){
$contents = '';
while (!feof($handle)) {
	$contents .= fread($handle, 8192);
}
fclose($handle);
echo $contents; } ?>
</td></tr></table>

<!-- end of project description -->

<ul>
<li>Find the <strong>project summary page</strong> <a href="http://<?php echo $domain; ?>/projects/<?php echo $group_name; ?>/">here</a>. </li>
<li>Find the <strong>project webpage</strong> with various documents <a href="http://tuxette.nathalievilla.org/?p=1099&lang=en">here</a>.</li>
<li>Find a Web User Interface, based on <a href="http://www.rstudio.com/shiny/">shiny</a>, <a href="http://shiny.nathalievilla.org/sombrero">here</a> (SOMbrero WUI, v0.1 based on SOMbrero v0.4-1).</li>
<li>Download the <a href="./SOMbrero-manual.pdf">manual</a>.</li><li><strong>Package's vignettes</strong> (detailed use cases) are also available for <a href="./doc-numericSOM.html">numeric data</a>,
for <a href="./doc-korrespSOM.html">contingency tables</a> and for <a href="./doc-relationalSOM.html">dissimilarity data</a>.
An overview of the package is given in the <a href="./doc-SOMbrero-package.html">package's main vignette</a>.</li>
<li>You can find the <strong>download page</strong> <a href="https://r-forge.r-project.org/R/?group_id=1707">here</a>. Installation is done by using the R install command:
<pre>
install.packages("SOMbrero", repos="http://R-Forge.R-project.org")
</pre>
or, alternatively, 
<pre>
install.packages("SOMbrero", repos="http://R-Forge.R-project.org", type="source")
</pre>
if you are using a Mac.<br></li>
</ul>

<p style="color:#A558B4"><em>Remember that this package has been developped only by girls. Default colors may not be suited for men.</em></p>

To cite the package, please use:
<ul>
<li>
Villa-Vialaneix N., Bendhaiba L., Olteanu M. (2013) <em>SOMbrero: SOM Bound to Realize Euclidean and Relational Outputs</em>. R package version 0.4.
</li>
<li>

<li>Olteanu M., Villa-Vialaneix N. (2013) On-line relational and multiple relational SOM. <em>Neurocomputing</em>. <em>Forthcoming</em>.</li>
<li>Olteanu M., Villa-Vialaneix N., Cottrell M. (2012) On-line relational SOM for dissimilarity data. <em>Advances in Self-Organizing Maps (Proceedings of WSOM 2012, Santiago, Chili, 12-14 decembre 2012), Estevez P., Principe  J., Zegers P., Barreto G. (eds.), Advances in Intelligent Systems and Computing series</em>, Berlin/Heidelberg:  Springer Verlag, <b>198</b>, 13-22.</li></ul>


</body>
</html>

