//
//  NetworkManager.swift
//  whichNationIsIt
//
//  Created by Umithan  on 16.08.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()

    func searchNames(with text: String, completion: @escaping (NamesResponse) -> Void) {
        guard let url = URL(string: "https://api.nationalize.io?name=\(text)") else { return }
        
        AF.request(url).responseDecodable(of: NamesResponse.self) { response in
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    completion(response.value!)
                }
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    


    


    
}
