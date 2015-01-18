function PX = Probability_of_X(X,Means,Variances,PC)
PX = 0.0;
[r,c] = size(Means);
for i=1:c
    PX = PX + PC(i)*Mixing_Coefficient(X,Means(:,i), Variances(:,i));
end;