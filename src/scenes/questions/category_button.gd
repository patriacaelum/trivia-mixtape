class_name CategoryButton
extends Button


const BLACK_DIM = Color(0, 0, 0, 0.12)
const GRAY_DIM = Color(0.745098, 0.745098, 0.745098, 0.12)


var bg_color: Color:
    set(value):
        self._bg_colors[1] = value
var _color_index: int = 0
var _bg_colors: Array[Color] = [GRAY_DIM, BLACK_DIM, BLACK_DIM]


func _ready() -> void:
    self.pressed.connect(self._on_pressed)
    self._set_color()


func _set_color() -> void:
    var stylebox: StyleBox = self.get_theme_stylebox("normal").duplicate()
    stylebox.bg_color = self._bg_colors[self._color_index]
    stylebox.border_color = self._bg_colors[self._color_index]

    self.remove_theme_stylebox_override("normal")
    self.add_theme_stylebox_override("normal", stylebox)
    self.add_theme_stylebox_override("hover", stylebox)
    self.add_theme_stylebox_override("focus", stylebox)


func _on_pressed() -> void:
    self._color_index = (self._color_index + 1) % len(self._bg_colors)
    self._set_color()
