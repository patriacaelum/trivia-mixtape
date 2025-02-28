class_name Main
extends Control


@onready var _host_window := %HostWindow
@onready var _next_round_button := %NextRoundButton
@onready var _question_grid := %QuestionGrid

var _data: Array = []
var _round: int = 0


func _ready() -> void:
    self._next_round_button.pressed.connect(self._on_next_round_button_pressed)
    self._question_grid.question_pressed.connect(self._on_question_grid_question_pressed)

    var file := FileAccess.open("res://data.json", FileAccess.READ)
    var contents: String = file.get_as_text()
    self._data = JSON.parse_string(contents).get("rounds", [])

    self._load_round()


func _load_round() -> void:
    self._question_grid.load(self._data[self._round])


func _on_next_round_button_pressed() -> void:
    self._question_grid.clear_grid()
    self._round += 1
    self._load_round()


func _on_question_grid_question_pressed(data: Dictionary) -> void:
    self._host_window.load(data)
