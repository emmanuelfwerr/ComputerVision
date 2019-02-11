function [pu] = threed2d(u,v,w, vue2)
  
        wcmat = [u;v;w; 1];                               
        putemp = (vue2.Kmat * vue2.Pmat) * wcmat;
        pu = [putemp(1)/putemp(3); putemp(2)/putemp(3); 1];
        
end
