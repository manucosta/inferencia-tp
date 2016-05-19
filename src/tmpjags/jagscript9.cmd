model in "/home/mjcosta/Documentos/Inferencia/inferencia-tp/src/caso_1.txt"
data in jagsdata.R
compile, nchains(1)
parameters in jagsinit9.R
initialize
update 100
monitor set theta1, thin(1)
monitor set theta2, thin(1)
monitor set theta3, thin(1)
monitor set alpha, thin(1)
update 10000
coda *, stem('CODA9')
