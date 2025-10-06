/// @self obj_Client
function SyncPlayers(_new_list) {
	var _steamIDs = [];
	for (var i = 0; i < array_length(player_list); i++)
	{
		array_push(_steamIDs, player_list[i].steamID);
	}
	
	for (var i = 0; i < array_length(_new_list); i++)
	{
		var _newSteamID = _new_list[i].steamID
		if !array_contains(_steamIDs, _newSteamID)
		{
			var _inst = ClientPlayerSpawnAtPos(_new_list[i]);
			_new_list[i].character = _inst;
			array_push(player_list, _new_list[i]);
		}
		else
		{
			for (var k = 0; k < array_length(player_list); k++)
			{
				if (player_list[k].steamID == _newSteamID)
				{
					player_list[k].startPos = _new_list[i].startPos;
					player_list[k].lobbyMemberID = _new_list[i].lobbyMemberID;
					if player_list[k].character == undefined && player_list[k].steamID != _newSteamID
					{
						var _inst = ClientPlayerSpawnAtPos(player_list[k]);
						player_list[k].character = _inst;
					}
				}
			}
		}
	}
}

function ClientPlayerSpawnAtPos(_player_info){
	var _layer = layer_get_id("Instances");
	var _name = _player_info.steamName;
	var _steamID = _player_info.steamID;
	var _num = _player_info.lobbyMemberID;
	var _loc = _player_info.startPos;
	var _inst = instance_create_layer(_loc.x, _loc.y, _layer, obj_Player, {
		steamName : _name,
		steamID : _steamID,
		lobbyMemberID :_num
	});
	return _inst;
}