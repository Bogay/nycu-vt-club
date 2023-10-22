extends Node

var alive_count = 0
var party : Array[CharacterBase] = []
var enemy_party: Array[CharacterBase] = []

func _ready():
	pass

func _process(delta):
	pass

func init_characters(characters: Array[CharacterBase]):
	party = characters
	alive_count = 0
	for c in party:
		if c.is_alive:
			alive_count += 1

func init_enemies(enemies: Array[CharacterBase]):
	enemy_party = enemies
