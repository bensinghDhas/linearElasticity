%Author: Bensingh Dhas
%Descripton: Plotes the mesh with Q4 element.
%Input: requires you to supply connectivity of the mesh and nodes
%associated with the connect.
%Dependencies: None
%Remark: Crude code consider updating

function Q4Plotter(mesh,nodes,figId)
connect=[mesh.elements,mesh.elements(:,1)];
figure (figId)
hold on;
for i=1:mesh.noEl
  x=nodes(connect(i,:),:);
  plot(x(:,1),x(:,2),'k','linewidth',0.1);
end
axis equal;
hold off;
end
