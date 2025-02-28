class_name QuestionGrid
extends VBoxContainer


signal question_pressed(data: Dictionary)


@onready var _grid_container := %GridContainer
@onready var _round_label := %RoundLabel

var _base: int = 1
var _labels: Array[AspectRatioContainer] = []
var _multiplier: float = 1.0
var _ncols: int = 0
var _nrows: int = 0
var _questions: Dictionary = {}     # Dictionary[int, Array[QuestionButton]]
var _question_button_scene := preload("res://scenes/question_button.tscn")
var _question_column_scene := preload("res://scenes/question_column.tscn")


func clear_grid() -> void:
    for questions in self._questions.values():
        for question in questions:
            self._grid_container.remove_child(question)
            question.queue_free()

    for label in self._labels:
        self._grid_container.remove_child(label)
        label.queue_free()

    self._questions.clear()
    self._labels.clear()
    self._ncols = 0
    self._nrows = 0


func load(data: Dictionary) -> void:
    self._round_label.text = data.get("name")
    self._base = data.get("base", self._base)
    self._multiplier = data.get("multiplier", self._multiplier)
    self._load_columns(data)
    self._create_grid()


func _create_grid() -> void:
    self._grid_container.columns = self._ncols

    for label in self._labels:
        self._grid_container.add_child(label)

    for row in range(self._nrows):
        for col in range(self._ncols):
            self._grid_container.add_child(self._questions[col][row])


func _load_columns(data: Dictionary) -> void:
    var column_number: int = 0

    for column_data in data.get("columns", []):
        var label := self._question_column_scene.instantiate()
        label.text = column_data.get("name")
        self._labels.append(label)
        self._questions[column_number] = []
        self._load_questions(column_data, column_number)

        column_number += 1

    self._ncols = column_number


func _load_questions(column_data: Dictionary, column_number: int) -> void:
    var question_number: int = 0

    for question_data in column_data.get("questions", []):
        var question: QuestionButton = self._question_button_scene.instantiate()
        question.text = str(self._base * (question_number + 1) * self._multiplier)
        question.load(question_data, column_data.get("name"))
        self._questions[column_number].append(question)
        question.question_pressed.connect(self._on_question_pressed)

        question_number += 1

    self._nrows = max(question_number, self._nrows)


func _on_question_pressed(data: Dictionary) -> void:
    self.question_pressed.emit(data)
