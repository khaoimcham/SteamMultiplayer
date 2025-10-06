///@self obj_Server
function SendPlayerSync(_steamID){
	var _b = buffer_create(1, buffer_grow, 1);
	buffer_write(_b, buffer_u8, NETWORK_PACKETS.SYNC_PLAYERS);
	buffer_write(_b, buffer_string, player_list);
	steam_net_packet_send(_steamID, _b);
	buffer_delete(_b);
}

///@self obj_Server
function SendPlayerSpawn(_steamID, _slot){
	var _pos = GrabSpawnPoint(_slot);
	var _b = buffer_create(5, buffer_fixed, 1); // 1 + 2 + 2
	buffer_write(_b, buffer_u8, NETWORK_PACKETS.SPAWN_SELF);
	buffer_write(_b, buffer_u16, _pos.x);
	buffer_write(_b, buffer_u16, _pos.y);
	steam_net_packet_send(_steamID, _b);
	buffer_delete(_b);
	ServerPlayerSpawnAtPosition(_steamID, _pos);
	SendOtherPlayersSpawn(_steamID, _pos);
	
}

function ServerPlayerSpawnAtPosition(_steamID, _pos) {
	var _layer = layer_get_id("Instances");
	for (var i = 0; i < array_length(player_list); i++)
	{
		if (player_list[i].steamID == _steamID)
		{
			var _inst = instance_create_depth(_pos.x, _pos.y, _layer, obj_Player, {
				steamName	: player_list[i].steamName,
				steamID		: _steamID,
				lobbyMemberID: i
			})
			player_list[i].character = _inst;
		}
	}
}

function SendOtherPlayersSpawn(_steamID, _pos){
	var _b = buffer_create(13, buffer_fixed, 1); // 1+2+2+8
	buffer_write(_b, buffer_u8, NETWORK_PACKETS.SPAWN_OTHER);
	buffer_write(_b, buffer_u16, _pos.x);
	buffer_write(_b, buffer_u16, _pos.y);
	buffer_write(_b, buffer_u64, _steamID);
	for (var i = 0; i < array_length(player_list); i++)
	{
		if (player_list[i].steamID != _steamID) /*&& (player_list[i].steamID != steamID)*/
		{
			steam_net_packet_send(player_list[i], _b.steamID, _b);
		}
	}
	buffer_delete(_b);
}

function ShrinkPlayerList(){
	var _shrunk_list = player_list;
	for (var i = 0; i < array_length(_shrunk_list); i++)
	{
		_shrunk_list[i].character = undefined;
	}
	return json_stringify(_shrunk_list);
}