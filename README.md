# chinaSchoolPickupView
a china school pickupview with swift 

> English 

well.just click the "弹 出" button and you will see the picUpview

> 中文

亲，打开主页按下"弹 出"按钮就能显示了

> How to use|使用说明

copy the "schoolPickVeiw.swift" and "school.plist" to your project,and the way to use is 👇
将"schoolPickVeiw.swift"和"school.plist"文件拖到自己工程，用下面的代码调用就行

```
let tempData = UIScreen.mainScreen().bounds.size
var pickView = schoolPickupView.init(frame: CGRectMake(20, tempData.height/2-110, tempData.width - 40, 220))
pickView.delegate = self
pickView.show()
```

`Do not forget to let your view impl schoolPickupViewDelegete|切记你调用这个pickView的界面要集成schoolPickupViewDelegete`

> delegate|代理说明

```
pickerDidSelectName
return the school you choose|返回你选择的学校
cancelBtn
return the cancel Action|返回取消的状态
```
