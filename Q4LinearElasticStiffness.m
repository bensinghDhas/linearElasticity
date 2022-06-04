%Author: Bensingh Dhas
%Description: Creates the plane elastic stiffness using Q4 elements.
%Dependencies: None
%Created on: 10th Dec, 2016

function ke=Q4LinearElasticStiffness(elNodes,dataGauss,mat)
    ke=zeros(8);
    for itGp=1:numel(dataGauss.Wt)
      x=dataGauss.Pt(itGp,:);
      [~,dsp]=Q4ShapeFn(x(1),x(2));
      jacobian=dsp*elNodes;
      dsp=jacobian\dsp;
      r1=[1 0 0 0;0 0 0 1;0 1 1 0];
      r3(1,1:4)=dsp(1,:);
      r3(2,1:4)=dsp(2,:);
      r3(3,5:8)=dsp(1,:);
      r3(4,5:8)=dsp(2,:);
      B=r1*r3;
      JxW=det(jacobian)*dataGauss.Wt(itGp);
      ke=ke+JxW*B'*mat.D*B;
    end
end
