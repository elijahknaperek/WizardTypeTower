extends Node

var MAIN_MENU_SCENE = load("res://main_menu.tscn")
var GAME_SCENE = load("res://game/tower_game.tscn")

const char_lvl = ["abcdefghijklmnopqrstuvwxyz",
				"abcdefghijklmnopqrstuvwxyz0123456789",]
const chars = "!\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
const chars2 = "asdfjkl;ASDFJKL:!\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~abcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyabcdefghijklmnopqrstuvwxyABCDEFGHIJKLMNOPQRSTUVWXYZ,.,.01234567898=+/*!-<>:"


var score
signal streak_changed(s)
var streak = 0:
	set(v):
		if v > max_streak:
			max_streak = v
		streak = v
		streak_changed.emit(v)
var max_streak = 0


func reset():
	score = 0
	streak = 0
	max_streak = 0
