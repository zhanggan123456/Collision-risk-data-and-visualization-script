csv_file_path = 'C:/Users/Desktop/No_Vision.csv';  
data = readtable(csv_file_path, 'TextType', 'string');

radius = data.a; 
angles = deg2rad(data.b); 
collision_probability = data.d;

adjusted_angles = pi/2 - angles;

X = radius .* cos(adjusted_angles);
Y = radius .* sin(adjusted_angles);

figure;

scatter_handle = scatter(X, Y, 5, collision_probability, 'filled'); 
colormap('jet'); 
caxis([0, 1.0]);  

cbar = colorbar;  
cbar.Ticks = 0:0.10:1.0;  
cbar.Title.String = 'Point Risk';  
cbar.FontSize = 12;  
set(gca, 'FontSize', 12);  
axis equal;          
axis tight;  

xlabel('X coordinate (m)', 'FontSize', 14);
ylabel('Y coordinate (m)', 'FontSize', 14);
xlim([0, 5]);
ylim([-3, 6]);

width_in_inches = 4;  
height_in_inches = 5.5; 

set(gcf, 'Units', 'inches');
set(gcf, 'Position', [1, 1, width_in_inches, height_in_inches]);

set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [0, 0, width_in_inches, height_in_inches]); 
set(gcf, 'PaperSize', [width_in_inches, height_in_inches]);  
set(gcf, 'PaperPositionMode', 'auto');  

dcm_obj = datacursormode(gcf);  
set(dcm_obj, 'UpdateFcn', @(obj, event) customDataCursor(obj, event, data));  

print('LS', '-dpng', '-r600');  

function txt = customDataCursor(~, event_obj, data)
    pos = get(event_obj, 'Position');  
    idx = find(abs(pos(1) - data.a .* cos(pi/2 - deg2rad(data.b))) < 1e-4 & ...
               abs(pos(2) - data.a .* sin(pi/2 - deg2rad(data.b))) < 1e-4);  

    if ~isempty(idx)
        txt = {
            ['Radius: ', num2str(data.a(idx))], ...
            ['Angle: ', num2str(data.b(idx))], ...
            ['Probability: ', num2str(data.d(idx))]
        };
    else
        txt = {'No matching data'};  
    end
end