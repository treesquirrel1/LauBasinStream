function fNew = SmoothField( xGrid, yGrid, dr, nP, f )

% SmoothField.m
%  Purpose :
%  This function is used to smooth a 2-D array of observations using the convolution with a Gaussian
%  kernel. *For geophysical data (on a sphere usually) it is important to use a grid that measures
%  the locations in meters, kilometers, etc. and NOT in lat-lon.
%
%  To run the function, pass in the grid, the Gaussian halfwidth (roughly, the smoothing length
%  scale), the number of grid-points to include in the stencil, and the function you want to smooth.
%
%  Input : 
%
%       xGrid : 2-D array of x-grid points
%       yGrid : 2-D array of y-grid points
%       dr : half-width of the Gaussian
%       nP : the number of points in the Gaussian stencil ( gives a smoothing kernel
%            over [i-nP,i+nP]X[j-nP,j+nP] )
%       f  : the 2-D array of observations that you want to smooth. Should be the same size as xGrid 
%            and yGrid.
%
%  Output : 
%       fNew : smoothed version of f. Be aware that a border of width "nP" is not included in fNew
%
% Written by: Joe Schoonover (schoonovernumerics@gmail.com)
% Date: 07/16/2015
% Modified:06/23/2016 E.Simons
%%



   [ nX, nY ] = size(f);
   fNew = zeros( size(f) );

   for iY = 1+nP:nY-nP
      for iX = 1+nP:nX-nP
        
      
        x0 = xGrid(iX,iY);
        y0 = yGrid(iX,iY);
        
        xInds = (iX-nP):(iX+nP);
        yInds = (iY-nP):(iY+nP);

        phase = ( (xGrid(xInds,yInds)-x0).^2 + ...
                  (yGrid(xInds,yInds)-y0).^2 )/(2.0*dr^2);
        
        filt = exp(-phase);
        
        dat = f(xInds,yInds);
        
        tt = reshape( dat.*filt, numel(dat),1 );
       % size(tt)
        fNew(iX,iY) = nansum(tt)/sum(sum(filt));
       
      end
   end

        


