clear
clc
tic
q = imread("T2.png")-186 ;


x_total = sum(q,1)>0;
y_total = (sum(q,2)>0).';
distance = 1;

TDD = 2*distance*tan((100*pi)/360);
D_Ratio = TDD/100;

Pattern = [0 1] ; 
Pattern_1 = [1 0] ;
Xinitial = strfind(x_total , Pattern) + 0.5 ; 
Xfinal = strfind(x_total , Pattern_1) + 0.5 ; 
X = Xinitial + (Xfinal - Xinitial)/2;

Yinitial = strfind(y_total , Pattern) + 0.5 ; 
Yfinal = strfind(y_total , Pattern_1) + 0.5 ; 
Y = Yinitial + (Yfinal - Yinitial)/2 ;

x_axis = q(Y,:);
y_axis = q(:,X).';
%threshold
T = 27;
t = x_axis(find(x_axis == T,1,'first')-1);
b = q(:,:)>t ==1;
B = sum(b);
%to find centre
Threshold = [t T] ; 
Threshold_1 = [T t] ;
Xinitial_p = strfind(x_axis , Threshold) + 0.5 ; 
Xfinal_p = strfind(x_axis , Threshold_1) + 0.5 ; 
x_position = Xinitial_p + (Xfinal_p - Xinitial_p)/2 ;

Yinitial_p = strfind(y_axis , Threshold) + 0.5 ; 
Yfinal_p = strfind(y_axis , Threshold_1) + 0.5 ; 
y_position = Yinitial_p + (Yfinal_p - Yinitial_p)/2 ;

%diagonal distance

DD_centre = sqrt(x_position^2 + y_position^2);

%actual diagonal distance

ADD_centre = DD_centre*D_Ratio ;

%find radius
Threshold = [t T] ;
Threshold_1 = [T t] ;
initial_p = strfind(x_axis , Threshold) + 1 ;
final_p = strfind(x_axis , Threshold_1) + 1 ;
radius = (final_p - initial_p)/2; 

%actual radius
A_radius = radius * D_Ratio;

%find area

area_counted = sum(B);
area_calculated = pi*radius^2;
%actual area
A_area_1 = area_counted*D_Ratio;
A_area_2 = area_calculated*D_Ratio;
toc
fprintf("centre(x,y) =\n ")
fprintf("(%f,%f) pixels\n",x_position,y_position)
fprintf("diagonal distance to centre =\n")
fprintf("%f pixels\n",DD_centre )
fprintf("Actual diagonal distance to centre =\n")
fprintf("%f m\n", ADD_centre)
fprintf("Radius = \n")
fprintf("%f pixels\n",radius)
fprintf("Actual Radius = \n")
fprintf("%f m\n", A_radius)
fprintf("Area using counting of the pixels = \n")
fprintf("%f pixels\n", area_counted)
fprintf("Area using calculation by using radius= \n")
fprintf("%f pixels\n", area_calculated)
fprintf("Actual area from counting method = \n")
fprintf("%f m^2\n", A_area_1)
fprintf("Actual Area from calculation method = \n")
fprintf("%f m^2\n",A_area_2 )

image(q)

