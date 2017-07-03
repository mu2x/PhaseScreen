function [ D_sf ] = str_fcn2_ft(ph, mask, delta )

    NN = size(ph,1);
    ph = ph .* mask;

    P = ft2(ph, delta);
    S = ft2(ph.^2, delta);
    W = ft2(mask, delta);
    delta_f = 1/(NN*delta);
    w2 = ift2(W.*conj(W), delta_f);
    
    D_sf = 2*ift2(real(S.*conj(W))-abs(P).^2, delta_f)./w2.*mask;
end

