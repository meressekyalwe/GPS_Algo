
x=0; y=0; z=0; b=0;
rp=[x; y ;z];

spx=[spx1,spx2,spx3,spx4]; spy=[spy1,spy2,spy3,spy4]; spz=[spz1,spz2,spz3,spz4];

sp1=[spx1; spy1; spz1]; sp2=[spx2; spy2; spz2]; sp3=[spx3; spy3; spz3]; sp4=[spx4; spy4; spz4];

sp=[sp1,sp2,sp3,sp4];

rho_c=[rho1; rho2; rho3; rho4]; UV=[0,0,0,0;0,0,0,0;0,0,0,0;0,0,0,0];  drho=[0;0;0;0];
numsat=4; e = inf; d = inf; t = 1e-7;
while e > t
    for k = 1:numsat
    UV(k:k,:) =[(-1/norm(sp(:,k:k)-rp))*spx(:,k:k),(-1/norm(sp(:,k:k)-rp))*spy(:,k:k),(-1/norm(sp(:,k:k)-rp))*spz(:,k:k),1]; drho(k:k,:)=rho_c(k)-norm(sp(:,k:k)-rp);
    end 
dub=pinv(UV)*drho; next=[rp;b]+dub;
rp=[next(1,1);next(2,1);next(3,1)];  b=next(4,1);
e=d-norm(drho); d=norm(drho); 
end 
H=inv(UV'*UV);
PD0P=sqrt(H(1,1)+H(2,2)+H(3,3));

x =rp(1,1);
y =rp(2,1);
z =rp(3,1); rpp=[sqrt(x^2+y^2);z];
a = 6378137;
b = 6356752;

th = atan2(a*z,b*sqrt(x^2+y^2)); son = atan2(y,x);
latd = 180*acos(b*cos(th)/sqrt(b^2*(cos(th))^2+a^2*(sin(th))^2))/pi; sat=acos(b*cos(th)/sqrt(b^2*(cos(th))^2+a^2*(sin(th))^2));

xpos=[a*cos(th);b*sin(th)]; altitude=norm(xpos-rpp); latitude_degres=fix(latd); latitude_minutes=(latd-fix(latd))*60;
latitude_dd_mm_ss=[fix(latd)  fix(latitude_minutes)  fix(60*(latitude_minutes-fix(latitude_minutes)))];



longitude=son*180/pi;
longitude_dd_mm_ss=[fix(longitude)   fix(60*(longitude-fix(longitude)))   fix(60*(60*(longitude-fix(longitude))-fix(60*(longitude-fix(longitude)))))];


format short 
fprintf('\n');
fprintf('PD0P: %t \n', PD0P); 
format short

format rat 
longitude_dd_mm_ss 
latitude_dd_mm_ss 
format short
fprintf('altitude [m]: %f \n', altitude);
