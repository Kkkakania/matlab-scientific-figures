function templates = sftListTemplates()
%SFTLISTTEMPLATES Return a user-facing table of available figure templates.

registry = sftTemplateRegistry();

names = string({registry.Name}).';
outputNames = string({registry.OutputName}).';
tasks = string({registry.Task}).';
tags = strings(numel(registry), 1);

for k = 1:numel(registry)
    tags(k) = strjoin(string(registry(k).Tags), ", ");
end

templates = table(names, outputNames, tasks, tags, ...
    'VariableNames', {'Name', 'OutputName', 'Task', 'Tags'});
end
