//
//  HomeModel.swift
//  JadeIsland
//
//  Created by Jeff on 2018/7/29.
//  Copyright © 2018 fengqian. All rights reserved.
//

import Foundation
import HandyJSON

struct NoviceBonus: HandyJSON {
    var cashBackAmount: String = "988.00"
    var cashBackCount: String = "9"
    var experienceAmount: String = "0"
}

struct ActivityList: HandyJSON {
    var pageNum = 1
    var pageSize = 100
    var size = 1
    var orderby = ""
    var startRow = 0
    var endRow = 0
    var total = 0
    
    var title = ""
    var litpic = ""
    var createTime: NSData?
    var artiId = 0
    var showInPageHome = 0
    
    
}

struct HomeBanner: HandyJSON {
 
    var id = 0
    var imgUrl = ""
    var location = ""
    var sort = 9
    var title = ""
    var subtitle = ""
    var shareImagurl = ""
    var shareMainTitle = ""
}

struct RecommendProduct: HandyJSON {
    var success = ""
    var code = ""
    var message = ""
    var rate = ""
    var activityrate = ""
    var leastaamount = ""
    var firstInvestRate = ""
    var deadline = ""
    var flag = ""
    var lists = ""
    var pages = ""
  
}
