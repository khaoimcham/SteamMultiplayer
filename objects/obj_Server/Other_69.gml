/// @description Server Listener

switch(async_load[? "event_type"])
{
	case "lobby_chat_update":
		var _fromID = async_load[?"user_id"]; // Steam ID
		var _fromName = steam_get_user_persona_name(_fromID); // Steam name
		if (async_load[? "change_flags"] & steam_lobby_member_change_entered)
		{
			show_debug_message("Player joined: " + string(_fromName));
			var _slot = array_length(player_list);
			array_push(player_list, 
			{
				steamID : _fromID,
				steamName : _fromName,
				character : undefined,
				startPos : GrabSpawnPoint(_slot),
				lobbyMemberID : _slot
			});
			SendPlayerSync(_fromID);
			SendPlayerSpawn(_fromID, _slot);
		}
	break;
}