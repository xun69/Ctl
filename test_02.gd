# test_02.gd
extends Control

# 创建变量存储输入控件
var name_txt = Ctl.text("请输入姓名")
var sex_sel = Ctl.select(["男","女"])
var submit_btn = Ctl.button("提交")
var reset_btn = Ctl.button("清除")


func _ready():
	# 创建布局实例
	var layout = Ctl.layout([
		[Ctl.label("测试")],
		[Ctl.label("姓名"),name_txt],
		[Ctl.label("性别"),sex_sel],
		[submit_btn,reset_btn]
	])
	# 将布局添加到场景
	add_child(layout,true)
	# 链接和处理信号
	submit_btn.connect("pressed",func():
		print("你已正确提交数据。")
	)
	
