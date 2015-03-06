w=windmatlab;

%%
[Opdt,Opcd,Opfd,Optm,Err,Oprd]=...
w.wset('OptionChain','date=20150304;us_code=510050.SH;option_var=;month=È«²¿;call_put=call');
%%
OpCD=strjoin(Opdt(:,4),',');
%%
[Oppdt,Oppcd,Oppfd,Opptm,OppErr,Opprd]=...
    w.wsq(OpCD,'rt_date,rt_time,rt_latest');
%%
[Etfdt,Etfcd,Etffd,Etftm,EtfErr,Etfrd]=...
    w.wsq('510050.SH','rt_date,rt_time,rt_latest');
%%
Expdate=double(cell2mat(Opdt(:,12)));
Stkp=cell2mat(Opdt(:,7));
%%
%Volatility = blsimpv(Price, Strike, Rate, Time, Value, Limit, Yield, Tolerance, Class)
%Volatility = blsimpv(100, 95, 0.075, 0.25, 10, 0.5, 0, [], {'Call'});
Rate=0.045;
Vol=blsimpv(Etfdt(1,3),Stkp,Rate,Expdate/365,Oppdt(:,3),10,0,[],{'Call'});
%%
L=length(Vol);
X=reshape(Expdate,L/4,4);
Y=reshape(Stkp,L/4,4);
Z=reshape(Vol,L/4,4);
%%
mesh(X,Y,Z,'FaceLighting','gouraud','LineWidth',0.3);
xlabel('Maturity');
ylabel('Strike Price');
zlabel('Implied Volatility')
title('IV Surface')
