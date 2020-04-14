# Envolutionary Genomics - Positive selection - Likelihood ratio test

m1a = -2371.340901
m2a = -2370.569786

lrt <- -2*(m1a - m2a)
pchisq(lrt, df=2, lower.tail=F)

a1null = -2371.340911
a1alt = -2370.155507

lrt <- -2*(a1null - a1alt)
pchisq(lrt, df=1, lower.tail=F)


./PhyML_3.0_win32.exe -i Clownfish_rh1.phy -q -m HKY85 -a 1000 -v 0 -o lr --inputtree clownfish_rh1.phy_phyml_tree.txt --run_id HKY85