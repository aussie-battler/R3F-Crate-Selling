   if(isServer) then 
{
    "R3FCrateSale" addPublicVariableEventHandler
    {
        params["_message","_data"];
        _data params["_targetUID","_addedRev","_addedRes"];
        format['setPlayerMoney:%1:%2', _addedRev, (_targetUID)] call ExileServer_system_database_query_fireAndForget;
	format['setAccountScore:%1:%2', _addedRes, (_targetUID)] call ExileServer_system_database_query_fireAndForget;
    };
};
