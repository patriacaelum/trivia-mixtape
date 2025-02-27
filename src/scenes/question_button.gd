class_name QuestionButton
extends Button


signal question_pressed(data: Dictionary)


var _data: Dictionary = {}
var _question: Question = null
var _question_scene := {
    "category": preload("res://scenes/questions/category_question.tscn"),
    "trivia": preload("res://scenes/questions/trivia_question.tscn"),
    "zoom": preload("res://scenes/questions/zoom_question.tscn"),
}


func _ready() -> void:
    self.pressed.connect(self._on_pressed)


func load(data: Dictionary, column_label: String) -> void:
    self._data = data
    var question_type: String = data.get("type")

    if not self._question_scene.has(question_type):
        print("Unable to create question of type ", question_type)
        return

    self._question = self._question_scene[question_type].instantiate()
    self.add_child(self._question)

    if not self._question.is_node_ready():
        await self._question.ready

    self._question.set_visible(false)
    self._question.load(data, column_label, self.text)


func _on_pressed() -> void:
    self.set_disabled(true)
    self._question.set_visible(true)

    self.question_pressed.emit(self._data)
