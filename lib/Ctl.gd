# ========================================================
# 名称：Ctl
# 类型：静态函数库
# 简介：控件节点生成函数库
# 作者：巽星石
# Godot版本：4.1-stable (official)
# 创建时间：2023-08-04 01:37:41
# 最后修改时间：2023年8月4日2023年8月4日03:23:42
# ========================================================
class_name Ctl

# 选择框
static func select(items:PackedStringArray,name:String = "select") -> OptionButton:
	var ctl = OptionButton.new()
	ctl.name = name
	for item in items:
		if item == "---":
			ctl.add_separator()
		elif item.begins_with("---") and item != "---":
			ctl.add_separator(item.replace("---",""))
		else:
			ctl.add_item(item)
	return ctl

# 数字微调框
static func spin(min:float = 0.0,max:float = 100.0,step:float =1.0,name:String = "spin") -> SpinBox:
	var ctl = SpinBox.new()
	ctl.name = name
	ctl.min_value = min
	ctl.max_value = max
	ctl.step = step
	return ctl

# 单行文本框
static func text(placeholder:String="",text:String = "",name:String = "text") -> LineEdit:
	var ctl = LineEdit.new()
	ctl.name = name
	ctl.text = text
	ctl.placeholder_text = placeholder
	return ctl

# 多行文本框
static func textArea(placeholder:String="",text:String = "",name:String = "textArea") -> TextEdit:
	var ctl = TextEdit.new()
	ctl.name = name
	ctl.text = text
	ctl.placeholder_text = placeholder
	return ctl

# 标签
static func label(text:String,tool_tip:String="",name:String = "label") -> Label:
	var ctl = Label.new()
	ctl.name = name
	ctl.text = text
	ctl.tooltip_text = tool_tip
	return ctl

# 按钮
static func button(text:String,tool_tip:String="",name:String = "button") -> Button:
	var ctl = Button.new()
	ctl.name = name
	ctl.text = text
	ctl.tooltip_text = tool_tip
	return ctl

# 超链接
static func link(text:String,url:String,tool_tip:String="",name:String = "link") -> LinkButton:
	var ctl = LinkButton.new()
	ctl.name = name
	ctl.text = text
	ctl.tooltip_text = tool_tip
	ctl.set_meta("url",url)
	return ctl

# 复选框
static func checkBox(text:String,tool_tip:String="",name:String = "ckeck") -> CheckBox:
	var ctl = CheckBox.new()
	ctl.name = name
	ctl.text = text
	ctl.tooltip_text = tool_tip
	return ctl


# =================================== 布局 ===================================
# 布局函数
static func layout(ctls:Array,name:String = "layout") -> VBoxContainer:
	var vbox = VBoxContainer.new()
	vbox.name = name
	fill_x(vbox)
	# 加载行
	for row in ctls:
		if row.size() == 1:
			vbox.add_child(row[0],true)
			fill_x(row[0])
		elif row.size() > 1:
			var hbox = HBoxContainer.new()
			fill_x(hbox)
			for ct in row:
				hbox.add_child(ct,true)
				fill_x(ct)
			vbox.add_child(hbox,true)
	return vbox

# 设置layout及其所有子结点的owner - 用于插件或EditorScript添加
static func set_layout_owner(layout:Node,owner:Node) -> void:
	layout.owner = owner
	for child in layout.get_children():
		child.owner = owner
		set_layout_owner(child,owner)
# =================================== 撑开 ===================================
# 水平撑开
static func fill_x(ctl:Control) -> void:
	ctl.size_flags_horizontal = Control.SIZE_EXPAND_FILL

# 垂直撑开
static func fill_y(ctl:Control) -> void:
	ctl.size_flags_vertical = Control.SIZE_EXPAND_FILL

# 水平+垂直撑开
static func fill(ctl:Control) -> void:
	ctl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	ctl.size_flags_vertical = Control.SIZE_EXPAND_FILL
