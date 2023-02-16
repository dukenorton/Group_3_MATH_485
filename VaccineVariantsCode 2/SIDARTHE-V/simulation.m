%%%% initialization %%%%

xcur=[200 20 1 2 0]'/60000000;
x=xcur;
L=[-r1(1)+alpha(1)+x(2)/x(1)*beta(1)+x(3)/x(1)*gamma(1)+x(4)/x(1)*delta(1);
    x(1)/x(2)*epsilon(1)-r2(1);
    x(1)/x(3)*zeta(1)-r3(1);
    x(2)/x(4)*eta(1)+x(3)/x(4)*theta(1)-r4(1); 0];
    
SUScur=(60000000-200-20-1-2)/60000000;
GU=0;
MO=7/60000000;
GUD=0;
GUDvac=0;
currentcases=0;

%%%%%%%%%%%% simulation 
for k=1:N_measures-1
        for i=(T_measures(k)-1)/T_camp+1:(T_measures(k+1)-1)/T_camp
               vacc(i)=vac(k); 
               
               if trigger==1
                  vacc(i)=max([(1-currentcases*60)*VACC(i,vvv) 0]);
                   %vacc(i)=max([(phi-currentcases*60*phi)*vac(k)/phi 0]);
                  end
               if giuseppe==1
                   vacc(i)=VACC(i,vvv);
               end
            if phiaffine==0
            SUS=SUScur-T_camp*SUScur*(CS(k,:)*xcur+vacc(i)); %\phi*S
            else
          SUS=SUScur-T_camp*SUScur*(CS(k,:)*xcur)-T_camp*vacc(i);% \phi
            end
          x=xcur+T_camp*(FF(:,:,k)+b*SUScur*CS(k,:))*xcur;
          L=inv(diag(xcur))*(FF(:,:,k)+b*SUScur*CS(k,:))*xcur;
          I(i)=x(1); 
          D(i)=x(2);
          A(i)=x(3);
          R(i)=x(4);
          T(i)=x(5);
          S(i)=SUS;
          NP(i)=epsilon(k)*I(i)+(theta(k)+mu(k))*A(i);
          R0cur(i)=R0(k);
          q(i)=alpha(k)+beta(k)*D(i)/I(i)+gamma(k)*A(i)/I(i)+delta(k)*R(i)/I(i);
          r1cur(i)=r1(k);
          YS(i)=CS(k,:)*x;
          if phiaffine==0
         
           YH(i)=CH(k,:)*x+vacc(i)*SUScur; %\phi*S
           YHDvac(i)=CHdiag(k,:)*x+vacc(i)*SUScur;
         
          else
              YH(i)=CH(k,:)*x+vacc(i);  %phi
               YHDvac(i)=CHdiag(k,:)*x+vacc(i);
          end
          YHD(i)=CHdiag(k,:)*x;
          YE(i)=CE(k,:)*x;
          GU=GU+T_camp*YH(i);
          GUD=GUD+T_camp*YHD(i);
          GUDvac=GUDvac+T_camp*YHDvac(i);
          MO=MO+T_camp*YE(i);
          H(i)=GU;
          HD(i)=GUD;
          HDvac(i)=GUDvac;
          E(i)=MO;
          SUScur=SUS;
          xcur=x;
          currentcases=R(i)+T(i)+D(i);
          LI(i)=L(1); 
          LD(i)=L(2);
          LA(i)=L(3);
          LR(i)=L(4);
          LT(i)=L(5);
          REFF(i)=(alpha(k)+beta(k)*x(2)/x(1)+gamma(k)*x(3)/x(1)+delta(k)*x(4)/x(1))*SUS/r1(k);
          REFFcur(i)=(alpha(k)+beta(k)*x(2)/x(1)+gamma(k)*x(3)/x(1)+delta(k)*x(4)/x(1))/r1(k);
          
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%%%%% To health care model %%%%
NPP=[NP(1:length(POS))*60000000 movmean(NP(length(POS)+1:end),14)*60000000];
POSSTIMATI=(R+T+D)*60000000;
%%%%% 

%%%%% Rep numbers %%% 
KK=log((POS(2:length(POS)))./POS(1:length(POS)-1));
RTT=exp(KK*4.3);
RTD=(R+T+D)*60000000;

KKest=log((RTD(2:length(RTD)))./RTD(1:length(RTD)-1));
RTTest=exp(KKest*4.3);

for k=1:N_measures-1
G(k)=CS(k,:)*inv(0*eye(5)-FF(:,:,k))*b;
end

RTstimato=(diff(I)./I(1:NDATA-1)+r1cur(1:NDATA-1))./r1cur(1:NDATA-1);
CFRperceived=E./(R+T+D+E+HD);
CFRactual=E./(1-S);


%%%%% LOG-DATE pred
LPOS=diff(Italia(:,6))./Italia(2:length(Italia(:,6)),6);
LOSP=diff(Italia(:,4))./Italia(2:length(Italia(:,4)),4);
LICU=diff(Italia(:,3))./Italia(2:length(Italia(:,2)),3);
LISO=diff(Italia(:,5))./Italia(2:length(Italia(:,2)),5);
LRIC=diff(Italia(:,2))./Italia(2:length(Italia(:,2)),2);
RTD=(R+T+D)*60000000;
LRTD=diff(RTD)./RTD(2:length(RTD));
RT=(R+T)*60000000;
LRT=diff(RT)./RT(2:length(RT));
LT=diff(T*60000000)./(60000000*T(2:length(T)));
LD=diff(D*60000000)./(60000000*D(2:length(D)));
LR=diff(R*(60000000))./(60000000*R(2:length(R)));
