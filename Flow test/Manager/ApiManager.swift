//
//  ApiManager.swift
//  Flow test
//
//  Created by HAMZA on 24/7/2022.
//

import Foundation


class ApiManager {
    static let shared = ApiManager()
    
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        
        guard let url = URL(string: "https://reqres.in/api/users") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(UserResponse.self, from: data)
                print(results)
                completion(.success(results.data))
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
        
        task.resume()
                
    }
    
    
}
