function s = ParticlePath_WRK3( x0, y0, xG, yG, u, v, ds, L, dx, dy )

   tol = 10.0^(-9);
   rk3_a(1:3) = [ 0.0, -5.0/9.0, -153.0/128.0 ] ;
   rk3_b(1:3) = [ 0.0, 1.0/3.0, 3.0/4.0 ] ;
   rk3_g(1:3) = [ 1.0/3.0, 15.0/16.0, 8.0/15.0 ] ;
   
   N = L/ds;
   
   s.ds = ds;
   s.L  = L;
   s.N  = N;
   s.x  = zeros(N,1);
   s.y  = zeros(N,1);
   
   s.x(1) = x0;
   s.y(1) = y0;
   
   for i = 2:N
   
      Gu = 0.0;
      Gv = 0.0;
      thisX = s.x(i-1);
      thisY = s.y(i-1);
      
      for m = 1:3
        
        xcheck = xG - thisX;
        i1 = find(xcheck <= 0.0, 1, 'last');
     %   i2 = find(xcheck >= 0.0, 1, 'first');
        i2 = i1 +1 ;
        ycheck = yG - thisY;
        j1 = find(ycheck <= 0.0, 1, 'last');
        %j2 = find(ycheck >= 0.0, 1, 'first');
        j2 = j1 + 1;
        w1x = thisX - xG(i1);
        w2x = thisX - xG(i2);
        w1y = thisY - yG(j1);
        w2y = thisY - yG(j2);
        
        w1 = w2x*w2y/(dx*dy);
        w2 = -w1x*w2y/(dx*dy);
        w3 = w1x*w1y/(dx*dy);
        w4 = -w2x*w1y/(dx*dy);
        
        thisU = u(i1,j1)*w1 + u(i2,j1)*w2 + u(i2,j2)*w3 + u(i1,j2)*w4;
        thisV = v(i1,j1)*w1 + v(i2,j1)*w2 + v(i2,j2)*w3 + v(i1,j2)*w4;
       
        
        umag = sqrt(thisU^2 + thisV^2);
        if(umag < tol)
          fprintf(' ParticlePath_WRK3 : Close to fixed point, returning \n')
          s.x(i:N) = s.x(i-1);
          s.y(i:N) = s.y(i-1);
          return
        end
          
        dxdt = thisU/umag*ds;
        dydt = thisV/umag*ds;
        
        Gu = rk3_a(m)*Gu + dxdt;
        Gv = rk3_a(m)*Gv + dydt;
        
        thisX = thisX + rk3_g(m)*Gu;
        thisY = thisY + rk3_g(m)*Gv;
        
      end
      
      s.x(i) = thisX;
      s.y(i) = thisY;
      
   end
   
