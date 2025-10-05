/// @description Setup lobby_list

lobby_list = []

x_scale = 26;
y_scale = 16;

image_xscale = x_scale;
image_yscale = y_scale;

lobby_list[0] = instance_create_depth(x, bbox_top+40, -20, obj_LobbyItem);

steam_lobby_list_add_string_filter("isGameMakerTest", "true", steam_lobby_list_filter_eq);
steam_lobby_list_request();

resetLobbyList = function() {
	for (var i = 0; i < array_length(lobby_list); i++)
	{
		show_debug_message("Deleting: " + string(lobby_list[i]));
		instance_destroy(lobby_list[i]);
	}
	lobby_list = [];
}