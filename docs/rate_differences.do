
clear all

cd "/Users/nabarun/Dropbox/Projects/MME paper/"

// Submitted initial version - for Oct 2020

 input str2 state definition highdose population boundary
"CA" 1 87078 2430870 0
"CA" 2 140822 2430870 0
"CA" 3 86407 2430870 0
"CA" 4 249471 2430870 0
"CA" 1 106240 2430870 1
"CA" 2 155254 2430870 1
"CA" 3 87407 2430870 1
"CA" 4 285807 2430870 1
"FL" 1 87295 1485591 0
"FL" 2 136995 1485591 0
"FL" 3 97346 1485591 0
"FL" 4 211429 1485591 0
"FL" 1 113998 1485591 1
"FL" 2 157794 1485591 1
"FL" 3 98541 1485591 1
"FL" 4 261335 1485591 1
end

// Sensitivity Analysis
	* What impact does including 90.0 have on the proprotion of high dose patients?

ir highdose boundary population, by(definition) level(95)

* Including 90.0 in the “high dose” boundary increased the proportion by 15.4% (95% CI: 15.2%, 15.7%) on average, ranging 1.1% (0.5%, 1.8%) to 26% (25%, 27%) between definitional variations.

program define rd
	di "RD per 1k = " round(r(ird)*1000,.001) " (" round(r(lb_ird)*1000,.001) ", " round(r(ub_ird)*1000,.001) ")"
	di "NNT = " round(1/(r(ird)),.1)
end

* Definition 1
** CA 
	qui: iri 106240 87078 2430870 2430870
	rd
** FL
	qui: iri 113998 87295 1485591 1485591
	rd

* Definition 2
** CA 
	qui: iri 155254 140822 2430870  2430870
	rd
	
** FL
	qui: iri 157794 136995 1485591 1485591
	rd

* Definition 3
** CA 
	qui: iri 87407 86407 2430870  2430870
	rd
	
** FL
	qui: iri 98541 97346 1485591 1485591
	rd

* Definition 4
** CA 
	qui: iri 285807 249471  2430870  2430870
	rd

** FL
	qui: iri 261335 211429 1485591 1485591
	rd
	
// Startified analysis

clear
input str2 state definition avg se population formulation str80 label
"CA" 1 30.3156249 0.1477 2273028 1 "D1. California Sum of days supply"
"CA" 2 31.5819604 0.1479 2273028 1 "D2. California Accounting for overlap days"
"CA" 3 10.3398905 0.0282 2273028 1 "D3. California Defined observation window"
"CA" 4 39.6430507 0.1860 2273028 1 "D4. California Maximum daily dose"
"CA" 1 74.1906194 0.1876 117804 3 "D1. California Sum of days supply"
"CA" 2 143.9839494 0.4413 117804 3 "D2. California Accounting for overlap days"
"CA" 3 122.7372442 0.4328 117804 3 "D3. California Defined observation window"
"CA" 4 250.7462218 0.8219 117804 3 "D4. California Maximum daily dose"
"CA" 1 90.2232825 0.5002 40038 2 "D1. California Sum of days supply"
"CA" 2 103.7573329 0.6715 40038 2 "D2. California Accounting for overlap days"
"CA" 3 72.753132 0.5228 40038 2 "D3. California Defined observation window"
"CA" 4 153.6802569 1.0256 40038 2 "D4. California Maximum daily dose"
"FL" 1 34.0531498 0.0246 1338828 1 "D1. Florida Sum of days supply"
"FL" 2 35.0964146 0.0261 1338828 1 "D2. Florida Accounting for overlap days"
"FL" 3 12.5794512 0.0219 1338828 1 "D3. Florida Defined observation window"
"FL" 4 44.7478467 0.0418 1338828 1 "D4. Florida Maximum daily dose"
"FL" 1 82.95423 0.1703 120724 3  "D1. Florida Sum of days supply"
"FL" 2 160.1525421 0.3788 120724 3 "D2. Florida Accounting for overlap days"
"FL" 3 133.0969773 0.3625 120724 3 "D3. Florida Defined observation window"
"FL" 4 267.949697 0.6850 120724 3 "D4. Florida Maximum daily dose"
"FL" 1 86.9071545 0.5450 26039 2 "D1. Florida Sum of days supply"
"FL" 2 96.9302372 0.6372 26039 2 "D2. Florida Accounting for overlap days"
"FL" 3 66.8367252 0.5028 26039 2 "D3. Florida Defined observation window"
"FL" 4 143.0437107 0.9884 26039 2 "D4. Florida Maximum daily dose"

end




gen pop=population/10000

gen se2=0.5

gen staten=1 if state=="FL"
	replace staten=0 if state=="CA"

sort definition state
	meta set avg se, studylabel(label) studysize(population)

	order definition state

	* Composite
	meta forestplot, fixed subgroup(formulation)  predinterval

	predinterval
	
		meta forestplot if formulation==3, fixed markeropts(mc(black) m(sh)) omarkeropts(mc(gray)) 

	
	
	* Individual for figure
	meta forestplot if formulation==1, random(dlaird) markeropts(mc(black) m(sh)) omarkeropts(mc(gray)) 
			graph export "DL.png", as(png) name("Graph") replace

		meta forestplot if formulation==1, random(dlaird) se(khartung) markeropts(mc(black) m(sh)) omarkeropts(mc(gray)) 

	
	
	noohetstats noohomtest noosigtest noghetstats nogwhomtests nogbhomtests cibind(parent)
		graph export "forest grp 1 IR.png", as(png) name("Graph") replace
		graph export "forest grp 1 IR.eps", as(eps) name("Graph") replace
	meta forestplot if formulation==2, random
		graph export "forest grp 2 ER.png", as(png) name("Graph") replace
		graph export "forest grp 2 IR.eps", as(eps) name("Graph") replace
	meta forestplot if formulation==3, random
		graph export "forest grp 3 ER IR.png", as(png) name("Graph") replace
		graph export "forest grp 3 IR.eps", as(eps) name("Graph") replace

		
		   noohetstats                   suppress overall heterogeneity statistics
    noohomtest                    suppress overall homogeneity test
    noosigtest                    suppress test of significance of overall effect size
    noghetstats                   suppress subgroup heterogeneity statistics
    nogwhomtests                  suppress within-subgroup homogeneity tests
    nogbhomtests    

