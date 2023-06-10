# RepeatedEconomicSanctions

Investigating the effect of repeated sanctions imposition on their ability to extract policy concessions (BA thesis project).

To reproduce, first run `preparation.R`, then run `modelling.R`. The data should be directly pulled from the online sources. 

## Results
|x                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|<table style="NAborder-bottom: 0; width: auto !important; margin-left: auto; margin-right: auto;" class="table">
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> Naive </th>
   <th style="text-align:center;"> Panel </th>
   <th style="text-align:center;"> Naive  </th>
   <th style="text-align:center;"> Panel  </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Prior Sanctions </td>
   <td style="text-align:center;"> −0.026*** </td>
   <td style="text-align:center;"> −0.033*** </td>
   <td style="text-align:center;"> −0.020*** </td>
   <td style="text-align:center;"> −0.015* </td>
  </tr>
  <tr>
   <td style="text-align:left;box-shadow: 0px 1.5px">  </td>
   <td style="text-align:center;box-shadow: 0px 1.5px"> (0.005) </td>
   <td style="text-align:center;box-shadow: 0px 1.5px"> (0.011) </td>
   <td style="text-align:center;box-shadow: 0px 1.5px"> (0.005) </td>
   <td style="text-align:center;box-shadow: 0px 1.5px"> (0.008) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Num.Obs. </td>
   <td style="text-align:center;"> 845 </td>
   <td style="text-align:center;"> 845 </td>
   <td style="text-align:center;"> 845 </td>
   <td style="text-align:center;"> 845 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:center;"> 0.028 </td>
   <td style="text-align:center;"> 0.626 </td>
   <td style="text-align:center;"> 0.023 </td>
   <td style="text-align:center;"> 0.651 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 Adj. </td>
   <td style="text-align:center;"> 0.027 </td>
   <td style="text-align:center;"> 0.272 </td>
   <td style="text-align:center;"> 0.022 </td>
   <td style="text-align:center;"> 0.322 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 Within </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.044 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.013 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 Within Adj. </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.042 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.011 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> AIC </td>
   <td style="text-align:center;"> 1140.8 </td>
   <td style="text-align:center;"> 1150.6 </td>
   <td style="text-align:center;"> 861.1 </td>
   <td style="text-align:center;"> 806.3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BIC </td>
   <td style="text-align:center;"> 1155.0 </td>
   <td style="text-align:center;"> 3098.5 </td>
   <td style="text-align:center;"> 875.3 </td>
   <td style="text-align:center;"> 2754.2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F </td>
   <td style="text-align:center;"> 24.086 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 20.068 </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RMSE </td>
   <td style="text-align:center;"> 0.47 </td>
   <td style="text-align:center;"> 0.29 </td>
   <td style="text-align:center;"> 0.40 </td>
   <td style="text-align:center;"> 0.24 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Std.Errors </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> Driscoll-Kraay (L=2) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> Driscoll-Kraay (L=2) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> FE: dyad </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> X </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> X </td>
  </tr>
</tbody>
<tfoot><tr><td style="padding: 0; " colspan="100%">
<sup></sup> * p &lt; 0.1, ** p &lt; 0.05, *** p &lt; 0.01</td></tr></tfoot>
</table> |
Warnmeldung:
In add_header_above(kable(regtable(c(models_minimalist, models_maximalist),  :
  Please specify format in kable. kableExtra can customize either HTML or LaTeX outputs. See https://haozhu233.github.io/kableExtra/ for details.
> c(models_minimalist, models_maximalist) |> 
+   regtable(coef_rename = c("prior" = "Prior Sanctions")) |> 
+   add_header_above(
+     c(
+       " " = 1,
+       "Success \n(Minimalist)" = 2,
+       "Success \n(Maximalist)" = 2
+     )
+   ) |> 
+   kable(format = "pipe")


|x                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|<table style="NAborder-bottom: 0; width: auto !important; margin-left: auto; margin-right: auto;" class="table">
 <thead>
<tr>
<th style="empty-cells: hide;border-bottom:hidden;" colspan="1"></th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Success <br>(Minimalist)</div></th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Success <br>(Maximalist)</div></th>
</tr>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> Naive </th>
   <th style="text-align:center;"> Panel </th>
   <th style="text-align:center;"> Naive  </th>
   <th style="text-align:center;"> Panel  </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Prior Sanctions </td>
   <td style="text-align:center;"> −0.026*** </td>
   <td style="text-align:center;"> −0.033*** </td>
   <td style="text-align:center;"> −0.020*** </td>
   <td style="text-align:center;"> −0.015* </td>
  </tr>
  <tr>
   <td style="text-align:left;box-shadow: 0px 1.5px">  </td>
   <td style="text-align:center;box-shadow: 0px 1.5px"> (0.005) </td>
   <td style="text-align:center;box-shadow: 0px 1.5px"> (0.011) </td>
   <td style="text-align:center;box-shadow: 0px 1.5px"> (0.005) </td>
   <td style="text-align:center;box-shadow: 0px 1.5px"> (0.008) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Num.Obs. </td>
   <td style="text-align:center;"> 845 </td>
   <td style="text-align:center;"> 845 </td>
   <td style="text-align:center;"> 845 </td>
   <td style="text-align:center;"> 845 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:center;"> 0.028 </td>
   <td style="text-align:center;"> 0.626 </td>
   <td style="text-align:center;"> 0.023 </td>
   <td style="text-align:center;"> 0.651 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 Adj. </td>
   <td style="text-align:center;"> 0.027 </td>
   <td style="text-align:center;"> 0.272 </td>
   <td style="text-align:center;"> 0.022 </td>
   <td style="text-align:center;"> 0.322 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 Within </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.044 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.013 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 Within Adj. </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.042 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.011 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> AIC </td>
   <td style="text-align:center;"> 1140.8 </td>
   <td style="text-align:center;"> 1150.6 </td>
   <td style="text-align:center;"> 861.1 </td>
   <td style="text-align:center;"> 806.3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BIC </td>
   <td style="text-align:center;"> 1155.0 </td>
   <td style="text-align:center;"> 3098.5 </td>
   <td style="text-align:center;"> 875.3 </td>
   <td style="text-align:center;"> 2754.2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F </td>
   <td style="text-align:center;"> 24.086 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 20.068 </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RMSE </td>
   <td style="text-align:center;"> 0.47 </td>
   <td style="text-align:center;"> 0.29 </td>
   <td style="text-align:center;"> 0.40 </td>
   <td style="text-align:center;"> 0.24 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Std.Errors </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> Driscoll-Kraay (L=2) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> Driscoll-Kraay (L=2) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> FE: dyad </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> X </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> X </td>
  </tr>
</tbody>
<tfoot><tr><td style="padding: 0; " colspan="100%">
<sup></sup> * p &lt; 0.1, ** p &lt; 0.05, *** p &lt; 0.01</td></tr></tfoot>
</table> |
> c(models_minimalist, models_maximalist) |> 
+   regtable(coef_rename = c("prior" = "Prior Sanctions")) |> 
+   add_header_above(
+     c(
+       " " = 1,
+       "Success \n(Minimalist)" = 2,
+       "Success \n(Maximalist)" = 2
+     )
+   )
> c(models_minimalist, models_maximalist) |> 
+   regtable(coef_rename = c("prior" = "Prior Sanctions")) |> 
+   add_header_above(
+     c(
+       " " = 1,
+       "Success \n(Minimalist)" = 2,
+       "Success \n(Maximalist)" = 2
+     )
+   ) |> 
+   kable("html")
<table>
 <thead>
  <tr>
   <th style="text-align:left;"> x </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> &lt;table style=&quot;NAborder-bottom: 0; width: auto !important; margin-left: auto; margin-right: auto;&quot; class=&quot;table&quot;&gt;
 &lt;thead&gt;
&lt;tr&gt;
&lt;th style=&quot;empty-cells: hide;border-bottom:hidden;&quot; colspan=&quot;1&quot;&gt;&lt;/th&gt;
&lt;th style=&quot;border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; &quot; colspan=&quot;2&quot;&gt;&lt;div style=&quot;border-bottom: 1px solid #ddd; padding-bottom: 5px; &quot;&gt;Success &lt;br&gt;(Minimalist)&lt;/div&gt;&lt;/th&gt;
&lt;th style=&quot;border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; &quot; colspan=&quot;2&quot;&gt;&lt;div style=&quot;border-bottom: 1px solid #ddd; padding-bottom: 5px; &quot;&gt;Success &lt;br&gt;(Maximalist)&lt;/div&gt;&lt;/th&gt;
&lt;/tr&gt;
  &lt;tr&gt;
   &lt;th style=&quot;text-align:left;&quot;&gt;   &lt;/th&gt;
   &lt;th style=&quot;text-align:center;&quot;&gt; Naive &lt;/th&gt;
   &lt;th style=&quot;text-align:center;&quot;&gt; Panel &lt;/th&gt;
   &lt;th style=&quot;text-align:center;&quot;&gt; Naive  &lt;/th&gt;
   &lt;th style=&quot;text-align:center;&quot;&gt; Panel  &lt;/th&gt;
  &lt;/tr&gt;
 &lt;/thead&gt;
&lt;tbody&gt;
  &lt;tr&gt;
   &lt;td style=&quot;text-align:left;&quot;&gt; Prior Sanctions &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; −0.026*** &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; −0.033*** &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; −0.020*** &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; −0.015* &lt;/td&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
   &lt;td style=&quot;text-align:left;box-shadow: 0px 1.5px&quot;&gt;  &lt;/td&gt;
   &lt;td style=&quot;text-align:center;box-shadow: 0px 1.5px&quot;&gt; (0.005) &lt;/td&gt;
   &lt;td style=&quot;text-align:center;box-shadow: 0px 1.5px&quot;&gt; (0.011) &lt;/td&gt;
   &lt;td style=&quot;text-align:center;box-shadow: 0px 1.5px&quot;&gt; (0.005) &lt;/td&gt;
   &lt;td style=&quot;text-align:center;box-shadow: 0px 1.5px&quot;&gt; (0.008) &lt;/td&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
   &lt;td style=&quot;text-align:left;&quot;&gt; Num.Obs. &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 845 &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 845 &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 845 &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 845 &lt;/td&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
   &lt;td style=&quot;text-align:left;&quot;&gt; R2 &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 0.028 &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 0.626 &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 0.023 &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 0.651 &lt;/td&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
   &lt;td style=&quot;text-align:left;&quot;&gt; R2 Adj. &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 0.027 &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 0.272 &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 0.022 &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 0.322 &lt;/td&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
   &lt;td style=&quot;text-align:left;&quot;&gt; R2 Within &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt;  &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 0.044 &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt;  &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 0.013 &lt;/td&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
   &lt;td style=&quot;text-align:left;&quot;&gt; R2 Within Adj. &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt;  &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 0.042 &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt;  &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 0.011 &lt;/td&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
   &lt;td style=&quot;text-align:left;&quot;&gt; AIC &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 1140.8 &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 1150.6 &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 861.1 &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 806.3 &lt;/td&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
   &lt;td style=&quot;text-align:left;&quot;&gt; BIC &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 1155.0 &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 3098.5 &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 875.3 &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 2754.2 &lt;/td&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
   &lt;td style=&quot;text-align:left;&quot;&gt; F &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 24.086 &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt;  &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 20.068 &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt;  &lt;/td&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
   &lt;td style=&quot;text-align:left;&quot;&gt; RMSE &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 0.47 &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 0.29 &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 0.40 &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; 0.24 &lt;/td&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
   &lt;td style=&quot;text-align:left;&quot;&gt; Std.Errors &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt;  &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; Driscoll-Kraay (L=2) &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt;  &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; Driscoll-Kraay (L=2) &lt;/td&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
   &lt;td style=&quot;text-align:left;&quot;&gt; FE: dyad &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt;  &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; X &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt;  &lt;/td&gt;
   &lt;td style=&quot;text-align:center;&quot;&gt; X &lt;/td&gt;
  &lt;/tr&gt;
&lt;/tbody&gt;
&lt;tfoot&gt;&lt;tr&gt;&lt;td style=&quot;padding: 0; &quot; colspan=&quot;100%&quot;&gt;
&lt;sup&gt;&lt;/sup&gt; * p &amp;lt; 0.1, ** p &amp;lt; 0.05, *** p &amp;lt; 0.01&lt;/td&gt;&lt;/tr&gt;&lt;/tfoot&gt;
&lt;/table&gt; </td>
  </tr>
</tbody>
</table>
