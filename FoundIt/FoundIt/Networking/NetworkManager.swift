//
//  NetworkManager.swift
//  FoundIt
//
//  Created by Alexander Ilacqua on 11/30/23.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    //MARK: - Requests
    func addToItems(desc: String,imageData: String,locDesc: String,status: String,contact: String,locName: String,time: String, completion: @escaping (Bool) -> Void) {
        let endpoint: String = "http://34.150.237.6/items/"
        
        let parameters: Parameters = [
            "desc": desc,
            "image_data": imageData,
            "loc_desc": locDesc,
            "status": status,
            "contact": contact,
            "loc_name": locName,
            "time": time,
        ]
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: Item.self, decoder: decoder) { response in
                switch response.result {
                case .success(let item):
                    print("Successfully added item \(item)")
                    completion(true)
                case .failure(let error):
                    print("Error in NetworkManager.addToItems: \(error.localizedDescription)")
                    completion(false)
                }
            }
    }
    
    func fetchItems(completion: @escaping ([Item]) -> Void) {
        let endpoint: String = "http://34.150.237.6/items/"
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: ItemResponse.self, decoder: decoder) { response in
                switch response.result {
                case .success(let itemResponse):
                    print("Successfully fetched \(itemResponse.items.count) items")
                    completion(itemResponse.items)
                case .failure(let error):
                    print("Error in NetworkManager.fetchItems: \(error.localizedDescription)")
                }
            }
    }
    
}
