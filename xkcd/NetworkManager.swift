//
//  NetworkManager.swift
//  xkcd
//
//  Created by Sina Rabiei on 10/26/21.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.xkcdy.com/"
    
    func getComics(since: Int, completion: @escaping (Result<ComicsModel, XCError>) -> Void) {
        let endpoint = baseURL + "comics"
        
        guard var components = URLComponents(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "since", value: String(since))
        ]
        
        let url = URLRequest(url: components.url!)
        
        let _ = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let comics = try decoder.decode(ComicsModel.self, from: data)
                completion(.success(comics))
            } catch {
                completion(.failure(.invalidData))
            }
            
        }.resume()
    }
    
    func loadImage(_ url: String) -> UIImage {
        guard let url = URL(string: url) else { return UIImage() }
        
        do {
            let image = try Data(contentsOf: url)
            return UIImage(data: image) ?? UIImage()
        } catch {
            print(error)
        }
        
        return UIImage()
    }
    
    func getImageData(_ url: String) -> Data {
        guard let url = URL(string: url) else { return Data() }
        
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print(error.localizedDescription)
        }
        
        return Data()
    }
}
