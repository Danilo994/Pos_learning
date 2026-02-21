library(sampling)
data("MU284")
table(MU284$REG)

prop.table(table(MU284$REG))
80*prop.table(table(MU284$REG))

set.seed(3)
selec = strata(MU284, stratanames = "REG", size = c(8,14,10,11,16,12,5,9), method = "srswor")
selec
head(selec,10)

selec$Prob
amostra = getdata(MU284, selec)
head(amostra,8)

fpc=rep(c(25,48,32,38,56,41,15,29),c(8,14,10,11,16,12,5,9))
fpc

library(survey)
plano_est = svydesign(id = ~1, strata = ~Stratum, probs = ~selec$Prob, data = amostra, fpc=~fpc)

svymean(~P85, plano_est)
svytotal(~P85, plano_est)

svyby(~P85, by = ~Stratum, design = plano_est, FUN = svymean)
svyby(~P85, by = ~Stratum, design = plano_est, FUN = svytotal)
