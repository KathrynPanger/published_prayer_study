version 12.1
set more off
capture log close
log using prayer_analysis.log, replace

use C:\Users\Administrator\Documents\1996.a.dta, clear


///dropping all observations that could not recall///
///angry event (filter question)///

drop if angryev==.i
drop if angryev==.d
drop if angryev==2

///DV:managing anger through prayer///
recode chnang7 1=1 2=0, gen(pray_anger)
label define pray_anger 1 "Yes" 0 "No"
label value pray_anger pray_anger

///recoding demographic variables///

///sex///
recode sex 1=0 2=1, gen(sex_recode)
label define sex_recode 0 "male" 1 "female"
label value sex_recode sex_recode

///race///
recode race 1=0 2 3=1, gen(race_recode)
label define race_recode 0 "white" 1 "non-white"
label value race_recode race_recode

///education///
recode degree 1 2 3=1 4 5=0, gen(college)
label define college 0 "college" 1 "no college"
label value college college 

///region///
recode region 1 2 3 4 8 9=0 5 6 7=1, gen(south)
label define south 0 "non-south" 1 "south"
label value south south

///marital status///
recode marital 1=1 2=2 3 4=3 5=4, gen (marital_recode)
label define marital_recode 1 "married" 2 "widowed" ///
3 "divorced/separated" 4 "single"
label value marital_recode marital_recode

///parent///
recode childs 0=0 1 2 3 4 5 6 7 8=1, gen(parent)
label define parent 0 "non-parent" 1 "parent"
label value parent parent

///age centered///
gen age_centered = age - 43

///religion variables///

///attendance(attend) will be treated as continous///

///fundalmentalism///
recode fund 1=1 2 3=0, gen(fund_recode)
label define fund_recode 0 "non-fundalmentalist" 1 "fundamentalist"
label value fund_recode fund_recode

///frequency of prayer///
recode pray 1 2=1 3 4 5 6=0, gen(pray_recode)
label define pray_recode 1 ">=once a day" 0 "<once a day"
label value pray_recode pray_recode

///religious affiliation///
gen xaffil=relig 
recode xaffil 1=1 2=4 3=5 4=9 5/10=6 11=1 12=6 13=1 *=. 
label def xaffil 1 prot 4 cath 5 jew 6 other 9 nonaf 
label values xaffil xaffil 
gen xbp=other 
recode xbp 7 14 15 21 37 38 56 78 79 85 86 87 88 98 103 ///
104 128 133=1 *=0 
recode xbp 0=1 if denom==12 
recode xbp 0=1 if denom==13 
recode xbp 0=1 if denom==20 
recode xbp 0=1 if denom==21 
gen bl=race 
recode bl 2=1 *=0 
gen bldenom=denom*bl 
recode xbp 0=1 if bldenom==23 
recode xbp 0=1 if bldenom==28 
recode xbp 0=1 if bldenom==18 
recode xbp 0=1 if bldenom==15 
recode xbp 0=1 if bldenom==10 
recode xbp 0=1 if bldenom==11 
recode xbp 0=1 if bldenom==14 
gen blother=other*bl 
recode xbp 0=1 if blother==93 
gen xev=other 
recode xev 2 3 5 6 9 10 12 13 16 18 20 22 24 26 27 28 ///
31 32 34 35 36 39 41 42 43 45 47 51 52 53 55 57 63 65 ///
66 67 68 69 76 77 83 84 90 91 92 94 97 100 101 102 ///
106 107 108 109 110 111 112 115 116 117 118 120 121 ///
122 124 125 127 129 131 132 134 135 138 ///
139 140 146=1 *=0
recode xev 0=1 if denom==32 
recode xev 0=1 if denom==33 
recode xev 0=1 if denom==34 
recode xev 0=1 if denom==42 
gen wh=race 
recode wh 1=1 2=0 3=1 
gen whdenom=denom*wh 
recode xev 0=1 if whdenom==23 
recode xev 0=1 if whdenom==18 
recode xev 0=1 if whdenom==15 
recode xev 0=1 if whdenom==10 
recode xev 0=1 if whdenom==14 
gen whother=other*wh 
recode xev 0=1 if whother==93 
recode xev 1=0 if xbp==1 
gen xml=other 
recode xml 1 8 19 23 25 40 44 46 48 49 50 54 70 71 ///
72 73 81 89 96 99 105 119 148=1 *=0 
recode xml 0=1 if denom==22 
recode xml 0=1 if denom==30 
recode xml 0=1 if denom==31 
recode xml 0=1 if denom==35 
recode xml 0=1 if denom==38 
recode xml 0=1 if denom==40 
recode xml 0=1 if denom==41 
recode xml 0=1 if denom==43 
recode xml 0=1 if denom==48 
recode xml 0=1 if denom==50 
recode xml 0=1 if whdenom==11 
recode xml 0=1 if whdenom==28 
gen xcath=other 
recode xcath 123=1 *=0 
recode xcath 0=1 if xaffil==4 
gen xjew=0 
recode xjew 0=1 if xaffil==5 
gen xother=other  
recode xother 11 17 29 30 33 58 59 60 61 62 64 74 75 ///
80 82 95 113 114 130 136 141 145=1 *=0 
gen noxev=1-xev 
gen noxevxaf=noxev*xaffil 
recode xother 0=1 if noxevxaf==6 
gen xnonaff=xaffil 
recode xnonaff 9=1 *=0 
gen xprotdk=denom 
recode xprotdk 70=1 *=0 
recode xprotdk 1=0 if attend==0 
recode xprotdk 1=0 if attend==1 
recode xprotdk 1=0 if attend==2 
recode xprotdk 1=0 if attend==3 
recode xprotdk 1=0 if attend==9 
recode xprotdk 1=0 if attend==. 
recode xev 0=1 if xprotdk==1 
gen reltrad=0 
recode reltrad 0=7 if xnonaf==1 
recode reltrad 0=6 if xother==1 
recode reltrad 0=5 if xjew==1 
recode reltrad 0=4 if xcath==1 
recode reltrad 0=3 if xbp==1 
recode reltrad 0=2 if xml==1 
recode reltrad 0=1 if xev==1 
recode reltrad 0=.  
label def reltrad 1 "evangelical" ///
2 "mainline" 3 "black protestant" 4 "catholic" ///
5 "jewish" 6 "other faith" 7 "nonaffiliated" 
label values reltrad reltrad

///anger variables///

///intensity of anger (howangry) will be continuous///

///source of anger///
gen angryfamily=0
recode angryfamily 0=1 if madat1==1
recode angryfamily 0=1 if madat2==1
recode angryfamily 0=1 if madat3==1
recode angryfamily 0=1 if madat4==1
recode angryfamily 0=1 if madat5==1
recode angryfamily 0=1 if madat6==1
recode angryfamily 0=1 if madat7==1
recode angryfamily 0=1 if madat8==1
recode angryfamily 0=1 if madat23==1
recode angryfamily 0=1 if madat23==2

gen angryfriend=0
recode angryfriend 0=1 if madat9==1
recode angryfriend 0=1 if madat10==1
recode angryfriend 0=1 if madat11==1

gen angrywork=0
recode angrywork 0=1 if madat12==1
recode angrywork 0=1 if madat13==1
recode angrywork 0=1 if madat14==1
recode angrywork 0=1 if madat15==1
recode angrywork 0=1 if madat16==1

gen angryself=0
recode angryself 0=1 if madat21==1

gen angryother=0
recode angryother 0=1 if madat17==1
recode angryother 0=1 if madat18==1
recode angryother 0=1 if madat19==1
recode angryother 0=1 if madat20==1
recode angryother 0=1 if madat22==1
recode angryother 0=1 if madat23==3
recode angryother 0=1 if madat23==4
recode angryother 0=1 if madat23==5 
recode angryother 0=1 if madat23==6 
recode angryother 0=1 if madat23==7
recode angryother 0=1 if madat23==8

gen angrysource=0
recode angrysource 0=1 if angryfamily==1
recode angrysource 0=2 if angryfriend==1
recode angrysource 0=3 if angrywork==1
recode angrysource 0=4 if angryself==1
recode angrysource 0=5 if angryother==1
recode angrysource 0=. if madat23==.n
label define angrysource 1 "family" 2 "friend" ///
3 "work" 4 "self" 5 "other"
label value angrysource angrysource

///Interactions///
generate sexage = sex_recode * age_centered
generate sexrace = sex_recode * race_recode
generate sexcollege = sex_recode * college
generate sexregion = sex_recode * south
generate sexmarital = sex_recode * marital_recode
generate sexparent = sex_recode * parent
generate sexfund = sex_recode * fund_recode
generate sexpray = sex_recode * pray_recode
generate sexreligion = sex_recode * reltrad
generate sexattend = sex_recode * attend
generate sexhowangry = sex_recode * howangry
generate sexangrysource = sex_recode * angrysource

generate raceage = race_recode * age_centered
generate racecollege = race_recode * age_centered
generate raceregion = race_recode * south
generate racemarital = race_recode * marital_recode
generate raceparent = race_recode * parent
generate racefund = race_recode * fund_recode
generate racepray = race_recode * pray_recode
generate racereligion = race_recode * reltrad
generate raceattend = race_recode * attend
generate racehowangry = race_recode * howangry
generate raceangrysource = race_recode * angrysource

generate collegeage = college * age_centered
generate collegeregion = college * south
generate collegemarital = college * marital_recode
generate collegeparent = college * parent
generate collegefund = college * fund_recode
generate collegepray = college * pray_recode
generate collegereligion = college * reltrad
generate collegeattend = college * attend
generate collegehowangry = college * howangry
generate collegeangrysource = college * angrysource

generate ageregion = age_centered * south
generate agemarital = age_centered * marital_recode
generate ageparent = age_centered * parent
generate agefund = age_centered * fund_recode
generate agepray = age_centered * pray_recode
generate agereligion = age_centered * reltrad
generate ageattend = age_centered * attend
generate agehowangry = age_centered * howangry
generate ageangrysource = age_centered * angrysource

generate regionmarital = south * marital_recode
generate regionparent = south * parent
generate regionfund = south * fund_recode
generate regionpray = south * pray_recode
generate regionreligion = south * reltrad
generate regionattend = south * attend
generate regionhowangry = south * howangry
generate regionangrysource = south * angrysource

generate maritalparent = marital_recode * parent
generate maritalfund = marital_recode * fund_recode
generate maritalpray = marital_recode * pray_recode
generate maritalreligion = marital_recode * reltrad
generate maritalattend = marital_recode * attend
generate maritalhowangry = marital_recode * howangry
generate maritalangrysource = marital_recode * angrysource

generate parentfund = parent * fund_recode
generate parentpray = parent * pray_recode
generate parentreligion = parent * reltrad
generate parentattend = parent * attend
generate parenthowangry = parent * howangry
generate parentangrysource = parent * angrysource

generate fundpray = fund_recode * pray_recode
generate fundreligion = fund_recode * reltrad
generate fundattend = fund_recode * attend
generate fundhowangry = fund_recode * howangry
generate fundangrysource = fund_recode * angrysource

generate prayreligion = pray_recode * reltrad
generate prayattend = pray_recode * attend
generate prayhowangry = pray_recode * howangry
generate prayangrysource = pray_recode * angrysource

generate religionattend = reltrad * attend
generate religionhowangry = reltrad * howangry
generate religionangrysource = reltrad * angrysource

generate attendhowangry = attend * howangry
generate attendangrysource = attend * angrysource

generate howangryangrysource = howangry * angrysource


recode pray_anger .n=.
recode howangry .n=.
recode howangry .d=.
recode attend .d=.
recode pray_recode .d=.
recode pray_recode .i=.
recode pray_recode .n=.
recode fund_recode .n=.
recode parent .d=.
recode college .n=.
recode marital_recode .n=.

gen original_dv=(pray_anger<.)

ice m.pray_anger i.sex_recode i.race_recode college ///
age_centered i.south m.marital_recode m.parent ///
m.fund_recode m.pray_recode m.reltrad attend howangry ///
m.angrysource, gen(m_) saving(prayer_imputation) m(30) ///
seed(1979)

use C:\Users\Administrator\Documents\prayer_imputation, clear

mi import flong, m(_mj) id(_mi) ///
imputed(pray_anger sex_recode race_recode age_centered ///
marital_recode south parent fund_recode pray_recode ///
reltrad attend howangry angrysource)

mi describe

mi estimate, or:  logit pray_anger sex_recode race_recode ///
college age_centered south i.marital parent ///

mi estimate, or: logit pray_anger sex_recode race_recode ///
college age_centered south i.marital parent if original_dv ///

mi estimate, or: logit pray_anger sex_recode race_recode ///
college age_centered south i.marital parent fund_recode ///
pray_recode reltrad attend if original_dv

mi estimate, or: logit pray_anger sex_recode race_recode ///
college age_centered south i.marital parent fund_recode ///
pray_recode i.reltrad attend howangry if original_dv

mi estimate, or: logit pray_anger sex_recode race_recode ///
college age_centered south i.marital parent fund_recode ///
pray_recode i.reltrad attend i.angrysource if original_dv

mi estimate, or: logit pray_anger sex_recode race_recode ///
college age_centered south i.marital parent fund_recode ///
pray_recode i.reltrad attend howangry ///
i.angrysource if original_dv

mi estimate, or: logit pray_anger sex_recode race_recode ///
college age_centered south i.marital parent fund_recode ///
pray_recode i.reltrad attend howangry ///
i.angrysource if original_dv

mi estimate, or: logit pray_anger sex_recode race_recode ///
college age_centered south i.marital parent fund_recode ///
pray_recode i.reltrad attend howangry ///
i.angrysource sexage if original_dv

mi estimate, or: logit pray_anger sex_recode race_recode ///
college age_centered south i.marital parent fund_recode ///
pray_recode i.reltrad attend howangry ///
i.angrysource sexrace if original_dv

mi estimate, or: logit pray_anger sex_recode race_recode ///
college age_centered south i.marital parent fund_recode ///
pray_recode i.reltrad attend howangry ///
i.angrysource sexcollege if original_dv

mi estimate, or: logit pray_anger sex_recode race_recode ///
college age_centered south i.marital parent fund_recode ///
pray_recode i.reltrad attend howangry ///
i.angrysource sexregion if original_dv

mi estimate, or: logit pray_anger sex_recode race_recode ///
college age_centered south i.marital parent fund_recode ///
pray_recode i.reltrad attend howangry ///
i.angrysource i.sexmarital if original_dv

mi estimate, or: logit pray_anger sex_recode race_recode ///
college age_centered south i.marital parent fund_recode ///
pray_recode i.reltrad attend howangry ///
i.angrysource sexparent if original_dv

mi estimate, or: logit pray_anger sex_recode race_recode ///
college age_centered south i.marital parent fund_recode ///
pray_recode i.reltrad attend howangry ///
i.angrysource sexfund original_dv

mi estimate, or: logit pray_anger sex_recode race_recode ///
college age_centered south i.marital parent fund_recode ///
pray_recode i.reltrad attend howangry ///
i.angrysource sexpray if original_dv

mi estimate, or: logit pray_anger sex_recode race_recode ///
college age_centered south i.marital parent fund_recode ///
pray_recode i.reltrad attend howangry ///
i.angrysource i.sexreligion if original_dv

mi estimate, or: logit pray_anger sex_recode race_recode ///
college age_centered south i.marital parent fund_recode ///
pray_recode i.reltrad attend howangry ///
i.angrysource sexattend if original_dv

mi estimate, or: logit pray_anger sex_recode race_recode ///
college age_centered south i.marital parent fund_recode ///
pray_recode i.reltrad attend howangry ///
i.angrysource sexhowangry if original_dv

mi estimate, or: logit pray_anger sex_recode race_recode ///
college age_centered south i.marital parent fund_recode ///
pray_recode i.reltrad attend howangry ///
i.angrysource i.sexangrysource if original_dv

mi estimate, dftable
mi estimate, vartable nocitable

log close
exit

*this is a test of my ability to commit to git*