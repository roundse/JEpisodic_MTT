function show_weights(section, is_disp_weights)

global w_place_to_pfc;
global w_pfc_to_place;
global w_food_to_pfc;
global w_pfc_to_food;
% global w_place_to_pfc;
% global w_pfc_to_place;
% global w_food_to_pfc;
% global w_pfc_to_food;
% global w_pfc_to_pfc;
global pfc;
global place_region;
global food;
global cycles
global learning_rate;
global TRIAL_DIR;
global PLACE_SLOTS;

global pfc_cur_decay;

filename = horzcat(TRIAL_DIR, section, '_variables');
%save(filename);

if is_disp_weights
    figure;
    subplot(1,2,1);
    wx_ppfc_temp = w_place_to_pfc(w_place_to_pfc ~= 0);
    hist(wx_ppfc_temp);
    title(horzcat(section, ' Place to HPC'));
    subplot(1,2,2);
    imagesc(w_place_to_pfc);
    colorbar();
    drawnow;

    figure;
    subplot(1,2,1);
    wx_pfcp_temp = w_pfc_to_place(w_pfc_to_place ~= 0);
    hist(wx_pfcp_temp);
    title(horzcat(section, ' HPC to Place'));
    subplot(1,2,2);
    imagesc(w_pfc_to_place);
    colorbar();
    drawnow;

%     figure;
%     title(horzcat(section, ' HPC to HPC'));
%     imagesc(w_pfc_to_pfc);
%     colorbar();
%     drawnow;

    figure;
    subplot(1,2,1);
    wx_fpfc_temp = w_food_to_pfc(w_food_to_pfc ~= 0);
    hist(wx_fpfc_temp);
    title(horzcat(section, ' Food to HPC'));
    subplot(1,2,2);
    imagesc(w_food_to_pfc);
    colorbar();
    drawnow;

    figure;
    subplot(1,2,1);
    wx_pfcf_temp = w_pfc_to_food(w_pfc_to_food ~= 0);
    hist(wx_pfcf_temp);
    title(horzcat(section, ' HPC to Food'));
    subplot(1,2,2);
    imagesc(w_pfc_to_food);
    colorbar();
    drawnow;

%     figure;
%     hist(pfc);
%     title(horzcat(section, ' HPC cumulative inputs'));
%     drawnow;
% 
%     figure;
%     hist(place_region);
%     title(horzcat(section, ' Place cumulative inputs'));
%     drawnow;
% 
%     figure;
%     hist(food);
%     title(horzcat(section, ' Food cumulative inputs'));
%     drawnow;

    global pfc_responses_to_place;

    if pfc_responses_to_place
        
%         if (sum(var(pfc_responses_to_place)) < 4)
%            variance = var(pfc_responses_to_place)
%            error('bland outputs...'); 
%         end
%         figure;
%         subplot(1,2,1);
%         hist(pfc_responses_to_place);
%         title(horzcat(section, ' HPC responses to place slots and food'));
%         subplot(1,2,2);
%         imagesc(pfc_responses_to_place);
%         colorbar();
%         drawnow;
% 
%         figure;
%         title(horzcat(section, ' HPC responses above mean'));
%         imagesc(pfc_responses_to_place>mean(mean(pfc_responses_to_place')));
%         colorbar();
%         drawnow;
    end
end

end

