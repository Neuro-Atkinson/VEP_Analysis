% function for plotting a family of lines
% two vectors of the same size a and b are input arguments
% Last used 10-4-11
function [] = flines(var,filename)

% Calculate lengths and apply motility threshold


    
    a=var(:,1);
    b=var(:,2);
    
% PLOT FAMILY OF LINES
figure();
    font_size=6;
    fig_size=7;
%     set(gca,'Units','centimeters','position',[2 6 fig_size*0.75 fig_size/2],'FontSize',font_size); % formatting to the real size in cm
    hold on;
    %set(gca,'DataAspectRatio',[1 6 1]); %for 2-p MS => [x y z] where x,z = 1; y = (yaxis_range/5) for xlim [0,3] (/5.5556 for 3 points)
%          %PRESETS
%          set(gca,'YLim',[-18 2],'YTick',[-18 -16 -14 -12 -10 -8 -6 -4 -2 0 2],'XLim',[0 3],'XTick',[1 2],'XTickLabel',{'Pre';'Post'});
%          set(gca,'YLim',[-4 1],'XLim',[0 3],'XTick',[1 2],'XTickLabel',{'Pre';'Post'});
         
         %AUTO
         set(gca,'XTickLabel',{'Pre';'Post'});
         set(gca,'XTickLabel',{'Pre';'Post'});
         
%     set(gca,'DataAspectRatio',[1 8 1]); 
%         set(gca,'YLim',[-15 25],'XLim',[0 3],'XTick',[1 2],'XTickLabel',{'Pre';'Post'});
    
    set(gca,'XLim',[0 3],'XTick',[1 2],'XTickLabel',{'Pre';'Post'});
    % title(['Change in length from baseline']);
    ylabel('Change in length (um)','FontSize',font_size);
    
    pre_post = [a b];     
pre_post_means = mean(pre_post);    
plot((pre_post_means),'bo','MarkerSize',5);
errorbar((pre_post_means),std(pre_post)/sqrt(length(pre_post)),'-','Color','b','LineWidth',3);
    %plot(pre-post','-ko','MarkerFaceColor', 'k','MarkerSize',3);
    %plot(pre_post','mo','MarkerSize',3);

        plot(pre_post','-b.','MarkerSize',11);
%         plot(mean(pre_post),'-s','MarkerFaceColor','r','Color','r','LineWidth',1,'MarkerSize',4);
%             errorbar(mean(pre_post),std(pre_post)/sqrt(length(a)),'-','Color','r','LineWidth',1);
    
    hold on;

    saveas(gcf,filename,'ai');
end