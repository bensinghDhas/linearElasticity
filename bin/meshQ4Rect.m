%Authors: Bensingh Dhas
%Description: Generates non uniform mesh on rectangle
%Created on: fork on 26th Nov, 2018, form some old code.
%nx and ny are the number of nodes in x and y direction, not the number of
%elements.
classdef meshQ4Rect < handle
  properties
    nodes
    elements
    noEl
    noNd
  end
  methods
    function obj =meshQ4Rect(xRange,yRange,nx,ny)
      
      x_nodes=linspace(xRange(1),xRange(2),nx);
      y_nodes=linspace(yRange(1),yRange(2),ny);
      [y,x]=meshgrid(y_nodes,x_nodes);
      obj.nodes=[x(:),y(:)];
      nx=length(x_nodes)-1;
      ny=length(y_nodes)-1;
      counter=1;
      for j=0:ny-1
        for i=1:nx
          obj.elements(counter,1)=((nx+1)*j)+i;
          obj.elements(counter,2)=((nx+1)*j)+i+1;
          obj.elements(counter,3)=((nx+1)*(j+1))+i+1;
          obj.elements(counter,4)=((nx+1)*(j+1))+i;
          counter=counter+1;
        end
      end
      obj.noEl=counter-1;
      obj.noNd=size(obj.nodes,1);
    end
  end
end
