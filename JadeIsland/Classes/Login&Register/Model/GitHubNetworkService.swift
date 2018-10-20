//
//  GitHubNetworkService.swift
//  JadeIsland
//
//  Created by Jeff on 2018/10/20.
//  Copyright © 2018 jf. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class GitHubNetworkService {
    //验证用户是否存在
    func usernameAvalible(_ username: String) -> Observable<Bool> {
        //通过检查这个用户的GitHub主页是否存在来判断用户是否存在 //查询数据库判断是否存在
        let url = URL(string: "https://github.com/\(username.URLEscaped)")!
        let request = URLRequest(url: url)
        return URLSession.shared.rx.response(request: request)
            .map { (pair) in
                return pair.response.statusCode == 404
            } .catchErrorJustReturn(false)
    }
    
    //注册用户
    func signup(_ username:String, Password:String) -> Observable<Bool> { //观察者
        //这里我们没有真正去发起请求，而是模拟这个操作（平均每3次有1次失败）
        let signupResult = arc4random() % 3 == 0 ? false : true
        return Observable.just(signupResult)
        .delay(1.5, scheduler: MainScheduler.instance) //结果延迟1.5秒返回
    }
    
    
}

//扩展String
extension String {
    //字符串的url地址转义
    var URLEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "" //默认值
    }
}
