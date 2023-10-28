class_name CharacterInfoUI
extends ColorRect

@onready var level_label: Label = $"VBoxContainer/HBoxContainer/LevelLabel"
@onready var name_label: Label = $"VBoxContainer/HBoxContainer/NameLabel"
@onready var hp_bar: ProgressBar = $"VBoxContainer/HPBarContainer/HPBar"

var character: CharacterBase = null:
	set = _set_character
var callback = null

func _set_character(chara: CharacterBase):
	character = chara

	if chara == null:
		return

	level_label.text = "Lv. %d" % chara.level
	name_label.text = chara.character_name
	hp_bar.max_value = chara.max_hp.value()
	_on_hp_changed(chara.hp)
	callback = func (_old_value, new_value):
		_on_hp_changed(new_value)
	assert(chara.hp_changed.connect(callback) == OK)

func bind_character(chara: CharacterBase):
	clear_binding()
	character = chara

# clear old binding, if any
func clear_binding():
	if character == null:
		return

	assert(character.hp_changed.is_connected(callback))
	character.hp_changed.disconnect(callback)
	callback = null

	character = null

func _on_hp_changed(new_value: int):
	hp_bar.value = new_value
