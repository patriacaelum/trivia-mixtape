class_name HostWindow
extends Window


@onready var _answer_label := %AnswerLabel
@onready var _description_label := %DescriptionLabel
@onready var _question_label := %QuestionLabel


func load(data: Dictionary) -> void:
    self._question_label.text = "Question: %s" % data.get("question")
    self._answer_label.text = "Answer: %s" % data.get("answer")
    self._description_label.text = "Description: %s" % data.get("description")
