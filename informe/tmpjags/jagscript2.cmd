model in "/home/mathi/Desktop/inferencia-tp/informe/caso_1.txt"
data in jagsdata.R
compile, nchains(1)
parameters in jagsinit2.R
initialize
update 1000
monitor set theta1, thin(1)
monitor set theta2, thin(1)
monitor set theta3, thin(1)
monitor set alpha, thin(1)
update 100000
coda *, stem('CODA2')
