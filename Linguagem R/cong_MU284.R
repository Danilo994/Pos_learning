library(sampling)
data(MU284)
dados=MU284
table(MU284$CL)


set.seed(5)
ACS=cluster(MU284,clustername=c("CL"),size=14,method=c("srswor"))
head(ACS,10)

ACSs=getdata(MU284,ACS)

fix(ACSs)

fpc=rep(50,dim(ACSs)[1])
fpc


library(survey)
PlanoC=svydesign(id=~CL,data=ACSs,probs=~ACS$Prob,fpc=~fpc)
PlanoC

svymean(~P85,PlanoC)
svytotal(~P85,PlanoC)
