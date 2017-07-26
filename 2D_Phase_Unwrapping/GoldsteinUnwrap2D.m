function Unwrap2D = GoldsteinUnwrap2D(IM, IM_mask)

IM_phase=angle(IM);                         %Phase image
% Set parameters
max_box_radius=4;                           %Maximum search box radius (pixels)
threshold_std=5;                            %Number of noise standard deviations used for thresholding the magnitude image

% Unwrap
residue_charge=PhaseResidues(IM_phase, IM_mask);                            %Calculate phase residues
branch_cuts=BranchCuts(residue_charge, max_box_radius, IM_mask);            %Place branch cuts
[IM_unwrapped]=FloodFill(IM_phase, branch_cuts, IM_mask);  %Flood fill phase unwrapping

Unwrap2D = IM_unwrapped;

end