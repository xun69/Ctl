# layout_vsplit
```swift
@tool
extends EditorScript

func _run():
	var layout = Ctl.layout([
		[Ctl.label("测试",HORIZONTAL_ALIGNMENT_CENTER)],
		[Ctl.label("姓名"),Ctl.text("请输入姓名")],
		[Ctl.label("性别"),Ctl.select(["男","女"])],
		[Ctl.layout([
			[Ctl.label("布局嵌套",HORIZONTAL_ALIGNMENT_CENTER)],
			[Ctl.label("试试"),Ctl.text("请输入123")]
		])],
		[Ctl.button("提交"),Ctl.button("清除")],
		[Ctl.link("在线说明","https://www.bilibili.com/")]
	])
	
	
	Ctl.fill_y(layout)
	var txt = Ctl.textArea("请输入数据")
	txt.custom_minimum_size.y = 100
	var layout_hsplit = Ctl.layout_vsplit(layout,txt)
	
	
	get_scene().add_child(layout_hsplit)
	Ctl.set_layout_owner(layout_hsplit,get_scene())
```
![image.png](https://cdn.nlark.com/yuque/0/2023/png/8438332/1691317629094-5c9a79ec-95ff-4dd6-89db-f49b458fc794.png#averageHue=%23629d57&clientId=u9d3c75de-6e98-4&from=paste&height=476&id=u70199155&originHeight=1191&originWidth=2454&originalType=binary&ratio=2.5&rotation=0&showTitle=false&size=253563&status=done&style=none&taskId=u3a95a0a6-25df-4a27-9839-e109274c1b8&title=&width=981.6)
