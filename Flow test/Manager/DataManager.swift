//
//  DataManager.swift
//  Flow test
//
//  Created by HAMZA on 24/7/2022.
//

import Foundation
import CoreData
import UIKit

class DataManager {
    static let shared = DataManager()
    
    enum DataError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDelete
    }
    
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
    
}
