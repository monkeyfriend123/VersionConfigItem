//
//  MaskItem.swift
//  MaskGuidKit
//
//  Created by js on 16/9/9.
//  Copyright © 2016年 js. All rights reserved.
//

import Foundation

public enum Relation: Int{
    case LessThanOrEqual
    case Equal
    case GreatThanOrEqual
}


private let appVersion: String = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String ?? "0"

public struct VersionConfigItem {
    public let identity: String
    
    public let relation: Relation

    /** app 的版本号 和 version 在 relation 关系下，来判断是否显示遮罩 */
    public let version: String
    
    /** true: 已经显示过这个遮罩选项*/
    public var operateValue: Bool?{
        didSet{
            let userDefaults = NSUserDefaults.standardUserDefaults()
            if operateValue != nil && operateValue!{
                userDefaults.setObject(appVersion, forKey: identity)
            }
            else{
                userDefaults.removeObjectForKey(identity)
            }
            
            userDefaults.synchronize()
        }
    }
    
    
    public init(identity: String, relation: Relation, version: String, operateValue: Bool? = nil){
        self.identity = identity
        self.relation = relation
        self.version = version
        self.operateValue = operateValue ?? (NSUserDefaults.standardUserDefaults().objectForKey(identity) != nil ? true : nil)
    }
}


extension VersionConfigItem{
    /** operateValue 为false 或者app version 和 version 满足 relation 条件
     * (例如 在做蒙层的时候需要显示用途)
     */
    public var flag: Bool{
        //1. 如果有操作值，用值来判断
        if let operateValue = operateValue{
            return !operateValue
        }
        
        //2. 根据要求判断
        return appVersion.compareVersion(version,relation: relation)
        
    }
}

extension String{
    //返回 是否为真
    func compareVersion(otherString: String,relation: Relation) -> Bool{
        let components = self.componentsSeparatedByString(".")
        let components2 = otherString.componentsSeparatedByString(".")
        
        for index in 0..<min(components.count, components2.count){
            let value1 = Int(components[index])
            let value2 = Int(components2[index])
            switch relation {
                case .LessThanOrEqual:
                    if value1 < value2{
                        return true
                    } else if value1 > value2{
                        return false
                    }
                case .Equal:
                    if value1 != value2{
                        return false
                    }
                case .GreatThanOrEqual:
                    if value1 < value2{
                        return false
                    }
           
            }

        }
        
        switch relation {
            case .LessThanOrEqual:
                return components.count <= components2.count
            case .Equal:
                return components.count == components2.count
            case .GreatThanOrEqual:
                return components.count >= components2.count
            
        }
    }
}