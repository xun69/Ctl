# layout_hsplit
```swift
@tool
extends EditorScript

func _run():
	var layout = Ctl.layout([
		[Ctl.label("测试",HORIZONTAL_ALIGNMENT_CENTER)],
		[Ctl.label("姓名"),Ctl.tex t("请输入姓名")],
		[Ctl.label("性别"),Ctl.select(["男","女"])],
		[Ctl.layout([
			[Ctl.label("布局嵌套",HORIZONTAL_ALIGNMENT_CENTER)],
			[Ctl.label("试试"),Ctl.text("请输入123")]
		])],
		[Ctl.button("提交"),Ctl.button("清除")],
		[Ctl.link("在线说明","https://www.bilibili.com/")]
	])
	
	var txt = Ctl.textArea("请输入数据")
	Ctl.fill_x(txt)
	var layout_hsplit = Ctl.layout_hsplit(layout,txt)
	
	
	get_scene().add_child(layout_hsplit)
	Ctl.set_layout_owner(layout_hsplit,get_scene())
```
![image.png](https://cdn.nlark.com/yuque/0/2023/png/8438332/1691317060664-4bd7b95f-b678-4aae-9266-8ee8fbc34350.png#averageHue=%23435d25&clientId=u9d3c75de-6e98-4&from=paste&height=487&id=uf8be9a86&originHeight=1218&originWidth=2446&originalType=binary&ratio=2.5&rotation=0&showTitle=false&size=252743&status=done&style=none&taskId=u2c62ccd5-15e3-45e5-9dee-2761833aa55&title=&width=978.4)

![image.png](https://cdn.nlark.com/yuque/0/2023/png/8438332/1691317080171-c6ba4dcb-2217-4a8b-a65e-b722a2586279.png#averageHue=%23474646&clientId=u9d3c75de-6e98-4&from=paste&height=464&id=u9d2e0369&originHeight=1159&originWidth=1938&originalType=binary&ratio=2.5&rotation=0&showTitle=false&size=82445&status=done&style=none&taskId=u3599110c-deb2-4cce-bffd-27e93e7f53e&title=&width=775.2)

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
	
	var txt = Ctl.textArea("请输入数据")
	txt.custom_minimum_size.x = 200
	var layout_hsplit = Ctl.layout_hsplit(layout,txt)
	
	
	get_scene().add_child(layout_hsplit)
	Ctl.set_layout_owner(layout_hsplit,get_scene())
```
![image.png](https://cdn.nlark.com/yuque/0/2023/png/8438332/1691317274171-b1fd7f77-2500-4317-9379-407dcd1bab16.png#averageHue=%2398ec9e&clientId=u9d3c75de-6e98-4&from=paste&height=497&id=u0594107a&originHeight=1243&originWidth=2492&originalType=binary&ratio=2.5&rotation=0&showTitle=false&size=271730&status=done&style=none&taskId=u75611aeb-4e00-427a-9490-8bbf1c26ce1&title=&width=996.8)