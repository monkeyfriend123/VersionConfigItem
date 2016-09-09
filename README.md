# VersionConfigItem
app 版本 和 指定的版本号 关系的一个操作工具


1.用法

let maskItem = VersionConfigItem(identity: "id2", relation: .LessThanOrEqual, version: "2.0")
print(maskItem.flag)
        
self.maskItem = maskItem
self.maskItem?.operateValue = true //会将值存到userdefault 中， key 就是上面的identity
