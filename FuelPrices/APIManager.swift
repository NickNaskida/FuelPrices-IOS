//
//  APIManager.swift
//  FuelPrices
//
//  Created by Nikoloz Naskidashvili on 24.02.23.
//

import Foundation

func fetchData<T: Decodable>(from path: String, modelType: T.Type, completion: @escaping (T?) -> Void) {
    guard let url = URL(string: "http://\(Config.APIBaseUrl)/api\(path)") else {
        print("Invalid API endpoint")
        return
    }
    let request = URLRequest(url: url)

    URLSession.shared.dataTask(with: request) { data, response, error in
        if let data = data {
            if let response = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    return completion(response)
                }
                return
            }
        }
        completion(nil)
    }.resume()
}
