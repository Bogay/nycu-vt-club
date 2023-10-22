class_name CharacterBase
extends Area2D

const skill_repository = preload("res://Repository/skills.tres")

@export var data: CharacterData:
	set = _set_character_data
var id: int
var character_name: String
var level: int
var max_hp: Stats
var hp: int
var attack: Stats
var defense: Stats
var speed: Stats
var exp: int
var skiils: Array[Skill]
var is_owned: bool
var is_alive: bool
var is_choosen: bool

signal target_choosen

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if is_choosen and Input.is_action_just_pressed("interact"):
		_on_choosen()

func _set_character_data(value: CharacterData):
	data = value
	id = data.id
	character_name = data.name
	level = data.level
	max_hp = Stats.new(data.max_hp)
	hp = max_hp.value()
	attack = Stats.new(data.attack)
	defense = Stats.new(data.defense)
	speed = Stats.new(data.speed)
	exp = data.exp

	# TODO: directly assign return value of filter to `skills`
	# see more: https://github.com/godotengine/godot/issues/72566
	var tmp_skills: Array[Skill] = []
	tmp_skills.assign(data.skill_ids.map(
		func(id: int):
			for skill in skill_repository.skills:
				if skill.id == id:
					return skill.duplicate()
			return null
	))
	skiils = tmp_skills

	is_owned = false
	is_alive = true
	is_choosen = false

func _on_choosen():
	print('hello')


func _on_mouse_entered():
	is_choosen = true


func _on_mouse_exited():
	is_choosen = false
