extends Node

const SCENE_PATHS: Dictionary[String, String] = {
	"base_level":"uid://vwukeorb6yvs",
	"base_coin":"uid://bgrch5de5xhey",
	"base_enemy":"uid://d3tgw7j1mag6w",
	"shop":"uid://smvg3nwqqw6x",

}

const UI_PATHS: Dictionary[String, String] = {
	"global_ui_path":"res://gui/global_ui.tscn",
	"game_ui_path":"res://gui/game_ui.tscn",
	"skill_check_path":"res://gui/skill_check.tscn",
	"debug_menu":"res://gui/debug.tscn",
	"main_menu":"uid://bydht7j8q5mvr"
}

const COINS: Dictionary = {
	"base":"uid://d35ga8hv2jlvh",
	"1787":"uid://bgh5v2n073rl7",
	"old_abe":"uid://dj73eohb1fsui",
	#"lucky":"",
	#"healthy":"",
}

const JSON_PATHS: Dictionary = {
	"coins":"res://assets/resource_json/coins.json",
	"shopkeeper":"res://assets/resource_json/shopkeeper.json"
}

enum display_type{PLAY, SHOP, HAND}