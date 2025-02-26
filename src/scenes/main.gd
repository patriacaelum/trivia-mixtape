class_name Main
extends Control


@onready var _next_round_button := %NextRoundButton
@onready var _question_grid := %QuestionGrid

var _data: Dictionary = {}
var _round: int = 0


func _ready() -> void:
    var file := FileAccess.open("res://data.json", FileAccess.READ)
    var contents: String = file.get_as_text()
    self._data = JSON.parse_string(contents)
    self._question_grid.load(self._data.get("round%d" % self._round, {}))
