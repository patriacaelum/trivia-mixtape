class_name CategoryQuestion
extends Question


@onready var _grid_container := %GridContainer
@onready var _question_label := %QuestionLabel
@onready var _left_category := %LeftCategory
@onready var _right_category := %RightCategory

var _color_button_scene := preload("res://scenes/questions/category_button.tscn")


func _ready() -> void:
    super()


func load(data: Dictionary, column_label: String, row_label: String) -> void:
    super(data, column_label, row_label)

    self._question_label.text = data.get("question", "Question not found")

    var categories: Dictionary = data.get("categories", {})
    self._left_category.text = categories.get("left", "Category not found")
    self._right_category.text = categories.get("right", "Category not found")

    var choices: Dictionary = data.get("choices", {})
    var keys: Array = choices.keys()
    keys.shuffle()

    for choice in keys:
        var button: CategoryButton = self._color_button_scene.instantiate()
        self._grid_container.add_child(button)

        if not button.is_node_ready():
            await button.ready

        button.text = choice

        var category: Variant = choices[choice]

        if category == "left":
            var stylebox: StyleBox = self._left_category.get_theme_stylebox("normal")
            button.bg_color = stylebox.bg_color
        elif category == "right":
            var stylebox: StyleBox = self._right_category.get_theme_stylebox("normal")
            button.bg_color = stylebox.bg_color
