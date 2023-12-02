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
    let time: Date
    let status: Bool
    let contact: String
}

extension Item {
    
    static let dummyItems = [
        Item(image: "AIlacqua", desc: "Water Bottle", locDesc: "Olin Hall", time: Date(), status: true, contact: "rs2443@cornell.edu"),
        Item(image: "Charger", desc: "Charger", locDesc: "Mann Hall", time: Date(), status: false, contact: "ad243@cornell.edu"),
        Item(image: "Pencil", desc: "Pencil", locDesc: "Uris Hall", time: Date(), status: true, contact: "sj543@cornell.edu")
    ]
    
}
