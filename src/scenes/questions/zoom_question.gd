class_name ZoomQuestion
extends Question


@onready var _color_rect := %ColorRect
@onready var _image_texture := %ImageTexture
@onready var _show_button := %ShowButton
@onready var _zoom_slider := %ZoomSlider


func _ready() -> void:
    super()

    self._show_button.pressed.connect(self._on_show_button_pressed)
    self._zoom_slider.value_changed.connect(self._on_zoom_slider_value_changed)


func load(data: Dictionary, column_label: String, row_label: String) -> void:
    super(data, column_label, row_label)

    var filename: String = data.get("filename")
    var image: Image = Image.load_from_file(filename)
    var texture: Texture2D = ImageTexture.create_from_image(image)
    self._image_texture.texture = texture


func _on_show_button_pressed() -> void:
    self._show_button.set_visible(false)
    await get_tree().process_frame
    await get_tree().process_frame
    self._image_texture.set_scale(Vector2.ONE * 10)
    self._color_rect.set_visible(false)


func _on_zoom_slider_value_changed(value: float) -> void:
    self._image_texture.set_scale(Vector2.ONE * value / 10)
