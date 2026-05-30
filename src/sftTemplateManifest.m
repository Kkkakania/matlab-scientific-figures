function manifest = sftTemplateManifest()
%SFTTEMPLATEMANIFEST Return machine-readable metadata for public templates.

registry = sftTemplateRegistry();

empty = struct( ...
    'Name', "", ...
    'OutputName', "", ...
    'RendererName', "", ...
    'Task', "", ...
    'Tags', strings(0, 1), ...
    'ExampleFile', "", ...
    'PngFile', "", ...
    'SvgFile', "");

manifest = repmat(empty, numel(registry), 1);

for k = 1:numel(registry)
    rendererName = string(func2str(registry(k).Renderer));
    outputName = string(registry(k).OutputName);

    manifest(k).Name = string(registry(k).Name);
    manifest(k).OutputName = outputName;
    manifest(k).RendererName = rendererName;
    manifest(k).Task = string(registry(k).Task);
    manifest(k).Tags = string(registry(k).Tags);
    manifest(k).ExampleFile = "examples/" + rendererName + ".m";
    manifest(k).PngFile = "gallery/" + outputName + ".png";
    manifest(k).SvgFile = "gallery/" + outputName + ".svg";
end
end
