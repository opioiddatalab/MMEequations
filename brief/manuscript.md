MME are routinely used in epidemiologic studies of opioid utilization today. The ease of calculation, based solely on arithmetic, coupled with the molecular underpinnings, create an ideal level of cognitive complexity to engender MMEs with an aura of authority. Collectively, MME offer the potential to agglomerate opioid compounds to create a summary metric for population level research and policy, similar to blood alcohol concentrations. However, this approach also obscures nuance between opioid compounds and formulations that may be worth of exploration.

Daily MME thresholds are used to modify care regimens for patients, without explicit formulae for how it is calcualted. For example: "If the incoming claim was greater than the allowed daily MME, or if the incoming claim caused the total daily MME limit to be exceeded, the incoming claim was denied at point of sale...The MME reduction schedule was every 6 months: May 2017 to ≤250 MME/day; November 2017 to ≤200 MME/day, May 2018 to ≤150 MME/day. The next, and probably final, decrease for chronic non-cancer pain beneficiaries receiving an opioid will be November 14, 2018 and the total daily MME allowed limit will be ≤90 MME/day."
[Arkansas Medicaid](https://www.medicaid.gov/Medicaid/Prescription-Drugs/Downloads/Drug-Utilization-Review/DUR-FFS-Reports/AR-DUR-FFY17.pdf)

When used clinically, MME is an instantaneous mesaure used at the point of care, with an understanding of patient context. For example, when switching a patient to another opioid because of side effects, the remaining pills from the discontinued opioid will not be included in the calculation, however, in epidmeiology studies they will be. In this way, epidemiology approaches may overestimate *prescribed* exposure; and may *underestimate* exposure from unsanctioned sources.

# History

To our knowledge, in 2006 the first documented use of morphine equivalents in an epidemiology study was published by [Dasgupta et al.](https://pubmed.ncbi.nlm.nih.gov/16236466-association-between-non-medical-and-prescriptive-usage-of-opioids/), with a comprehensive conversion table assembled from various sources including drug labels. 

Around 2010, Len Paulozzi at the Centers for Disease Control and Prevention (CDC) started circulating annaul [spreadsheets](http://opioiddatalab.github.io/MMEequations/docs/CDC%20NDC%20codes%202010.xlsx) with NDC and equianalgesic potency to researchers via email listservs. This [particular set](https://www.cdc.gov/drugoverdose/pdf/calculating_total_daily_dose-a.pdf) of conversion factors soon became the standard for research studies, but only offered guidance on measuring MME in a single prescription, and did not address overlapping scripts.

In 2016, CDC issued [guidelines](https://www.cdc.gov/mmwr/volumes/65/rr/rr6501e1.htm?CDC_AA_refVal=https%3A%2F%2Fwww.cdc.gov%2Fmmwr%2Fvolumes%2F65%2Frr%2Frr6501e1er.htm) for pain management that included strong cautions for opioid use above an arbitrary MME threshold, thereby suggesting a metric for intervention evaluation and surveillance, still with little regard to how to account for overlapping prescriptions. State laws and insurance policies with MME limits rapidly evolved, invoking the guidelines. Since 2015 there has been rapid increase in the number of publications using MME for epidemiologic studies, however, there is still no standard way for calculating MME in large healthcare datasets. In addition, there is little agreement on how to calculate MME for liquid medicines and non-oral routes of administration. Of the 36 studies cited in the CDC guidelines, 26 used some form of MME calcualtions, of which four provided no explanation of how MME was calculated. 

Yet, that these studies uniformly found increasing risk with exposure, regardless of formula used, demonstrates the fallibility of the existence of a hard threshold for overdose outcomes, as has been [pointed out](https://onlinelibrary.wiley.com/doi/abs/10.1002/pds.4366).

# Problem statement

Consider the following prescriber instructions:<br>
*This month, the patient should take one 30mg ER oxycodone twice-a-day for around-the-clock pain for 30 days, AND one 5mg oxycodone twice a day as needed for breakthrough pain. Both prescriptions are dispensed on the first day of the month.*

<font color='red'> **What is the 30-day average daily MME for this patient?** </font> <br>

**Numerator: total MME for all prescriptions dispensed in 30-days**

`units` x `strength` x `conversion` = <br>
Rx1: 60qty x 30mg x 1.5 = **2700** MME per script<br>
Rx2: 14qty x 5mg x 1.5 = **105** MME per script<br>

${\sum_{i=0}^n M_i}$ = 30-Day Total MME: 2700 + 105 = **2805** <br>

<br>

**What is the correct denominator?** <br>

<font color='red'> 1. Is it the sum of days supply? <br></font>
[literature example](https://opioiddatalab.github.io/MMEequations/MMEequations.html#Equation-1-example)<br><br>
$\cfrac {\sum_{i=0}^n M_i} {\sum_{i=0}^n d_i}$ = $\cfrac{2805 \text{ MME}} {37 \text{ days}} = 76\text{ average daily MME}$ <br><br>
<br>

<font color='red'>2. Is it the total person-days since start of exposure (intent-to-treat)?<br></font>
[literature example](https://opioiddatalab.github.io/MMEequations/MMEequations.html#Equation-2-example)<br><br>
$\cfrac {\sum_{i=0}^n M_i} {max(\text{s+d}) - min(s) + 1}$ = $\cfrac{2805 \text{ MME}} {30 \text{ days}} = 94\text{ average daily MME}$ <br><br>
<br>

<font color='red'>3. Is it the total person-days explicitly exposed, counting overlap days once?<br></font>
[literature example](https://opioiddatalab.github.io/MMEequations/MMEequations.html#Equation-3-example)<br><br>

`Equation TBD` = $\cfrac{2805 \text{ MME}} {30 \text{ days}} = 94\text{ average daily MME}$ <br><br>
<br>
<font size='1'>Both #2 and #3 are 30d in this example but will not always be, e.g., 2 prescriptions separated by days. </font><br><br>

<font color='red'>4. Or, do you average the two?<br></font>
[literature example](https://opioiddatalab.github.io/MMEequations/MMEequations.html#Equation-4-example)<br><br>
$\cfrac{\sum{\cfrac{M_i} {d_i}}} {n}$ = $\cfrac{\cfrac{2700 \text{ MME}} {30 \text{ days}} + \cfrac{105 \text{ MME}} {7 \text{ days}}} {2} = 53\text{ average daily MME}$

The range of possible values for "average daily MME" (53 to 94) represnts 80% variation between the highest and lowest estimates, in this simple scenario, crossing the arbitrary 90 MME/day threshold for "high dose" opioids. When the prescriptions are not overlapping or are staggered, there can be a heightened chance of bias.
