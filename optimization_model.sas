/***************************************/
/* 1. Create the forecast_data table   */
/***************************************/
data forecast_data;
   input week water_demand unit_cost precipitation;
   datalines;
1 54947 0.18 12000
2 58036 0.18 18000
3 73420 0.10 20000
4 72806 0.10 22000
;
run;

/***************************************/
/* 2. Create the contract_data table   */
/***************************************/
data contract_data;
   length tier $6.;
   input tier $ price purchase_lb;
   datalines;
Tier01 0.25 10000
Tier02 0.20 15000
Tier03 0.18 20000
Tier04 0.16 25000
Tier05 0.14 30000
Tier06 0.13 35000
Tier07 0.12 40000
Tier08 0.11 45000
Tier09 0.10 50000
Tier10 0.07 100000
;
run;

/****************************************************/
/* 3. Solve the Optimization in PROC OPTMODEL       */
/****************************************************/
proc optmodel;
    /* A. Read forecast_data */
    set<number> WEEKS;
    num demand {WEEKS};
    num tank_cost {WEEKS};
    num precip {WEEKS};
    read data forecast_data into WEEKS=[week] demand=water_demand tank_cost=unit_cost precip=precipitation;

    /* B. Read contract_data */
    set<string> TIERS;
    num price {TIERS};
    num purchase_lb {TIERS};
    read data contract_data into TIERS=[tier] price purchase_lb;

    /* C. Global Parameters */
    num init_inventory = 62500;
    num min_inventory = 30000;
    num fraction_tank = 0.25;
    num first_week;
    do;
        first_week = 1e10;
        for {w in WEEKS} do;
            if w < first_week then first_week = w;
        end;
    end;

    /* D. Solution Arrays */
    num buy_sol {TIERS, WEEKS} init 0;
    num tank_sol {TIERS, WEEKS} init 0;
    num inv_sol {TIERS, WEEKS} init 0;
    num cost_sol {TIERS} init 0;

    /* E. Track Best Solution */
    num best_obj;
    str best_tier;
    num temp_best_obj;           /* Changed from var to num */
    str temp_best_tier;
    /* Initialize temporary variables */
    temp_best_obj = 1e10;
    temp_best_tier = '';

    /* F. Model Parameters */
    num current_purchase_lb;
    num current_price;

    /* G. Decision Variables */
    var Buy {w in WEEKS} >= 0;
    var UseTank {w in WEEKS} >= 0;
    var Inventory {w in WEEKS} >= min_inventory;

    /* H. Constraints */
    con DemandCon {w in WEEKS}: 
        Buy[w] + UseTank[w] >= demand[w];
    con TankShareCon {w in WEEKS}: 
        UseTank[w] >= fraction_tank * demand[w];
    con InvBalanceCon {w in WEEKS}: 
        Inventory[w] = (if w = first_week then init_inventory else Inventory[w-1]) + precip[w] - UseTank[w];

    /* I. Objective */
    min TotalCost = sum {w in WEEKS} (current_price * Buy[w] + tank_cost[w] * UseTank[w]);

    /* J. Loop Over Each Contract Tier */
    for {t in TIERS} do;
        current_purchase_lb = purchase_lb[t];
        current_price = price[t];
        /* Update Buy lower bound */
        for {w in WEEKS} do;
            Buy[w].lb = current_purchase_lb;
        end;
        /* Solve without status option */
        solve with lp;
        /* Check if solution is valid by ensuring TotalCost.sol is not missing */
        if TotalCost.sol ne . then do;
            for {w in WEEKS} do;
                buy_sol[t,w] = Buy[w].sol;
                tank_sol[t,w] = UseTank[w].sol;
                inv_sol[t,w] = Inventory[w].sol;
            end;
            cost_sol[t] = TotalCost.sol;
            if cost_sol[t] > 0 and cost_sol[t] < temp_best_obj then do;
                temp_best_obj = cost_sol[t];
                temp_best_tier = t;
            end;
        end;
        else do;
            put "Solver failed for tier " t " (TotalCost.sol is missing)";
        end;
    end;

    /* K. Assign Final Values */
    best_obj = temp_best_obj;
    best_tier = temp_best_tier;

    /* L. Print Results */
    print best_tier best_obj;

    /* M. Create Solution Dataset */
    create data solution from [t w]={<t,w> in TIERS cross WEEKS}
        tier=t week=w buy=buy_sol[t,w] use_tank=tank_sol[t,w] end_inventory=inv_sol[t,w] cost=cost_sol[t];
quit;