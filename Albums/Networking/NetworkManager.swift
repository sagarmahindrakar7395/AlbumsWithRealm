//
//  NetworkManager.swift
//  Albums
//
//  Created by Sagar Mahindrakar on 27/05/22.
//

import Foundation

class NetworkManger {

static let sharedInstance = NetworkManger()
    
    func fetchGenericData<T: Decodable>(urlString: String, completion: @escaping (T) -> ()) {
    let url = URL(string: urlString)
    URLSession.shared.dataTask(with: url!) { (data, resp, err) in
        if let err = err {
            print("Failed to fetch data:", err)
            return
        }
        
        guard let data = data else { return }
        
        do {
            let obj = try JSONDecoder().decode(T.self, from: data)
            completion(obj)
        } catch let jsonErr {
            print("Failed to decode json:", jsonErr)
        }
        }.resume()
}

}
