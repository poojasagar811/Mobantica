//
//  NSURLSession.swift
//  mobantica
//
//  Created by apple on 26/06/24.
//

import Foundation

//MARK: API Fetch

func fetchProducts(for category: String, completion: @escaping ([Product]?) -> Void) {
    let urlString = "https://dummyjson.com/products/category/\(category)"
    guard let url = URL(string: urlString) else {
        print("Invalid URL string: \(urlString)")
        completion(nil)
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Error fetching products: \(error)")
            completion(nil)
            return
        }
        
        guard let data = data else {
            print("No data received")
            completion(nil)
            return
        }
        
        do {
            let response = try JSONDecoder().decode(ProductResponse.self, from: data)
            completion(response.products)
        } catch {
            print("Error decoding JSON: \(error)")
            completion(nil)
        }
    }.resume()
}
