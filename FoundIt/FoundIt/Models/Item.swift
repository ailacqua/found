//
//  Item.swift
//  FoundIt
//
//  Created by Alexander Ilacqua on 11/28/23.
//

import Foundation

struct Item: Codable {
    let id: Int
    let image: String
    let desc: String
    let locDesc: String
    let time: String
    let status: Bool
    let contact: String
    let locId: Int
}

extension Item {
    
    static let dummyItems = [
        Item(id: 0, image: "WaterBottle", desc: "Water Bottle", locDesc: "Olin Hall", time: "June 27 at 10:30 AM", status: true, contact: "rs2443@cornell.edu",locId: 0),
        Item(id: 1, image: "Charger", desc: "Charger", locDesc: "Mann Hall", time: "June 27 at 10:30 AM", status: false, contact: "ad243@cornell.edu", locId: 1),
        Item(id: 2, image: "Pencil", desc: "Pencil", locDesc: "Uris Hall", time: "June 27 at 10:30 AM", status: true, contact: "sj543@cornell.edu", locId: 2)
    ]
    
}
