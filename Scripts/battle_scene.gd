extends Control

enum BattleLogic {
	PLAYER_TURN,
	ENEMY_TURN,
	SYSTEM_TURN,
}

enum SystemLogic {
	START_BATTLE,
	PLAYER_DIED,
	ENEMY_DIED,
	END_BATTLE,
}

const character_repository: CharacterRepository = preload("res://Repository/characters.tres")
const character_base_scene: PackedScene = preload("res://Characters/character_base.tscn")

@export var curr_battle: BattleLogic
@export var curr_sys: SystemLogic
@export var current_character: Dictionary = {}

@onready var character_button_1 = $"CanvasLayer/CharacterBox/VBoxContainer/CharacterButton 1"
@onready var character_button_2 = $"CanvasLayer/CharacterBox/VBoxContainer/CharacterButton 2"
@onready var character_button_3 = $"CanvasLayer/CharacterBox/VBoxContainer/CharacterButton 3"
@onready var character_button_4 = $"CanvasLayer/CharacterBox/VBoxContainer/CharacterButton 4"
@onready var character_button_5 = $"CanvasLayer/CharacterBox/VBoxContainer/CharacterButton 5"

@onready var skill_button_1 = $"CanvasLayer/Dialog/VBoxContainer/HBoxContainer/SkillButton 1"
@onready var skill_button_2 = $"CanvasLayer/Dialog/VBoxContainer/HBoxContainer/SkillButton 2"
@onready var skill_button_3 = $"CanvasLayer/Dialog/VBoxContainer/HBoxContainer2/SkillButton 3"
@onready var skill_button_4 = $"CanvasLayer/Dialog/VBoxContainer/HBoxContainer2/SkillButton 4"

@onready var player_info_ui: CharacterInfoUI = $"CanvasLayer/PlayerCharacterInfoUI"
@onready var enemy_info_ui: CharacterInfoUI = $"CanvasLayer/EnemyCharacterInfoUI"

func _ready():
	setup_character_data()
	setup_character_buttons()

func _process(delta):
	pass

func setup_character_data():

	General.init_characters(load_characters())
	# TODO: load enemy data
	General.init_enemies(load_characters())

	set_current_character(General.party[0])
	set_current_enemy(General.enemy_party[0])

func load_characters():
	var characters: Array[CharacterBase] = []

	# TODO: read user saved data instead of game repository
	# TODO: directly assign return value of filter to `characters`
	# see more: https://github.com/godotengine/godot/issues/72566
	characters.assign(character_repository.characters.map(
		func(chara_data: CharacterData) -> CharacterBase:
			var new_chara = character_base_scene.instantiate() as CharacterBase
			new_chara.data = chara_data
			return new_chara
	))
	
	return characters	

func set_current_enemy(enemy: CharacterBase):
	bind_info_ui(enemy_info_ui, enemy)

func set_current_character(chara: CharacterBase):
	bind_info_ui(player_info_ui, chara)
	bind_skill_buttons(chara)

func bind_info_ui(ui: CharacterInfoUI, chara: CharacterBase):
	ui.bind_character(chara)

func bind_skill_buttons(chara: CharacterBase):
	var buttons: Array[SkillButton] = [
		skill_button_1,
		skill_button_2,
		skill_button_3,
		skill_button_4,
	]

	for i in range(0, len(buttons)):
		if i < len(chara.skiils):
			buttons[i].bind_skill(chara.skiils[i])
		else:
			buttons[i].bind_skill(null)

func setup_character_buttons():
	var buttons: Array[BaseButton] = [
		character_button_1,
		character_button_2,
		character_button_3,
		character_button_4,
		character_button_5,
	]

	# TODO: make selected character more explicit
	for i in range(0, buttons.size()):
		if i + 1 < General.party.size():
			buttons[i].disabled = !General.party[i + 1].is_alive
		else:
			buttons[i].disabled = true
		assert(buttons[i].pressed.connect(_on_choose_character(i + 1)) == OK)

func _on_choose_button_pressed():
	$CanvasLayer/CharacterBox.visible = true

func _on_choose_character(i: int):
	return func():
		var new_chara = General.party[i]
		var old_chara = General.party[0]
		General.party[0] = new_chara
		General.party[i] = old_chara
		print('new chara %s' % new_chara.character_name)
		set_current_character(new_chara)
		$CanvasLayer/CharacterBox.visible = false
