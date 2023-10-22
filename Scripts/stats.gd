class_name Stats

var _base: int
var _buff_const: int
var _buff_ratio: int

func _init(base: int):
	_base = base

func add_const(amount: int):
	_buff_const += amount

func add_ratio(amount: int):
	_buff_ratio += amount

func value():
	return (_base * (100 + _buff_ratio) / 100) + _buff_const
