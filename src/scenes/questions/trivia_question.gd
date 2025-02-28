class_name TriviaQuestion
extends Question


# Trivia
@onready var _answer_button := %AnswerButton
@onready var _answer_container := %AnswerContainer
@onready var _answer_label := %AnswerLabel
@onready var _answer_texture := %AnswerTexture
@onready var _question_label := %QuestionLabel
@onready var _question_texture := %QuestionTexture


func _ready() -> void:
    super()
    self._answer_button.pressed.connect(self._on_answer_button_pressed)


func load(data: Dictionary, column_label: String, row_label: String) -> void:
    super(data, column_label, row_label)

    self._question_label.text = data.get("question", "Question not found")
    self._answer_label.text = data.get("answer", "Answer not found")

    var question_texture_file: String = data.get("question_filename", "")
    if question_texture_file:
        var image: Image = Image.load_from_file(question_texture_file)
        var texture: Texture2D = ImageTexture.create_from_image(image)
        self._question_texture.texture = texture

    var answer_texture_file: String = data.get("answer_filename", "")
    if answer_texture_file:
        var image: Image = Image.load_from_file(answer_texture_file)
        var texture: Texture2D = ImageTexture.create_from_image(image)
        self._answer_texture.texture = texture


func show_question() -> void:
    super()

    self._resize_texture(self._question_texture)
    self._resize_texture(self._answer_texture)


func _on_answer_button_pressed() -> void:
    self._answer_button.set_visible(false)
    self._answer_container.set_visible(true)

    if self._answer_texture.texture:
        self._answer_texture.set_visible(true)
