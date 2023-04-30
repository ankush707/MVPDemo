//
//  APIRequest.swift
//  MVPDemo
//
//  Created by Ankush on 20/03/23.
//

import Foundation

class APIRequest {
    
    
    func loadData(completion: @escaping (HomeModel) -> Void) {
        guard let url = URL(string: "https://datausa.io/api/data?drilldowns=Nation&measures=Population") else {
            print("Invalid url...")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
           
            guard let dataObj = data else {
                print("Invalid data...")
                return
            }
            
            if let homeData = try? JSONDecoder().decode(HomeModel.self, from: dataObj) {
                DispatchQueue.main.async {
                    completion(homeData)
                }
            }
            
        }.resume()
    }
}
