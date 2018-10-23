//
//  RegisterViewController.swift
//  JadeIsland
//
//  Created by Jeff on 2018/10/20.
//  Copyright © 2018 jf. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

// 扩展UILabel
// 让 ValidationResult 能绑定到 label 上
extension Reactive where Base: UILabel {
    //让验证结果（ValidationResult类型）可以绑定到label上
    var validationResult: Binder<ValidationResult> {
        return Binder(base) { label, result in
            label.textColor = result.textColor
            label.text = result.description
        }
    }
}

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    var txtUser: UITextField! //用户名输入框
    var txtPwd: UITextField! //密码输入款
    var formView: UIView! //注册框视图
    var horizontalLine: UIView! //分隔线
    var confirmButton:UIButton! //注册按钮
    var titleLabel: UILabel! //标题标签
    
    //再次输入密码
    var txtRepeatedPwd: UITextField!
    var horizontalLine2: UIView! //分隔线
    //用于提示校验结果的label
    var userLabel: UILabel! //用户名提示label
    var passwordLabel: UILabel! //密码提示label
    var repeatedPwdLabel: UILabel! //再次输入密码,必须有值
    
    var topConstraint: Constraint? //注册框距顶部距离约束
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        //视图背景色
        self.view.backgroundColor = UIColor(red: 1/255, green: 170/255, blue: 235/255, alpha: 1)
        //登录框高度
        let formViewHeight = 270
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
            make.height.equalTo(formViewHeight) //高度45*6=270
        }
        
        //用户名图标
        let imgLock1 = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgLock1.image = UIImage(named: "iconfont-user")
        
        //密码图标
        let imgLock2 = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgLock2.image = UIImage(named: "iconfont-password")
        
        //再次输入密码图标
        let imgLock3 = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgLock3.image = UIImage(named: "iconfont-password")
        
        //用户名输入框
        self.txtUser = UITextField()
        self.txtUser.delegate = self
        self.txtUser.placeholder = "请输入您的手机号"
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
            make.top.equalToSuperview()
        }
        
        // 用户名提示label
        userLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        userLabel.font = UIFont(name: "Zapfino", size: 15)
        userLabel.lineBreakMode = .byTruncatingTail  //隐藏尾部并显示省略号
        userLabel.lineBreakMode = .byTruncatingMiddle  //隐藏中间部分并显示省略号
        userLabel.lineBreakMode = .byTruncatingHead  //隐藏头部并显示省略号
        userLabel.lineBreakMode = .byClipping  //截去多余部分也不显示省略号
        userLabel.adjustsFontSizeToFitWidth = true
        userLabel.isHighlighted = true
        //userLabel.highlightedTextColor = UIColor.red
        //add
        formView.addSubview(userLabel)
        //布局
        userLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(30)
            make.top.equalTo(txtUser.snp.bottom)
        }
        
        //分隔线1
        self.horizontalLine = UIView()
        self.horizontalLine.backgroundColor = UIColor.lightGray
        self.formView.addSubview(horizontalLine)
        self.horizontalLine.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(userLabel.snp.bottom)
        }
        
        //密码输入框
        self.txtPwd = UITextField()
        self.txtPwd.delegate = self
        self.txtPwd.placeholder = "请输入个人密码"
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
            make.centerY.equalTo(self.formView).offset(-22)
        }
        
        // 密码提示label
        passwordLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        passwordLabel.font = UIFont(name: "Zapfino", size: 15)
        passwordLabel.lineBreakMode = .byTruncatingTail  //隐藏尾部并显示省略号
        passwordLabel.lineBreakMode = .byTruncatingMiddle  //隐藏中间部分并显示省略号
        passwordLabel.lineBreakMode = .byTruncatingHead  //隐藏头部并显示省略号
        passwordLabel.lineBreakMode = .byClipping  //截去多余部分也不显示省略号
        passwordLabel.adjustsFontSizeToFitWidth = true
        passwordLabel.isHighlighted = true
        //passwordLabel.highlightedTextColor = UIColor.red
        //add
        formView.addSubview(passwordLabel)
        //布局
        passwordLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(30)
            make.top.equalTo(txtPwd).offset(formViewHeight/6)
        }
        //分隔线2
        self.horizontalLine2 = UIView()
        self.horizontalLine2.backgroundColor = UIColor.lightGray
        self.formView.addSubview(horizontalLine2)
        self.horizontalLine2.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            //make.centerY.equalTo(self.passwordLabel).offset(22) // 22+44
            make.top.equalTo(passwordLabel).offset(44)
        }
        
        //再次输入密码输入框
        self.txtRepeatedPwd = UITextField()
        self.txtRepeatedPwd.delegate = self
        self.txtRepeatedPwd.placeholder = "请再次输入密码"
        self.txtRepeatedPwd.tag = 101
        self.txtRepeatedPwd.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 44, height: 44))
        self.txtRepeatedPwd.leftViewMode = .always
        self.txtRepeatedPwd.returnKeyType = .next
        self.txtRepeatedPwd.isSecureTextEntry = true
        
        //密码输入框左侧图标
        self.txtRepeatedPwd.leftView!.addSubview(imgLock3)
        self.formView.addSubview(self.txtRepeatedPwd)
        
        //布局
        self.txtRepeatedPwd.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(44)
            make.centerY.equalTo(self.formView).offset(formViewHeight/6 + 22)
        }
        
        // 重新输入密码提示label
        repeatedPwdLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        repeatedPwdLabel.font = UIFont(name: "Zapfino", size: 15)
        repeatedPwdLabel.lineBreakMode = .byTruncatingTail  //隐藏尾部并显示省略号
        repeatedPwdLabel.lineBreakMode = .byTruncatingMiddle  //隐藏中间部分并显示省略号
        repeatedPwdLabel.lineBreakMode = .byTruncatingHead  //隐藏头部并显示省略号
        repeatedPwdLabel.lineBreakMode = .byClipping  //截去多余部分也不显示省略号
        repeatedPwdLabel.adjustsFontSizeToFitWidth = true
        repeatedPwdLabel.isHighlighted = true
        //repeatedPwdLabel.highlightedTextColor = UIColor.red
        //add
        formView.addSubview(repeatedPwdLabel)
        //布局
        repeatedPwdLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(30)
            make.top.equalTo(txtRepeatedPwd).offset(formViewHeight/6 - 1)
        }
        //注册按钮
        self.confirmButton = UIButton()
        self.confirmButton.setTitle("注册", for: UIControl.State())
        self.confirmButton.setTitleColor(UIColor.black,
                                         for: UIControl.State())
        self.confirmButton.layer.cornerRadius = 5
        self.confirmButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        self.confirmButton.addTarget(self, action: #selector(registerConfirm),
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
        self.titleLabel.text = "注册领取红包"
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.font = UIFont.systemFont(ofSize: 36)
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.formView.snp.top).offset(-20)
            make.centerX.equalTo(self.view)
            make.height.equalTo(44)
        }
        
        //初始化ViewModel
        let viewModel = GitHubSignupViewModel(
            input: (
                username: txtUser.rx.text.orEmpty.asDriver(),
                password: txtPwd.rx.text.orEmpty.asDriver(),
                repeatedPassword: txtRepeatedPwd.rx.text.orEmpty.asDriver(),
                loginTaps: confirmButton.rx.tap.asSignal()
            ),
            dependency: (
                networkService: GitHubNetworkService(),
                signupService: GitHubSignupService()
            )
        )
        
        //用户名验证结果绑定
        viewModel.validatedUsername
        .drive(userLabel.rx.validationResult)
            .disposed(by: disposeBag)
        
        //密码验证结果绑定
        viewModel.validatedPassword.drive(passwordLabel.rx.validationResult)
        .disposed(by: disposeBag)
        
        //再次输入密码验证结果绑定
        viewModel.validatedPasswordRepeated.drive(repeatedPwdLabel.rx.validationResult)
        .disposed(by: disposeBag)
        
        //注册按钮是否可用
        viewModel.signupEnabled
            .drive(onNext: { [weak self] valid  in
                self?.confirmButton.isEnabled = valid
                self?.confirmButton.alpha = valid ? 1.0 : 0.3
            })
            .disposed(by: disposeBag)
        //注册结果绑定
        viewModel.signupResult
            .drive(onNext: { [unowned self] result in
                self.showMessage("注册" + (result ? "成功" : "失败") + "!")
            })
        .disposed(by: disposeBag)
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
            registerConfirm()
        default:
            print(textField.text!)
        }
        return true
    }
    
    // 注册按钮
    @objc func registerConfirm() {
        //收起键盘
        self.view.endEditing(true)
        //视图约束恢复初始设置
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.topConstraint?.update(offset: 0)
            self.view.layoutIfNeeded()
        })
    }
    
    //详细提示框
    func showMessage(_ message: String) {
        let alertController = UIAlertController(title: nil,
                                                message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let loginAction = UIAlertAction(title: "登陆", style: .default, handler: { (action) in
            self.navigationController?.show(VipViewController(), sender: nil)
        })
        alertController.addAction(okAction)
        alertController.addAction(loginAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
