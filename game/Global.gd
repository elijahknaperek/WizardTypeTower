extends Node

var MAIN_MENU_SCENE = load("res://main_menu.tscn")
var GAME_SCENE = load("res://game/tower_game.tscn")

const char_lvl = ["abcdefghijklmnopqrstuvwxyz",
				"abcdefghijklmnopqrstuvwxyz0123456789",]
const chars = "!\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
const chars2 = "!\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~abcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxy"


var score
