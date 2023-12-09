extends Node

@onready var river_fish = ["Perch", "Carp", "Bass"]
# perch - yellow, carp - brown, bass - green
@onready var ocean_fish = ["Blue Tang", "Clownfish"]
@onready var lava_fish = ["Karsfish", "Lava Shark"]

@onready var fish_resources = {
	"Perch": "res://src/globals/resources/perch.tres",
	"Carp": "res://src/globals/resources/carp.tres",
	"Bass": "res://src/globals/resources/bass.tres",
}
