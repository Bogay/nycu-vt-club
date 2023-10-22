class_name CharacterInfoUI
extends ColorRect

@onready var level_label: Label = $"VBoxContainer/HBoxContainer/LevelLabel"
@onready var name_label: Label = $"VBoxContainer/HBoxContainer/NameLabel"
@onready var hp_bar: ProgressBar = $"VBoxContainer/HPBarContainer/HPBar"

func bind_character(chara: CharacterBase):
	level_label.text = "Lv. %d" % chara.level
	name_label.text = chara.character_name
	
	hp_bar.max_value = chara.max_hp.value()
	hp_bar.value = chara.hp
	# TODO: event listener

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
