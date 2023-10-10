@tool
extends EditorScript

func _run():
	var layout = Ctl.layout([
		[Ctl.label("测试")],
		[Ctl.label("姓名"),Ctl.text("请输入姓名")],
		[Ctl.label("性别"),Ctl.select(["男","女"])],
		[Ctl.button("提交"),Ctl.button("清除")]
	])
	get_scene().add_child(layout)
	Ctl.set_layout_owner(layout,get_scene())
