//
//  ValidationResult.swift
//  JadeIsland
//
//  Created by Jeff on 2018/10/20.
//  Copyright © 2018 jf. All rights reserved.
//

import UIKit

//验证结果和信息的枚举
enum ValidationResult {
    case validating  //正在验证中s
    case empty  //输入为空
    case ok(message: String) //验证通过
    case failed(message: String)  //验证失败
}

//扩展ValidationResult，对应不同的验证结果返回验证是成功还是失败
extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .ok(message: "验证通过"):
            return true
        default:
            return false
        }
    }
}

//扩展ValidationResult，对应不同的验证结果返回不同的文字描述
extension ValidationResult {
    var description: String {
        switch self {
        case .validating:
            return "正在验证..."
        case .empty:
            return ""
        case .ok(let message):
            return message
        case .failed(let message):
            return message
        }
    }
}

//扩展ValidationResult，对应不同的验证结果返回不同的文字颜色
extension ValidationResult {
    var textColor: UIColor {
        switch self {
        case .validating:
            return UIColor.gray
        case .empty:
            return UIColor.black
        case .ok( _):
            return UIColor(red: 0/255, green: 130/255, blue: 0/255, alpha: 1) //RGB都需要除以255
        case .failed( _):
            return UIColor.red
        }
}
}

