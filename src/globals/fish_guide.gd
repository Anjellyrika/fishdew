extends Node

#@onready var river_fish = ["Perch", "Carp", "Bass"]
# perch - yellow, carp - brown, bass - green
#@onready var ocean_fish = ["Blue Tang", "Clownfish"]
#@onready var lava_fish = ["Karsfish", "Lava Shark"]

const FISH_IDS = [["r0", "r1", "r2"], ["o0", "o1"], ["l0", "l1"]]

@onready var fish_resources = {
	"r0": "res://src/globals/resources/perch.tres",
	"r1": "res://src/globals/resources/carp.tres",
	"r2": "res://src/globals/resources/bass.tres",
	"o0": "res://src/globals/resources/bluetang.tres",
	"o1": "res://src/globals/resources/clownfish.tres",
	"l0": "res://src/globals/resources/karsfish.tres",
	"l1": "res://src/globals/resources/lavashark.tres",
}

@onready var fish_stocks = {
	"r0": 0,
	"r1": 0,
	"r2": 0,
	"o0": 0,
	"o1": 0,
	"l0": 0,
	"l1": 0,
}
