## # 控件节点生成与布局函数库Ctl
## 概述

Godot本身提供了丰富的控件和容器来实现UI布局，但是这个过程往往需要复杂的手动操作和配置，使用代码生成方式时也会需要一大堆代码来创建控件、容器实例，并设置相关的属性。

为了简化控件和容器实例的创建，并快速创建特定的控件布局，我(Bilibili@巽星石)编写了这套控件节点生成和布局函数库并，起名叫Ctl。（后期可能会改名）

这是一个基于Godot4.1的静态函数库，并以全局类注册，所以你可以单独复制`Ctl.gd`到你的项目中，并快速的开始使用它。

## 文档目录

- [表单数据获取和修改.md](./doc/表单数据获取和修改.md) 
- [label的水平和垂直对齐设定.md](./doc/label的水平和垂直对齐设定.md) 
- [layout_hsplit.md](./doc/layout_hsplit.md) 
- [layout_vsplit.md](./doc/layout_vsplit.md) 
- [layout简化写法.md](./doc/layout简化写法.md) 

## 简单示例

这里我们以一个EditorScript为例，编写如下代码：

```swift
# test01.gd

@tool
extends EditorScript

func _run():
	# 创建布局实例
	var layout = Ctl.layout([
		[Ctl.label("测试")],
		[Ctl.label("姓名"),Ctl.text("请输入姓名")],
		[Ctl.label("性别"),Ctl.select(["男","女"])],
		[Ctl.button("提交"),Ctl.button("清除")]
	])
	get_scene().add_child(layout) # 将布局添加到当前场景根节点
	Ctl.set_layout_owner(layout,get_scene()) # 设置布局的owner
```
创建一个UI场景，运行脚本后，会在当前场景生成和添加如下的内容：

<img src="https://cdn.nlark.com/yuque/0/2023/png/8438332/1691088447255-deac828a-2066-4109-9bbd-325e8a11e8c4.png#averageHue=%2387e28e&clientId=ue96141fa-378e-4&from=paste&height=358&id=u3feef7ad&originHeight=894&originWidth=1681&originalType=binary&ratio=2.5&rotation=0&showTitle=true&size=240784&status=done&style=none&taskId=u2a9bf5cf-cbee-4627-8f75-3368d2af31d&title=%E6%B7%BB%E5%8A%A0%E5%88%B0%E5%9C%BA%E6%99%AF&width=672.4" alt="添加到场景" title="添加到场景" style="zoom:33%;" />

可以看到这类似于创建了一个表单。而这就是Ctl这个库的基本用法了。它可以大大的简化一些表单布局的描述和创建。运行后可以看到一个基本可交互的表单。

<img src="https://cdn.nlark.com/yuque/0/2023/png/8438332/1691089063482-3bdeb891-f055-41ee-9bf8-77aa81b3a24a.png#averageHue=%23454545&clientId=ua2195754-944d-4&from=paste&height=172&id=u187b6c9e&originHeight=430&originWidth=1224&originalType=binary&ratio=2.5&rotation=0&showTitle=true&size=51479&status=done&style=none&taskId=ua14070ad-0597-4734-8af5-007eb7ca814&title=%E8%BF%90%E8%A1%8C%E5%90%8E%E6%95%88%E6%9E%9C&width=489.6" alt="运行后效果" title="运行后效果" style="zoom:33%;" />

#### layout方法

查看上面例子的代码，可以看到我们调用`Ctl`函数库的`layout`方法，并传入了一个二维数组，它将创建并返回一个竖向布局的`VBoxContainer`。

```swift
layout(ctls:Array,name:String = "layout") -> VBoxContainer
```

`layout`方法有两个参数，第一个参数传入一个二维数组，用于描述所需生成的控件。第二个参数传入返回的VBoxContainer节点的名称。

`ctls`参数传入一个二维数组，其规则是：

- 布局的每一行用一个数组子元素表示
- 整个布局由上到下，描述VBoxContainer的多行布局
- 每行中可以有一个或多个控件实例，可以是Ctl的节点生成函数生产的控件，也可以是自定义代码创建的控件实例。
- 行中如果有一个控件，则会自动占据行的全部宽度，如果有一个以上的控件，则会自动均分。
- 行的元素可以是`Ctl.layout()`生成的子布局，因此可以实现复杂的元素嵌套。

### 嵌套布局

通过在行中使用Ctl.layout()生成子布局，可以实现布局的嵌套。

```swift
@tool
extends EditorScript

func _run():
	var layout = Ctl.layout([
		[Ctl.label("测试")],
		[Ctl.label("姓名"),Ctl.text("请输入姓名")],
		[Ctl.label("性别"),Ctl.select(["男","女"])],
		[Ctl.layout([
			[Ctl.label("布局嵌套")],
			[Ctl.label("试试"),Ctl.text("请输入123")]
		])],
		[Ctl.button("提交"),Ctl.button("清除")],
		[Ctl.link("在线说明","https://www.bilibili.com/")]
	])
	
	
	get_scene().add_child(layout)
	Ctl.set_layout_owner(layout,get_scene())
```
<img src="https://cdn.nlark.com/yuque/0/2023/png/8438332/1691090648609-f332d7c4-a79e-40ee-8566-0ced380bfcef.png#averageHue=%2392e498&clientId=ua2195754-944d-4&from=paste&height=460&id=ufb3029a9&originHeight=1149&originWidth=1845&originalType=binary&ratio=2.5&rotation=0&showTitle=false&size=334541&status=done&style=none&taskId=u668a1dd2-d499-4ec3-9e52-00468bc2ae5&title=&width=738" alt="image.png" style="zoom:33%;" />

## 运行场景时动态生成

上面使用EditorScript的方式可以辅助布局的生成，非常适合作为设计阶段的辅助，可以方便进一步修改控件样式，创建脚本等。并且很容易基于这个函数库开发相应的Godot编辑器插件。

有时候我们可能需要在场景运行时通过_ready用脚本生成布局和控件，并绑定和处理相应控件的信号。

比如我们创建一个新的UI场景，并添加如下代码：

```swift
# test_02.gd
extends Control


func _ready():
	# 创建布局实例
	var layout = Ctl.layout([
		[Ctl.label("测试")],
		[Ctl.label("姓名"),Ctl.text("请输入姓名")],
		[Ctl.label("性别"),Ctl.select(["男","女"])],
		[Ctl.button("提交"),Ctl.button("清除")]
	])
	# 将布局添加到场景
	add_child(layout,true)
```

运行后，可以看到布局和控件已经正常显示：

<img src="./readme.assets/image-20231010233002217.png" alt="image-20231010233002217" style="zoom:33%;" />

为了进一步处理其中比较重要的输入控件和按钮，你可以将代码改写如下：

- 创建存储输入控件和按钮引用的全局变量
- 在Ctl.layout的行中使用上面创建的全局变量
- 在_ready()中创建布局，并链接和处理输入控件和按钮的信号

```swift
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
```

运行后，点击“保存”按钮，你将在输出面板看到打印的字符串信息。

基于此，你可以创建可以被正确响应的生成式表单。

### 应用于自定义节点

对于Godot自定义节点，普通的基础类型扩展不涉及复杂的内部布局，但是对于复杂的自定义节点，肯定会涉及容器和控件的动态生成以及布局问题。

## 展望

目前（截止到2023年10月10日）实现的版本都是最初始化的版本，因为独立的项目化和GitHub开源，我将继续在原来的版本基础上做很多改进，这可能涉及很大的改变，其中一些功能是我迫切想实现的：

- [ ] **控件的layout属性**：基于某种纯文本格式，描述布局，并动态生成和显示
- [ ] **布局的字典描述形式**：可以省略Ctl.label()的调用，字典的键直接用于生成Label实例
- [ ] **表单的序列化和反序列化**：可以通过调用函数快速生成表单的字典描述格式或者JSON形式，反之，也可以从字典或JSON形式生成
- [ ] **数据存储和读取**：可以以函数形式快速生成和保存ConfigFile,用于存储表单的设置信息，反之，也可以读取并应用设定数据。
- [ ] **实现更多的控件和布局函数**：