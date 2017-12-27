    format['setPlayerMoney:%1:%2', _addedRev, (_targetUID)] call ExileServer_system_database_query_fireAndForget;
		format['setAccountScore:%1:%2', _addedRes, (_targetUID)] call ExileServer_system_database_query_fireAndForget; 
