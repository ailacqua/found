//
//  Item.swift
//  FoundIt
//
//  Created by Alexander Ilacqua on 11/28/23.
//

import Foundation

struct ItemResponse: Codable {
    let items: [Item]
}

struct Item: Codable {
    let id: Int
    let imageUrl: String
    let desc: String
    let locDesc: String
    let time: String
    let status: String
    let contact: String
    let locId: Int
    let buildingName: String
}

extension Item {
    
    static let dummyItems = [
        Item(id: 0,
             imageUrl: "https://i5.walmartimages.com/seo/Owala-FreeSip-Water-Bottle-Stainless-Steel-24-Oz-Smooshed-Blueberry-Blue_0482e61b-6fa7-4423-8302-65f845e79fcf.7bfb3108f7003724015a9e93e3d3738d.jpeg",
             desc: "Water Bottle",
             locDesc: "Found between the stairs and the entrance to the room on the third floor that is near the water fountain underneath the ceiling that is connected to the wall",
             time: "June 27 at 10:30 AM",
             status: "lost",
             contact: "rs2443@cornell.edu",
             locId: 0,
             buildingName: "Alice Cook House")
    ]
    
}
