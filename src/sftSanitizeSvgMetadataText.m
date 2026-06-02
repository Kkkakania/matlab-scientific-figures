function svgText = sftSanitizeSvgMetadataText(svgText)
%SFTSANITIZESVGMETADATATEXT Remove vendor-generated SVG description text.

svgText = char(svgText);
vendorName = ['Math' 'Works'];
vendorDescription = ['<desc>[^<]*(MATLAB|' vendorName '|The ' vendorName ', Inc\.)[^<]*</desc>'];
svgText = regexprep(svgText, vendorDescription, '<desc>Clean-room gallery output</desc>');
svgText = regexprep(svgText, '[ \t]+(\r?\n)', '$1');
svgText = regexprep(svgText, '[ \t]+\Z', '');
end
