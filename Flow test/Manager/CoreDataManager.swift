//
//  CoreDataManager.swift
//  Flow test
//
//  Created by HAMZA on 26/7/2022.
//

import Foundation
import CoreData
import UIKit


class CoreDataManager {
    
    // MARK: Core Data Stack
    
    class DataManager {
        static let shared = DataManager()
        
        enum DataError: Error {
            case failedToSaveData
            case failedToFetchData
            case failedToDelete
        }
        
        // MARK: Core Data Functionnality

        
        func saveData(with model: User, completion: @escaping (Result<Void, Error>) -> Void) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            let context = appDelegate.persistentContainer.viewContext
            let item = UserItem(context: context)
            
            item.id = Int64(model.id)
            item.email = model.email
            item.first_name = model.first_name
            item.last_name = model.last_name
            item.avatar = model.avatar
            
            do {
                try context.save()
                completion(.success(()))
            } catch {
                completion(.failure(DataError.failedToSaveData))
            }
        }
        
        
        func fetchingUsers(completion: @escaping (Result<[UserItem], Error>) -> Void) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            let context = appDelegate.persistentContainer.viewContext
            
            let request: NSFetchRequest<UserItem>
            
            request = UserItem.fetchRequest()
            
            do {
                let users = try context.fetch(request)
                completion(.success(users))
            } catch {
                completion(.failure(DataError.failedToFetchData))
            }
        }
        
        
        func editUser(with model: UserItem, lastName: String, firstName: String, completion: @escaping (Result<Void, Error>) -> Void) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            let context = appDelegate.persistentContainer.viewContext
            
            model.first_name = firstName
            model.last_name = lastName
            
            
            do {
                try context.save()
                completion(.success(()))
            } catch {
                completion(.failure(DataError.failedToDelete))
            }
        }
        
        
        func deleteUser(with model: UserItem, completion: @escaping (Result<Void, Error>) -> Void) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            let context = appDelegate.persistentContainer.viewContext
            context.delete(model)
            
            do {
                try context.save()
                completion(.success(()))
            } catch {
                completion(.failure(DataError.failedToDelete))
            }
        }
        
        
         func deleteAllArticles() {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            let context = appDelegate.persistentContainer.viewContext
            
            fetchingUsers { result in
                switch result {
                case .success(let users):
                    users.forEach { user in
                        context.delete(user)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            }
        }
        
        func isEmpty() -> Bool {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return true }
            
            let context = appDelegate.persistentContainer.viewContext
            
            let request: NSFetchRequest<UserItem>
            
            request = UserItem.fetchRequest()
            
            do {
                let users = try context.fetch(request)
                if users.count == 0 {
                    return true
                } else {
                    return false
                }
            } catch {
                return true
            }
        }
    }
    
    
    // MARK: Api Manager

    
    class ApiManager {
        static let shared = ApiManager()
        
        // Retreive Data from API
        func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {

            guard let url = URL(string: "https://reqres.in/api/users") else { return }

            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                guard let data = data, error == nil else { return }

                do {
                    let results = try JSONDecoder().decode(UserResponse.self, from: data)
                  //  print(results)
                    completion(.success(results.data))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }

            task.resume()

        }

    }


}
