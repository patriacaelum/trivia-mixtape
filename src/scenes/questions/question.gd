class_name Question
extends CanvasLayer


signal completed


@onready var _back_button := %BackButton
@onready var _header_container := %HeaderContainer


func _ready() -> void:
    assert(self._back_button != null, "Question requires back button!")
    assert(self._header_container != null, "Question requires header container!")

    self._back_button.pressed.connect(self._on_back_button_pressed)


func load(data: Dictionary, column_label: String, row_label: String) -> void:
    self._header_container.column_label = column_label
    self._header_container.row_label = row_label


func show_question() -> void:
    self.set_visible(true)


func _resize_texture(texture: TextureRect) -> void:
    if not texture.texture:
        return

    await self.get_tree().process_frame
    await self.get_tree().process_frame

    var target_size: float = 480.0
    var current_size: float = max(texture.texture.get_width(), texture.texture.get_height())
    var scale_factor: float = target_size / current_size

    texture.set_scale(Vector2(scale_factor, scale_factor))


func _on_back_button_pressed() -> void:
    self.set_visible(false)
    self.completed.emit()
