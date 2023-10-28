class_name Skill
extends Resource

@export var id: int
@export var skill_name: String
# TODO: use enum or class for `type` and `attribute`
@export var type: String
@export var attribute: String
@export var power: int

var owner: CharacterBase

func set_owner(owner: CharacterBase):
	self.owner = owner

func cast(target: CharacterBase):
	# TODO: buff system
	var dmg = owner.attack.value() * power
	target.hp -= dmg
	print("cast %s to %s, cause %d damage" % [skill_name, target.character_name, dmg])
