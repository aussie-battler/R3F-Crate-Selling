/**
	Edited by [GADD]Monkeynutz to sell crates at the WasteDump Trader.
	Complete with Crate Selling logs for infiSTAR called "CRATEDUMP".
**/

private _useInfiSTAR = false;			//Set to true if you use infiSTAR AND it's logging features. This creates a log in your log folder called CRATEDUMP

if (R3F_LOG_mutex_local_verrou) then
{
	hintC STR_R3F_LOG_mutex_action_en_cours;
}
else
{
	R3F_LOG_mutex_local_verrou = true;
	
	private _foundTrader = false;
	{
		_foundTrader = true;
	} forEach nearestObjects [player, ["Exile_Trader_WasteDump"], 12]; //Distance to WasteDump Trader. Default is 12m.

	if (_foundTrader) then {
		
		private _target = player;  
		private _targetUID = getPlayerUID player;
		private _targetName = name player;
		private _crate = R3F_LOG_joueur_deplace_objet;
		private _cargo = _crate call ExileClient_util_containerCargo_list;	
		private _revenue = _cargo call ExileClient_util_gear_calculateTotalSellPrice;
		private _convenience = 0.9;			// This takes a 10% fee from the player for convenience of dumping the contents of the crate rather than selling the items seperately. default is 0.9
		private _newrevenue = _revenue*_convenience;
		private _revrespect = ((_newrevenue/10)*0.8);	// To prevent players getting hella respect, and also a penalty kind of. It takes 20% further off of the total respect earned. Default is 0.8.
		private _percentage = (100-(_convenience*100));
		
		clearWeaponCargoGlobal 		_crate;
		clearItemCargoGlobal 		_crate;
		clearMagazineCargoGlobal 	_crate;
		clearBackpackCargoGlobal 	_crate;
		
		private _cash = player getVariable ["ExileMoney", 0]; 
		private _crateCash = _crate getVariable ["ExileMoney", 0];
		private _currentRespect = player getVariable ["ExileScore", 0]; 
		private _overallCash = round (_cash+_crateCash);
		private _addedRev = round (_newrevenue+_overallCash);
		private _addedRes = round (_currentRespect+_revrespect);
		
		_target setVariable ["ExileMoney",_addedRev, true];  
			
		_target setVariable ['ExileScore', _addedRes, true];  
			
		_target setVariable['PLAYER_STATS_VAR',[_target getVariable ['ExileMoney', 0],_addedRes],true];  
		ExileClientPlayerScore = _addedRes;  
		(owner _target) publicVariableClient 'ExileClientPlayerScore';  
		
		R3FCrateSale = [_targetUID, _addedRev, _addedRes];
		publicVariableServer "R3FCrateSale";
			
		[format["<t size='30' font='OrbitronMedium' color='#00fff6'>Crate Contents Sold!</t><br />    
		<t size='24' font='PuristaMedium' color='#10ff00'>+%1<img image='\exile_assets\texture\ui\poptab_inline_ca.paa' size='24'/><br/>
		+%2 Respect!<br/> 
		We have taken a %3 Percent convenience fee for the service.</t>",_newrevenue, _revrespect, _percentage], [0.8, 0, 1, 1]] call ExileClient_gui_toaster_addToast; 
		
		if (_useInfiSTAR) then {
			Cratelogger = [_targetName, _targetUID, _newrevenue, _revrespect, _cash, _currentRespect, _addedRev, _addedRes, _cargo];
			publicVariableServer "CrateLogger";
		};
		
		systemChat "Removing crate from the world in 1 second!";
		
		sleep 1;
		
		deleteVehicle _crate;
	};
	
	R3F_LOG_joueur_deplace_objet = objNull;
	sleep 0.25;
	
	R3F_LOG_mutex_local_verrou = false;
};
