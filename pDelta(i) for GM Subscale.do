

*GM



* gen variables holding info needed for denominator
foreach var of varlist S*YPI_GM {
quietly sum `var'
quietly gen sd`var'=`r(sd)'
}
capture gen alpha1=.91
capture gen alpha2=.92
capture gen alpha3=.91
capture gen alpha4=.91
capture gen alpha5=.92
capture gen alpha6=.91
capture gen alpha7=.92



* calculate the RCI for each wave-to-wave comparison

* w2-w1
gen SGM_RCI2_1=(S2YPI_GM-S1YPI_GM)/sqrt([sdS2YPI_GM*sqrt(1-alpha2)]^2+[sdS1YPI_GM*sqrt(1-alpha1)]^2)
sum SGM_RCI2_1, d

* w3-w2
gen SGM_RCI3_2=(S3YPI_GM-S2YPI_GM)/sqrt([sdS3YPI_GM*sqrt(1-alpha3)]^2+[sdS2YPI_GM*sqrt(1-alpha2)]^2)
sum SGM_RCI3_2, d

* w4-w3
gen SGM_RCI4_3=(S4YPI_GM-S3YPI_GM)/sqrt([sdS4YPI_GM*sqrt(1-alpha4)]^2+[sdS3YPI_GM*sqrt(1-alpha3)]^2)
sum SGM_RCI4_3, d

* w5-w4
gen SGM_RCI5_4=(S5YPI_GM-S4YPI_GM)/sqrt([sdS5YPI_GM*sqrt(1-alpha5)]^2+[sdS4YPI_GM*sqrt(1-alpha4)]^2)
sum SGM_RCI5_4, d

* w6-w5
gen SGM_RCI6_5=(S6YPI_GM-S5YPI_GM)/sqrt([sdS6YPI_GM*sqrt(1-alpha6)]^2+[sdS5YPI_GM*sqrt(1-alpha5)]^2)
sum SGM_RCI6_5, d

* w7-w6
gen SGM_RCI7_6=(S7YPI_GM-S6YPI_GM)/sqrt([sdS7YPI_GM*sqrt(1-alpha7)]^2+[sdS6YPI_GM*sqrt(1-alpha6)]^2)
sum SGM_RCI7_6, d




* calculate the RCI YPI RANK SCORES for each wave-to-wave comparison

foreach var of varlist R*YPI_GM {
quietly sum `var'
quietly gen sd`var'=`r(sd)'
}




*w2-w1
gen RGM_RCI2_1=(R2YPI_GM-R1YPI_GM)/sqrt([sdR2YPI_GM*sqrt(1-alpha2)]^2+[sdR1YPI_GM*sqrt(1-alpha1)]^2)
sum RGM_RCI2_1, d

* w3-w2
gen RGM_RCI3_2=(R3YPI_GM-R2YPI_GM)/sqrt([sdR3YPI_GM*sqrt(1-alpha3)]^2+[sdR2YPI_GM*sqrt(1-alpha2)]^2)
sum RGM_RCI3_2, d

* w4-w3
gen RGM_RCI4_3=(R4YPI_GM-R3YPI_GM)/sqrt([sdR4YPI_GM*sqrt(1-alpha4)]^2+[sdR3YPI_GM*sqrt(1-alpha3)]^2)
sum RGM_RCI4_3, d

* w5-w4
gen RGM_RCI5_4=(R5YPI_GM-R4YPI_GM)/sqrt([sdR5YPI_GM*sqrt(1-alpha5)]^2+[sdR4YPI_GM*sqrt(1-alpha4)]^2)
sum RGM_RCI5_4, d

* w6-w5
gen RGM_RCI6_5=(R6YPI_GM-R5YPI_GM)/sqrt([sdR6YPI_GM*sqrt(1-alpha6)]^2+[sdR5YPI_GM*sqrt(1-alpha5)]^2)
sum RGM_RCI6_5, d

* w7-w6
gen RGM_RCI7_6=(R7YPI_GM-R6YPI_GM)/sqrt([sdR7YPI_GM*sqrt(1-alpha7)]^2+[sdR6YPI_GM*sqrt(1-alpha6)]^2)
sum RGM_RCI7_6, d






*RCI GM RAW CATEGORIES.

foreach var of varlist SGM_RCI2_1 - SGM_RCI7_6 {
quietly gen `var'reliableChange=2
}

* "tag" reliable changes for case 1
foreach var of varlist SGM_RCI2_1 - SGM_RCI7_6 {
replace `var'reliableChange=3 if `var' >=(1.96) 
} 

* "tag" reliable changes for case 2
foreach var of varlist SGM_RCI2_1 - SGM_RCI7_6 {
replace `var'reliableChange=1 if `var' <=(-1.96) 
} 



*RCI GM RANK CATEGORIES.


foreach var of varlist RGM_RCI2_1 - RGM_RCI7_6 {
quietly gen `var'reliableChange=2
}

* "tag" reliable changes for case 1
foreach var of varlist RGM_RCI2_1 - RGM_RCI7_6 {
replace `var'reliableChange=3 if `var' >=(1.96) 
} 

* "tag" reliable changes for case 2
foreach var of varlist RGM_RCI2_1 - RGM_RCI7_6 {
replace `var'reliableChange=1 if `var' <=(-1.96) 
} 
