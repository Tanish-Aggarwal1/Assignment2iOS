//
//  Order.swift
//  PizzaApp
//
//  Created by Tanish Aggarwal on 2026-07-14.
//

import UIKit

// custom class to hold one row from the Orders table
class Order: NSObject {
    var id: Int?
    var deliveryDate: String?
    var address: String?
    var size: Int?
    var meatToppings: String?
    var vegToppings: String?
    var avatar: String?
    
    func initWithData(theRow i: Int, theDeliveryDate d: String, theAddress a: String,
                      theSize s: Int, theMeatToppings m: String, theVegToppings v: String,
                      theAvatar av: String) {
        id = i
        deliveryDate = d
        address = a
        size = s
        meatToppings = m
        vegToppings = v
        avatar = av
    }
}
