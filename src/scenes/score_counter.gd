class_name ScoreCounter
extends HBoxContainer


@onready var _minus_button := %MinusButton
@onready var _plus_button := %PlusButton
@onready var _score_label := %ScoreLabel

var _score: int = 0


func _ready() -> void:
    self._minus_button.pressed.connect(self._on_minus_button_pressed)
    self._plus_button.pressed.connect(self._on_plus_button_pressed)


func _update_score_label() -> void:
    self._score_label.text = "%d" % self._score


func _on_minus_button_pressed() -> void:
    self._score -= 1
    self._update_score_label()


func _on_plus_button_pressed() -> void:
    self._score += 1
    self._update_score_label()
