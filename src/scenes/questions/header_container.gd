class_name HeaderContainer
extends HBoxContainer


@onready var _column_label := %ColumnLabel
@onready var _row_label := %RowLabel

var column_label: String:
    set(value):
        self._column_label.text = value
var row_label: String:
    set(value):
        self._row_label.text = value
