
a1= 0.5;b1=8;c1=7;

a2= 0.5;b2=15;c2=3;

cost = @(t,n,a,b,c) ((a + b/1000.* t).*round(n,2)).^(1 + 2/(c.*1000).*t);
costVanilla = @(t,n) cost(t,n,a1,b1,c1);
costModified = @(t,n) cost(t,n,a2,b2,c2);

turn_range=0:600;
n=20;
tiledlayout(1,2)
nexttile
figure(1)

plot(turn_range,[costVanilla(turn_range,n);costModified(turn_range,n)])

grid on
xlabel("Turn(Assuming Standard Speed)");
ylabel("GPT cost per unit");
title("((a + b/1000* t)*round(n,2))^{(1 + 2/(c.*1000)*t)}")
%yticks(0:5:200)
legend([sprintf("Vanilla Cost (a=%d,b=%d,c=%d)",[a1,b1,c1]),sprintf("Revamped Cost (a=%d,b=%d,c=%d)",[a2,b2,c2])])

%figure(2)
nexttile
Y=costModified(turn_range,n)./costVanilla(turn_range,n);
plot(turn_range,Y);
title("Relative cost multiplier by turn")
ylim([0,ceil(Y(end))]);
grid on
%yticks(1:1:12);
xlabel("Turn(Assuming Standard Speed)");

[turn_range',Y']
