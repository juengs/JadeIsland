//
//  LoginViewController.swift
//  
//
//  Created by Jeff on 2018/10/20.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var txtUser: UITextField! //用户名输入框
    var txtPwd: UITextField! //密码输入款
    var formView: UIView! //登陆框视图
    var horizontalLine: UIView! //分隔线
    var confirmButton:UIButton! //登录按钮
    var titleLabel: UILabel! //标题标签
    
    var topConstraint: Constraint? //登录框距顶部距离约束

    override func viewDidLoad() {
        super.viewDidLoad()

       //视图背景色
        self.view.backgroundColor = UIColor(red: 1/255, green: 170/255, blue: 235/255, alpha: 1)
        //导航条右边按钮
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(self.actionClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(self.actionClick))
        
        //登录框高度
        let formViewHeight = 90
        //登录框背景
        self.formView = UIView()
        self.formView.layer.borderWidth = 0.5 //边款
        self.formView.layer.borderColor = UIColor.lightGray.cgColor //边框色
        self.formView.backgroundColor = UIColor.white //背景色
        self.formView.layer.cornerRadius = 5 //设置圆角
        self.view.addSubview(formView)
        //formView最常规的设置模式
        self.formView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            //存储top属性
            self.topConstraint = make.centerY.equalTo(self.view).constraint //Y垂直居中约束
            make.height.equalTo(formViewHeight) //高度90
        }
        
        //分隔线
        self.horizontalLine = UIView()
        self.horizontalLine.backgroundColor = UIColor.lightGray
        self.formView.addSubview(horizontalLine)
        self.horizontalLine.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.centerY.equalTo(self.formView)
        }
        
        //用户名图标
        let imgLock1 = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgLock1.image = UIImage(named: "iconfont-user")
        
        //密码图标
        let imgLock2 = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgLock2.image = UIImage(named: "iconfont-password")
        
        //用户名输入框
        self.txtUser = UITextField()
        self.txtUser.delegate = self
        self.txtUser.placeholder = "用户名"
        self.txtUser.tag = 100
        self.txtUser.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        self.txtUser.leftViewMode = UITextField.ViewMode.always
        self.txtUser.returnKeyType = UIReturnKeyType.next
        
        //用户名输入框左侧图标
        self.txtUser.leftView!.addSubview(imgLock1)
        self.formView.addSubview(self.txtUser)
        
        //布局
        self.txtUser.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(44)
            make.centerY.equalTo(self.formView).offset(-formViewHeight/4)
        }
        //密码输入框
        self.txtPwd = UITextField()
        self.txtPwd.delegate = self
        self.txtPwd.placeholder = "密码"
        self.txtPwd.tag = 101
        self.txtPwd.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 44, height: 44))
        self.txtPwd.leftViewMode = .always
        self.txtPwd.returnKeyType = .next
        self.txtPwd.isSecureTextEntry = true
        
        //密码输入框左侧图标
        self.txtPwd.leftView!.addSubview(imgLock2)
        self.formView.addSubview(self.txtPwd)
        
        //布局
        self.txtPwd.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(44)
            make.centerY.equalTo(self.formView).offset(formViewHeight/4)
        }
        //登录按钮
        self.confirmButton = UIButton()
        self.confirmButton.setTitle("登录", for: UIControl.State())
        self.confirmButton.setTitleColor(UIColor.black,
                                         for: UIControl.State())
        self.confirmButton.layer.cornerRadius = 5
        self.confirmButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        self.confirmButton.addTarget(self, action: #selector(loginConfrim),
                                     for: .touchUpInside)
        self.view.addSubview(self.confirmButton)
        self.confirmButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.top.equalTo(self.formView.snp.bottom).offset(20)
            make.right.equalTo(-15)
            make.height.equalTo(44)
        }
        //标题label
        self.titleLabel = UILabel()
        self.titleLabel.text = "登陆个人中心"
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.font = UIFont.systemFont(ofSize: 36)
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.formView.snp.top).offset(-20)
            make.centerX.equalTo(self.view)
            make.height.equalTo(44)
        }
        
        
    }
    
    //输入框获取焦点开始编辑
    func textFieldDidBeginEditing(_ textField:UITextField)
    {
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.topConstraint?.update(offset: -125)
            self.view.layoutIfNeeded()
        })
    }
    
    //输入框返回时操作
    func textFieldShouldReturn(_ textField:UITextField) -> Bool
    {
        let tag = textField.tag
        switch tag {
        case 100:
            self.txtPwd.becomeFirstResponder()
        case 101:
            loginConfrim()
        default:
            print(textField.text!)
        }
        return true
    }
    
    //登录按钮点击
    @objc func loginConfrim(){
        //收起键盘
        self.view.endEditing(true)
        //视图约束恢复初始设置
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.topConstraint?.update(offset: 0)
            self.view.layoutIfNeeded()
        })
        showMessage("登陆成功!")
    }
    
    //注册按钮
    //(导航条右侧)
    @objc func actionClick() {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    

    //详细提示框
    func showMessage(_ message: String) {
        let alertController = UIAlertController(title: nil,
                                                message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let loginAction = UIAlertAction(title: "登陆", style: .default, handler: { (action) in
            self.navigationController?.show(MineViewController(), sender: nil)
        })
        alertController.addAction(okAction)
        alertController.addAction(loginAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
