//
//  RegisterViewController.swift
//  JadeIsland
//
//  Created by Jeff on 2018/10/20.
//  Copyright © 2018 jf. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /// 密码校验
    /// --密码同时包含6~18位数字和大小写字母，不包含特殊字符的判断方法（正则表达式）
    /// - Parameter string: 包含字母和数字 最多只有6-16位数
    func isPassword(password: String) {
        // 最多只有6-16位数
        let allRegex: NSPredicate = NSPredicate(format: "SELF MATCHES %@", "^[\\x21-\\x7E]{6,16}$")
        // 包含数字
        let numberRegex:NSPredicate = NSPredicate(format: "SELF MATCHES %@", "^.*[0-9]+.*$")
        // 包含字母
        let letterRegex:NSPredicate = NSPredicate(format: "SELF MATCHES %@", "^.*[A-Za-z]+.*$")
        if numberRegex.evaluate(with: password) && letterRegex.evaluate(with: password) {
            print("请包含包含字母和数字\(password)") // 包含字母和数字
            if allRegex.evaluate(with: password) {
                print("最多只有6-16位数\(password)") //
            }
        }
    }
    
    
}
