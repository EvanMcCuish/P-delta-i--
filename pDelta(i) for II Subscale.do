*'S' IS USED TO IDENTIFY RAW SCORE, 'R' IS USED TO IDENTIFY RANK ORDER SCORE

* -------------------------
* Christensen & Mendoza's RCI
* where RCI = (t2-t1)/sdiff
* note, numerator is the diff in score between two measurement periods
* denominator is standard error of measurement (SEM), 
* which accounts for measurement error (i.e., alpha reliability)
* -------------------------




*II




* gen variables holding info needed for denominator
foreach var of varlist S*YPI_II {
quietly sum `var'
quietly gen sd`var'=`r(sd)'
}
capture gen alpha1=.83
capture gen alpha2=.85
capture gen alpha3=.84
capture gen alpha4=.85
capture gen alpha5=.86
capture gen alpha6=.86
capture gen alpha7=.87



* calculate the RCI for each wave-to-wave comparison (raw score)

* w2-w1
gen SII_RCI2_1=(S2YPI_II-S1YPI_II)/sqrt([sdS2YPI_II*sqrt(1-alpha2)]^2+[sdS1YPI_II*sqrt(1-alpha1)]^2)
sum SII_RCI2_1, d

* w3-w2
gen SII_RCI3_2=(S3YPI_II-S2YPI_II)/sqrt([sdS3YPI_II*sqrt(1-alpha3)]^2+[sdS2YPI_II*sqrt(1-alpha2)]^2)
sum SII_RCI3_2, d

* w4-w3
gen SII_RCI4_3=(S4YPI_II-S3YPI_II)/sqrt([sdS4YPI_II*sqrt(1-alpha4)]^2+[sdS3YPI_II*sqrt(1-alpha3)]^2)
sum SII_RCI4_3, d

* w5-w4
gen SII_RCI5_4=(S5YPI_II-S4YPI_II)/sqrt([sdS5YPI_II*sqrt(1-alpha5)]^2+[sdS4YPI_II*sqrt(1-alpha4)]^2)
sum SII_RCI5_4, d

* w6-w5
gen SII_RCI6_5=(S6YPI_II-S5YPI_II)/sqrt([sdS6YPI_II*sqrt(1-alpha6)]^2+[sdS5YPI_II*sqrt(1-alpha5)]^2)
sum SII_RCI6_5, d

* w7-w6
gen SII_RCI7_6=(S7YPI_II-S6YPI_II)/sqrt([sdS7YPI_II*sqrt(1-alpha7)]^2+[sdS6YPI_II*sqrt(1-alpha6)]^2)
sum SII_RCI7_6, d




* calculate the RCI for each wave-to-wave comparison (rank score)


* gen variables holding info needed for denominator
foreach var of varlist R*YPI_II {
quietly sum `var'
quietly gen sd`var'=`r(sd)'
}


*w2-w1
gen RII_RCI2_1=(R2YPI_II-R1YPI_II)/sqrt([sdR2YPI_II*sqrt(1-alpha2)]^2+[sdR1YPI_II*sqrt(1-alpha1)]^2)
sum RII_RCI2_1, d

* w3-w2
gen RII_RCI3_2=(R3YPI_II-R2YPI_II)/sqrt([sdR3YPI_II*sqrt(1-alpha3)]^2+[sdR2YPI_II*sqrt(1-alpha2)]^2)
sum RII_RCI3_2, d

* w4-w3
gen RII_RCI4_3=(R4YPI_II-R3YPI_II)/sqrt([sdR4YPI_II*sqrt(1-alpha4)]^2+[sdR3YPI_II*sqrt(1-alpha3)]^2)
sum RII_RCI4_3, d

* w5-w4
gen RII_RCI5_4=(R5YPI_II-R4YPI_II)/sqrt([sdR5YPI_II*sqrt(1-alpha5)]^2+[sdR4YPI_II*sqrt(1-alpha4)]^2)
sum RII_RCI5_4, d

* w6-w5
gen RII_RCI6_5=(R6YPI_II-R5YPI_II)/sqrt([sdR6YPI_II*sqrt(1-alpha6)]^2+[sdR5YPI_II*sqrt(1-alpha5)]^2)
sum RII_RCI6_5, d

* w7-w6
gen RII_RCI7_6=(R7YPI_II-R6YPI_II)/sqrt([sdR7YPI_II*sqrt(1-alpha7)]^2+[sdR6YPI_II*sqrt(1-alpha6)]^2)
sum RII_RCI7_6, d





*RCI II RAW CATEGORIES.

foreach var of varlist SII_RCI2_1 - SII_RCI7_6 {
quietly gen `var'reliableChange=2
}

* "tag" reliable changes for case 1
foreach var of varlist SII_RCI2_1 - SII_RCI7_6 {
replace `var'reliableChange=3 if `var' >=(1.96) 
} 

* "tag" reliable changes for case 2
foreach var of varlist SII_RCI2_1 - SII_RCI7_6 {
replace `var'reliableChange=1 if `var' <=(-1.96) 
}

*RCI II RANK CATEGORIES.

foreach var of varlist RII_RCI2_1 - RII_RCI7_6 {
quietly gen `var'reliableChange=2
}

* "tag" reliable changes for case 1
foreach var of varlist RII_RCI2_1 - RII_RCI7_6 {
replace `var'reliableChange=3 if `var' >=(1.96) 
} 

* "tag" reliable changes for case 2
foreach var of varlist RII_RCI2_1 - RII_RCI7_6 {
replace `var'reliableChange=1 if `var' <=(-1.96) 
} 
