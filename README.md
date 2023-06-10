# RepeatedEconomicSanctions

Investigating the effect of repeated sanctions imposition on their ability to extract policy concessions (BA thesis project).

To reproduce, first run `preparation.R`, then run `modelling.R`. The data should be directly pulled from the online sources. 

## Results
<table style="NAborder-bottom: 0; width: auto !important; margin-left: auto; margin-right: auto;" class="table">
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
</table>


