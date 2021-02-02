% rows - presynaptic; columns postsynaptic
% sparse - most entries are 0
% globally FF (upper triangular matrix)
% locally FF - no reciprocal connections => loop
% recurrent

%No. of cells
N_cells = 60;
%Group of each of the cells
cell_groups = randi([1,4], [1, N_cells]);

%Connectivity matrix
C = zeros(N_cells);

%Probability of connection if the two neurons are form the same group (p1)
%and probability of connection if the two neurons are from different group
%(p0)
p0 = 0.1;
p1 = 0.5;

%Connectivity matrix based on the above criteria
for i = 1:size(C,1)
    neuron_group = cell_groups(i)*ones(1,N_cells);
    same_group = find(neuron_group == cell_groups);
    different_group = 1:N_cells;
    different_group(same_group) = [];
    C(i,same_group) =  rand(1,length(same_group))<p1;
    C(i,different_group) = rand(1,length(different_group))<p0;
end

imagesc(C);
