# "Overuse" of Economic Sanctions - Does Repeated Imposition of Economic Sanctions Hurt Their Effectiveness?

*BA-thesis project.* Drawing on the ["Threat and Imposition of Economic Sanctions" (TIES)](https://sanctions.web.unc.edu/) data set, I consider an unbalanced panel of sender-target dyads to examine, whether the number of previously imposed sanctions in a dyad has a negative effect of newly imposed sanctions to extract policy concessions. 

To reproduce, first run `preparation.R`, then run `modelling.R`. The data should be directly pulled from the online sources. 

## Results

### Overall effects

* *Minimalist*: Including negotiated settlements of the sanctions episode as successful.
* *Maximalist*: Only counting complete or partial acquiescence by the target state to sender demands as successful.

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

### Prior sanctions in past five/ten years:

<table style="NAborder-bottom: 0; width: auto !important; margin-left: auto; margin-right: auto;" class="table">
 <thead>
<tr>
<th style="empty-cells: hide;border-bottom:hidden;" colspan="1"></th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Success <br>(Maximalist)</div></th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Success <br>(Minimalist)</div></th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Success <br>(Maximalist)</div></th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Success <br>(Minimalist)</div></th>
</tr>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> Naive </th>
   <th style="text-align:center;"> Panel </th>
   <th style="text-align:center;"> Naive  </th>
   <th style="text-align:center;"> Panel  </th>
   <th style="text-align:center;"> Naive   </th>
   <th style="text-align:center;"> Panel   </th>
   <th style="text-align:center;"> Naive    </th>
   <th style="text-align:center;"> Panel    </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Prior Sanctions (last 10 years) </td>
   <td style="text-align:center;"> −0.025*** </td>
   <td style="text-align:center;"> −0.008 </td>
   <td style="text-align:center;"> −0.031*** </td>
   <td style="text-align:center;"> −0.029** </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.005) </td>
   <td style="text-align:center;"> (0.007) </td>
   <td style="text-align:center;"> (0.006) </td>
   <td style="text-align:center;"> (0.012) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Prior Sanctions (last 5 years) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> −0.030*** </td>
   <td style="text-align:center;"> −0.004 </td>
   <td style="text-align:center;"> −0.037*** </td>
   <td style="text-align:center;"> −0.024* </td>
  </tr>
  <tr>
   <td style="text-align:left;box-shadow: 0px 1.5px">  </td>
   <td style="text-align:center;box-shadow: 0px 1.5px">  </td>
   <td style="text-align:center;box-shadow: 0px 1.5px">  </td>
   <td style="text-align:center;box-shadow: 0px 1.5px">  </td>
   <td style="text-align:center;box-shadow: 0px 1.5px">  </td>
   <td style="text-align:center;box-shadow: 0px 1.5px"> (0.007) </td>
   <td style="text-align:center;box-shadow: 0px 1.5px"> (0.008) </td>
   <td style="text-align:center;box-shadow: 0px 1.5px"> (0.008) </td>
   <td style="text-align:center;box-shadow: 0px 1.5px"> (0.015) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Num.Obs. </td>
   <td style="text-align:center;"> 840 </td>
   <td style="text-align:center;"> 840 </td>
   <td style="text-align:center;"> 840 </td>
   <td style="text-align:center;"> 840 </td>
   <td style="text-align:center;"> 840 </td>
   <td style="text-align:center;"> 840 </td>
   <td style="text-align:center;"> 840 </td>
   <td style="text-align:center;"> 840 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:center;"> 0.026 </td>
   <td style="text-align:center;"> 0.653 </td>
   <td style="text-align:center;"> 0.028 </td>
   <td style="text-align:center;"> 0.620 </td>
   <td style="text-align:center;"> 0.024 </td>
   <td style="text-align:center;"> 0.653 </td>
   <td style="text-align:center;"> 0.025 </td>
   <td style="text-align:center;"> 0.616 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 Adj. </td>
   <td style="text-align:center;"> 0.025 </td>
   <td style="text-align:center;"> 0.324 </td>
   <td style="text-align:center;"> 0.027 </td>
   <td style="text-align:center;"> 0.259 </td>
   <td style="text-align:center;"> 0.023 </td>
   <td style="text-align:center;"> 0.322 </td>
   <td style="text-align:center;"> 0.024 </td>
   <td style="text-align:center;"> 0.250 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 Within </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.003 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.020 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.000 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.009 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 Within Adj. </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.000 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.018 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> −0.002 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.006 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> AIC </td>
   <td style="text-align:center;"> 857.2 </td>
   <td style="text-align:center;"> 803.7 </td>
   <td style="text-align:center;"> 1133.7 </td>
   <td style="text-align:center;"> 1158.0 </td>
   <td style="text-align:center;"> 858.9 </td>
   <td style="text-align:center;"> 805.5 </td>
   <td style="text-align:center;"> 1136.0 </td>
   <td style="text-align:center;"> 1168.0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BIC </td>
   <td style="text-align:center;"> 871.4 </td>
   <td style="text-align:center;"> 2744.4 </td>
   <td style="text-align:center;"> 1147.9 </td>
   <td style="text-align:center;"> 3098.7 </td>
   <td style="text-align:center;"> 873.1 </td>
   <td style="text-align:center;"> 2746.2 </td>
   <td style="text-align:center;"> 1150.2 </td>
   <td style="text-align:center;"> 3108.7 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F </td>
   <td style="text-align:center;"> 22.462 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 24.068 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 20.735 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 21.690 </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RMSE </td>
   <td style="text-align:center;"> 0.40 </td>
   <td style="text-align:center;"> 0.24 </td>
   <td style="text-align:center;"> 0.47 </td>
   <td style="text-align:center;"> 0.30 </td>
   <td style="text-align:center;"> 0.40 </td>
   <td style="text-align:center;"> 0.24 </td>
   <td style="text-align:center;"> 0.47 </td>
   <td style="text-align:center;"> 0.30 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Std.Errors </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> Driscoll-Kraay (L=2) </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> Driscoll-Kraay (L=2) </td>
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
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> X </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> X </td>
  </tr>
</tbody>
<tfoot><tr><td style="padding: 0; " colspan="100%">
<sup></sup> * p &lt; 0.1, ** p &lt; 0.05, *** p &lt; 0.01</td></tr></tfoot>
</table>

### Dummy independent variable

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
   <td style="text-align:left;"> Prior Sanctions (dummy) </td>
   <td style="text-align:center;"> −0.152*** </td>
   <td style="text-align:center;"> −0.139*** </td>
   <td style="text-align:center;"> −0.107*** </td>
   <td style="text-align:center;"> −0.072** </td>
  </tr>
  <tr>
   <td style="text-align:left;box-shadow: 0px 1.5px">  </td>
   <td style="text-align:center;box-shadow: 0px 1.5px"> (0.033) </td>
   <td style="text-align:center;box-shadow: 0px 1.5px"> (0.050) </td>
   <td style="text-align:center;box-shadow: 0px 1.5px"> (0.028) </td>
   <td style="text-align:center;box-shadow: 0px 1.5px"> (0.036) </td>
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
   <td style="text-align:center;"> 0.025 </td>
   <td style="text-align:center;"> 0.618 </td>
   <td style="text-align:center;"> 0.017 </td>
   <td style="text-align:center;"> 0.650 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 Adj. </td>
   <td style="text-align:center;"> 0.024 </td>
   <td style="text-align:center;"> 0.257 </td>
   <td style="text-align:center;"> 0.016 </td>
   <td style="text-align:center;"> 0.320 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 Within </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.024 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.010 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 Within Adj. </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.022 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.008 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> AIC </td>
   <td style="text-align:center;"> 1143.3 </td>
   <td style="text-align:center;"> 1167.8 </td>
   <td style="text-align:center;"> 866.2 </td>
   <td style="text-align:center;"> 808.8 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BIC </td>
   <td style="text-align:center;"> 1157.5 </td>
   <td style="text-align:center;"> 3115.7 </td>
   <td style="text-align:center;"> 880.4 </td>
   <td style="text-align:center;"> 2756.7 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> F </td>
   <td style="text-align:center;"> 21.535 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 14.904 </td>
   <td style="text-align:center;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RMSE </td>
   <td style="text-align:center;"> 0.47 </td>
   <td style="text-align:center;"> 0.30 </td>
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

### Graphically
![effects](https://github.com/kssrr/RepeatedEconomicSanctions/assets/121236725/d396d243-212b-4049-822e-96aa03406c13)
