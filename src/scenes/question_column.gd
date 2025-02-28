class_name QuestionColumn
extends AspectRatioContainer


@onready var _question_column := %QuestionColumn


var text: String:
    get:
        return self._question_column.text
    set(value):
        if not self.is_node_ready():
            await self.ready

        self._question_column.text = value
