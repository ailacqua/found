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
    func fetchItems(completion: @escaping ([Item]) -> Void) {
        let endpoint: String = ""
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: [Item].self, decoder: decoder) { response in
                switch response.result {
                case .success(let items):
                    print("Successfully fetched \(items.count) items")
                    completion(items)
                case .failure(let error):
                    print("Error in NetworkManager.fetchItems: \(error.localizedDescription)")
                }
            }
    }
    
}
