/**************************************************************
Author: Shirong Zhao
Contact: shironz@163.com
Project: UU.S.-China Tension and Corporate Investment: Evidence from China
***************************************************************/


label var auct      "UCT"
label var tq        "TQ"
label var ncf       "CF"
label var sg        "SG"
label var size      "SIZE"
label var gdpg      "GDPG"
label var mvol      "MVOL"
label var std_roa   "STD_ROA"
label var ppe       "IRR"
label var auct_ppe  "UCT*IRR"
label var cod       "COD"
label var coe       "COE"
label var wacc      "WACC"
label var absrinv   "ABSRINV"
label var oinv      "OINV"
label var absruinv  "UINV"
label var acpu      "USCPU"
label define soe_lab 1 "SOE" 0 "Non-SOE"
label define region_lab 1 "Developed" 0 "Less-Developed"
label define tech_lab 1 "TECH" 0 "Non-TECH"
label define high_hhi_lab 1 "High-EXP_DIV" 0 "LOW-EXP_DIV"




***  Summary Statistics  ***
eststo: estpost summarize invest auct ncf gdpg size std_roa tq sg mvol ppe cod coe wacc absrinv oinv absruinv,detail

***  Correlation Matrix ***
pwcorr lead1_invest auct tq ncf sg size gdpg mvol std_roa ppe cod coe wacc absrinv acpu, star(0.05)

***  Effect of UCT on Future Investments  ***
twoway (rarea lci uci lead_q, color(gs14) lwidth(none) legend(label(1 "95% Confidence Interval"))) (line auct_coef lead_q, lcolor(navy) lwidth(medthick) legend(label(2 "UCT Betas"))), xlabel(1(1)8, labsize(small)) ylabel(-0.012(0.002)0.002, labsize(small) format(%9.3f)) xtitle("Quarters into the future", size(medium)) ytitle("UCT Coefficients", size(medium)) legend(order(2 1) pos(6) ring(1) cols(2)) graphregion(color(white)) yline(0, lcolor(black) lpattern(dash)) plotregion(margin(medium)) saving(auct_invest_lead8, replace)

***  U.S.-China Tension and Firm Investment  ***
reghdfe  lead1_invest auct tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y1
reghdfe  lead2_invest auct tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y2
reghdfe  lead3_invest auct tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y3
reghdfe  lead4_invest auct tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y4
esttab y1 y2 y3 y4  using invest.docx, b("%9.4f") star(* 0.1 ** 0.05 *** 0.01) nogap nocompress scalar(N) ar2 replace 

***  U.S.-China Tension, Firm Investment and Investment Irreversibility  ***
reghdfe  lead1_invest  auct_ppe ppe tq ncf sg size , absorb(stkcd yq) vce(cluster stkcd yq)
    est store y1
reghdfe  lead2_invest  auct_ppe ppe tq ncf sg size , absorb(stkcd yq) vce(cluster stkcd yq)
    est store y2
reghdfe  lead3_invest  auct_ppe ppe tq ncf sg size , absorb(stkcd yq) vce(cluster stkcd yq)
    est store y3
reghdfe  lead4_invest  auct_ppe ppe tq ncf sg size , absorb(stkcd yq) vce(cluster stkcd yq)
est store y4
esttab y1 y2 y3 y4  using irr.docx, b("%9.4f") star(* 0.1 ** 0.05 *** 0.01) nogap nocompress scalar(N F p) r2 ar2 replace

***  U.S.-China Tension and Cost of Capital  ***
reghdfe  cod auct tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y1
reghdfe  coe auct tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y2
reghdfe  wacc auct tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y3
esttab y1 y2 y3 using wacc.docx, b("%9.4f") star(* 0.1 ** 0.05 *** 0.01) nogap nocompress scalar(N F p) r2 ar2 replace



***  Cross-Sectional Analysis of the Effects of UCT  ***
reghdfe  lead1_invest auct tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4 if soe==1, absorb(stkcd) vce(cluster stkcd yq)
    est store y1
reghdfe  lead1_invest auct tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4 if soe==0, absorb(stkcd) vce(cluster stkcd yq)
    est store y2
reghdfe  lead1_invest auct tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4 if region==1, absorb(stkcd) vce(cluster stkcd yq)
    est store y3
reghdfe  lead1_invest auct tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4 if region==0, absorb(stkcd) vce(cluster stkcd yq)
    est store y4
reghdfe  lead1_invest auct tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4 if tech ==1, absorb(stkcd) vce(cluster stkcd yq)
    est store y5
reghdfe  lead1_invest auct tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4 if tech ==0, absorb(stkcd) vce(cluster stkcd yq)
    est store y6
esttab y1 y2 y3 y4 y5 y6 using heter.docx,b("%9.4f") star(* 0.1 ** 0.05 *** 0.01) nogap nocompress scalar(N) ar2 replace 

***  U.S.-China Tension, U.S. Export Dependence and Export Market Diversification  ***
reghdfe  lead1_invest auct tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4 if high_hhi==1 , absorb(stkcd) vce(cluster stkcd yq)
    est store y1
reghdfe  lead1_invest auct tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4 if high_hhi==0, absorb(stkcd) vce(cluster stkcd yq)
    est store y2
esttab y1 y2 using Export.tex, b("%9.4f") star(* 0.1 ** 0.05 *** 0.01) nogap nocompress scalar(N) ar2 replace 

***  U.S.-China Tension and Firm Investment Opportunities  ***
reghdfe  lead1_invest auct tq uct_tq ncf size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y1
reghdfe  lead2_invest auct tq uct_tq ncf size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y2
reghdfe  lead3_invest auct tq uct_tq ncf size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y3
reghdfe  lead4_invest auct tq uct_tq ncf size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
	est store y4
esttab y1 y2 y3 y4  using tq.docx, b("%9.4f") star(* 0.1 ** 0.05 *** 0.01) nogap nocompress scalar(N) ar2 replace 

***  U.S.-China Tension and Firm Investment Efficiency  ***
reghdfe  absrinv auct cash tang sg tq ncf size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y
reghdfe oinv auct cash tang sg tq ncf size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y2
reghdfe absruinv auct cash tang tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y3
esttab y1 y2 y3 using eff.docx, b("%9.4f") star(* 0.1 ** 0.05 *** 0.01) nogap nocompress scalar(N) ar2 replace 

*** The Results after Using Instrumental Variable Approach *** 
reghdfe auct acpu tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y1
reghdfe lead1_invest auct_hat tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y2
reghdfe lead2_invest auct_hat tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y3
reghdfe lead3_invest auct_hat tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y4
reghdfe lead4_invest auct_hat tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
est store y5
esttab y1 y2 y3 y4 y5 using iv.tex,b("%9.4f") star(* 0.1 ** 0.05 *** 0.01) nogap nocompress scalar(N) ar2 replace 

*** Cragg-Donald Wald F statistic ***
ivreghdfe lead1_invest tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4 (auct=acpu), absorb(stkcd) vce(cluster stkcd yq)

***  The Results of Robustness Test by Using the Weighted Average of UCT  ***
reghdfe  lead1_invest wuct tq cf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y1
reghdfe  lead2_invest wuct tq cf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y2
reghdfe  lead3_invest wuct tq cf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y3
reghdfe  lead4_invest wuct tq cf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y4
esttab y1 y2 y3 y4  using wuct.docx, b("%9.4f") star(* 0.1 ** 0.05 *** 0.01) nogap nocompress scalar(N F p) r2 ar2 replace

***  The Results of Robustness Test by  by Adding EPU as an Additional Control  ***
reghdfe  lead1_invest auct epu tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y1
reghdfe  lead2_invest auct epu tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y2
reghdfe  lead3_invest auct epu tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y3
reghdfe  lead4_invest auct epu tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y4
esttab y1 y2 y3 y4  using epu.docx, b("%9.4f") star(* 0.1 ** 0.05 *** 0.01) nogap nocompress scalar(N) ar2 replace 

***  The Results of Robustness Test by Using the Pre-2018 Sample Data  ***

drop if year == "2018"|year == "2019"|year == "2020"|year == "2021"|year == "2022"|year == "2023"|year =="2008"|year == "2009"
 by stkcd: gen lead1_invest = invest[_n+1]
 by stkcd: gen lead2_invest = invest[_n+2]
 by stkcd: gen lead3_invest = invest[_n+3]
 by stkcd: gen lead4_invest = invest[_n+4]
 
reghdfe  lead1_invest auct tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y1
reghdfe  lead2_invest auct tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y2
reghdfe  lead3_invest auct tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y3
reghdfe  lead4_invest auct tq ncf sg size gdpg mvol std_roa quarter_dummy2-quarter_dummy4, absorb(stkcd) vce(cluster stkcd yq)
    est store y4
esttab y1 y2 y3 y4  using pre18.docx, b("%9.4f") star(* 0.1 ** 0.05 *** 0.01) nogap nocompress scalar(N) ar2 replace 


