//
//  MyTabBarController.swift
//  JadeIsland
//
//  Created by Jeff on 2018/7/28.
//  Copyright © 2018 fengqian. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 打印 底部导航-按钮
        //print(tabBar.subviews)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 搭建框架
        let tabbar = UITabBar.appearance()
        tabbar.tintColor = UIColor(red: 245 / 255.0, green: 90 / 255.0, blue: 93 / 255.0, alpha: 1.0)
        // 添加子控制器
        addChildViewControllers()
    }
    
    /// 添加子控制器
    func addChildViewControllers() {
        setChildViewController(LoginViewController(), title: "首页", imageName: "home_tabBar", selectedImageName: "home_tabBar_selected")
        setChildViewController(RegisterViewController(), title: "投资", imageName: "financial_tabBar", selectedImageName: "financial_tabBar_selected")
        setChildViewController(SMSValidViewController(), title: "会员", imageName: "more_tabBar", selectedImageName: "more_tabBar_selected")
        setChildViewController(MineViewController(), title: "我的", imageName: "mine_tabBar", selectedImageName: "mine_tabBar_selected")
        // tabBar 是 readonly 属性，不能直接修改，利用 KVC 把 readonly 属性的权限改过来
        //        setValue(MyTabBar(), forKey: "tabBar")
        
    }
    
    /// 初始化子控制器
    private func setChildViewController(_ childController: UIViewController, title: String, imageName: String, selectedImageName: String){
        // 设置 TabBar 文字与图片 日间
        //   setDayChildController(controller: childController, imageName: imageName)
        // 设置 tabbar 文字和图片
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        childController.title = title
        // 添加导航控制器为 TabBarController 的子控制器
        //let navVc = UINavigationController(rootViewController: childController)
        let navVc = MyNavigationController(rootViewController: childController)
        addChild(navVc)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
