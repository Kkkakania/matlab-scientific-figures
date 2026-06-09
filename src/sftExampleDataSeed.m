function seed = sftExampleDataSeed(kind)
%SFTEXAMPLEDATASEED Return deterministic seed metadata for synthetic examples.

if nargin < 1 || isempty(kind)
    kind = 'line';
end

seed = struct();
seed.Kind = lower(string(kind));
seed.Seed = int64(20260530);
seed.RngAlgorithm = "twister";
seed.Generator = "sftExampleData";
end
