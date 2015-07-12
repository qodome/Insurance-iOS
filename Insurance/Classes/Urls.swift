//
//  Copyright (c) 2015年 NY. All rights reserved.
//

let urls = [
    "cards" : "card_list",
    "vehicles" : "vehicle_list",
//    "insurances" : "insurance_list",
//    "orders" : "order_list",
    // 个人信息
    "profile" : "profile",
    "nickname" : "user_update",
    "gender" : "user_check",
    "settings" : "settings",
    "about" : "about",
    "review" : appReviewsLink()
]


func getEndpoints(name: String, pk: String? = nil) {
    if pk == nil {
        return
    }
    
    return
}

//let endpoints = [
//    "user_list" : getEndpoint("users")
//    "user_detail" : ""
//]
