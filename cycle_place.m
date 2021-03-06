function returnable = cycle_place(place_in, input_weights, input)
    global w_place_to_place;
    global PVAL;
    global HVAL;

    global place_in_queue;
    global place_weight_queue;

    global PLACE_CELLS;
    PLACE_CELLS = 14;

    % HPC recurrency stuff
    global w_place_to_hpc;
    global w_hpc_to_place;
    global hpc_learning;
    
    % PFC recurrency stuff
    global w_place_to_pfc;
    global w_pfc_to_place;
    global pfc_learning;
    global is_pfc;
    decay = .004;
    
    global place_food_learn;

    global REPL;

    global run_hpc;
    global run_pfc;
    
    global w_place_to_food;
    
    place_eye = eye(PLACE_CELLS);
    w_place_to_place = zeros(PLACE_CELLS);

    queue_pos = length(place_in_queue)+1;

    if nargin < 3
        total_inputs = 0;
        food_in = place_in{4};
        pfc_in = place_in{3};
        hpc_in = place_in{2};
        place_in = place_in{1};

        for i = 1:(queue_pos-1)
            total_inputs = total_inputs + place_in_queue{i} * place_weight_queue{i};
        end

        place_out = activity(place_in, place_eye, total_inputs, ...
            w_place_to_place);

        if place_food_learn
            w_place_to_food = oja(place_out, food_in, w_place_to_food, HVAL);
        end
        returnable = place_out;

        if hpc_learning & run_hpc                       
            [w_hpc_to_place w_place_to_hpc] = recurrent_oja(place_out, place_in, ...
                hpc_in, w_hpc_to_place, w_place_to_hpc, HVAL);
        end
        
        if pfc_learning & run_pfc
            is_pfc = 1;
            [w_pfc_to_place w_place_to_pfc] = recurrent_oja(place_out, place_in, ...
                pfc_in, w_pfc_to_place, w_place_to_pfc, PVAL);
            is_pfc = 0;
        end

        place_in_queue = {};
    else
        % return the weights given if no weight in queue
        if ( queue_pos > length(place_weight_queue) )
            returnable = input_weights;
        else
            returnable = place_weight_queue{queue_pos};
        end

        place_in_queue{queue_pos} = input;
        place_weight_queue{queue_pos} = input_weights;
    end
end