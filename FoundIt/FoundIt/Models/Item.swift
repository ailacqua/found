//
//  Item.swift
//  FoundIt
//
//  Created by Alexander Ilacqua on 11/28/23.
//

import Foundation

struct Item: Codable {
    let image: String
    let desc: String
    let locDesc: String
    let time: String
    let status: Bool
    let contact: String
}

extension Item {
    
    static let dummyItems = [
        Item(image: "WaterBottle", desc: "Water Bottle", locDesc: "Olin Hall", time: "11-15-2023", status: true, contact: "rs2443@cornell.edu"),
        Item(image: "Charger", desc: "Charger", locDesc: "Mann Hall", time: "11-15-2023", status: false, contact: "ad243@cornell.edu"),
        Item(image: "Pencil", desc: "Pencil", locDesc: "Uris Hall", time: "11-15-2023", status: true, contact: "sj543@cornell.edu")
    ]
    
}
