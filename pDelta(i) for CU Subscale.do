*'S' IS USED TO IDENTIFY RAW SCORE, 'R' IS USED TO IDENTIFY RANK ORDER SCORE

* -------------------------
* Christensen & Mendoza's RCI
* where RCI = (t2-t1)/sdiff
* note, numerator is the diff in score between two measurement periods
* denominator is standard error of measurement (SEM), 
* which accounts for measurement error (i.e., alpha reliability)
* -------------------------




*CU


* gen variables holding info needed for denominator
foreach var of varlist S*YPI_CU {
quietly sum `var'
quietly gen sd`var'=`r(sd)'
}
capture gen alpha1=.73
capture gen alpha2=.77
capture gen alpha3=.76
capture gen alpha4=.77
capture gen alpha5=.79
capture gen alpha6=.79
capture gen alpha7=.78



* calculate the RCI for each wave-to-wave comparison (RAW SCORES)

* w2-w1
gen SCU_RCI2_1=(S2YPI_CU-S1YPI_CU)/sqrt([sdS2YPI_CU*sqrt(1-alpha2)]^2+[sdS1YPI_CU*sqrt(1-alpha1)]^2)
sum SCU_RCI2_1, d

* w3-w2
gen SCU_RCI3_2=(S3YPI_CU-S2YPI_CU)/sqrt([sdS3YPI_CU*sqrt(1-alpha3)]^2+[sdS2YPI_CU*sqrt(1-alpha2)]^2)
sum SCU_RCI3_2, d

* w4-w3
gen SCU_RCI4_3=(S4YPI_CU-S3YPI_CU)/sqrt([sdS4YPI_CU*sqrt(1-alpha4)]^2+[sdS3YPI_CU*sqrt(1-alpha3)]^2)
sum SCU_RCI4_3, d

* w5-w4
gen SCU_RCI5_4=(S5YPI_CU-S4YPI_CU)/sqrt([sdS5YPI_CU*sqrt(1-alpha5)]^2+[sdS4YPI_CU*sqrt(1-alpha4)]^2)
sum SCU_RCI5_4, d

* w6-w5
gen SCU_RCI6_5=(S6YPI_CU-S5YPI_CU)/sqrt([sdS6YPI_CU*sqrt(1-alpha6)]^2+[sdS5YPI_CU*sqrt(1-alpha5)]^2)
sum SCU_RCI6_5, d

* w7-w6
gen SCU_RCI7_6=(S7YPI_CU-S6YPI_CU)/sqrt([sdS7YPI_CU*sqrt(1-alpha7)]^2+[sdS6YPI_CU*sqrt(1-alpha6)]^2)
sum SCU_RCI7_6, d



* calculate the RCI for each wave-to-wave comparison (RANK SCORES)

* gen variables holding info needed for denominator
foreach var of varlist R*YPI_CU {
quietly sum `var'
quietly gen sd`var'=`r(sd)'
}


*w2-w1
gen RCU_RCI2_1=(R2YPI_CU-R1YPI_CU)/sqrt([sdR2YPI_CU*sqrt(1-alpha2)]^2+[sdR1YPI_CU*sqrt(1-alpha1)]^2)
sum RCU_RCI2_1, d

* w3-w2
gen RCU_RCI3_2=(R3YPI_CU-R2YPI_CU)/sqrt([sdR3YPI_CU*sqrt(1-alpha3)]^2+[sdR2YPI_CU*sqrt(1-alpha2)]^2)
sum RCU_RCI3_2, d

* w4-w3
gen RCU_RCI4_3=(R4YPI_CU-R3YPI_CU)/sqrt([sdR4YPI_CU*sqrt(1-alpha4)]^2+[sdR3YPI_CU*sqrt(1-alpha3)]^2)
sum RCU_RCI4_3, d

* w5-w4
gen RCU_RCI5_4=(R5YPI_CU-R4YPI_CU)/sqrt([sdR5YPI_CU*sqrt(1-alpha5)]^2+[sdR4YPI_CU*sqrt(1-alpha4)]^2)
sum RCU_RCI5_4, d

* w6-w5
gen RCU_RCI6_5=(R6YPI_CU-R5YPI_CU)/sqrt([sdR6YPI_CU*sqrt(1-alpha6)]^2+[sdR5YPI_CU*sqrt(1-alpha5)]^2)
sum RCU_RCI6_5, d

* w7-w6
gen RCU_RCI7_6=(R7YPI_CU-R6YPI_CU)/sqrt([sdR7YPI_CU*sqrt(1-alpha7)]^2+[sdR6YPI_CU*sqrt(1-alpha6)]^2)
sum RCU_RCI7_6, d






*RCI CU RAW CATEGORIES.


foreach var of varlist SCU_RCI2_1 - SCU_RCI7_6 {
quietly gen `var'reliableChange=2
}

* "tag" reliable changes for case 1
foreach var of varlist SCU_RCI2_1 - SCU_RCI7_6 {
replace `var'reliableChange=3 if `var' >=(1.96) 
} 

* "tag" reliable changes for case 2
foreach var of varlist SCU_RCI2_1 - SCU_RCI7_6 {
replace `var'reliableChange=1 if `var' <=(-1.96) 
} 



*RCI CU RANK CATEGORIES.


foreach var of varlist RCU_RCI2_1 - RCU_RCI7_6 {
quietly gen `var'reliableChange=2
}

* "tag" reliable changes for case 1
foreach var of varlist RCU_RCI2_1 - RCU_RCI7_6 {
replace `var'reliableChange=3 if `var' >=(1.96) 
} 

* "tag" reliable changes for case 2
foreach var of varlist RCU_RCI2_1 - RCU_RCI7_6 {
replace `var'reliableChange=1 if `var' <=(-1.96) 
} 


