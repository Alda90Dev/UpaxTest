//
//  FirebaseManager.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 07/01/23.
//

import Foundation
import FirebaseAuth
import FirebaseStorage

class FirebaseManager {
    
    class var shared: FirebaseManager {
        struct Static {
            static let instance = FirebaseManager()
        }
        
        return Static.instance
    }
    
    private let storage = Storage.storage().reference()
    
    func signIn(email: String, password: String, completion: @escaping (NetworkResult<User>) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(NetworkResult.failure(error: NetworkErrorType.customizedError(message: error.localizedDescription)))
                return
            }
            
            if let result = result {
                completion(NetworkResult.success(data: result.user))
            }
        }
    }
    
    func createUser(email: String, password: String, completion: @escaping (NetworkResult<User>) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(NetworkResult.failure(error: NetworkErrorType.customizedError(message: error.localizedDescription)))
                return
            }
            
            if let result = result {
                completion(NetworkResult.success(data: result.user))
            }
        }
    }
    
    func updateUser(name: String, completion: @escaping (Error?) -> ()) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: { error in
            if let error = error {
                completion(error)
                return
            }
            
            completion(nil)
            return
        })
    }
    
    func uploadImage(name: String, imageData: Data, completion: @escaping (Error?) -> ()) {
        storage.child("images/\(name).png").putData(imageData, metadata: nil) { _, error in
            
            if let error = error {
                completion(error)
                return
            }
            
            completion(nil)
            return
        }
    }
    
    func getImage(name: String, completion: @escaping (NetworkResult<String>) -> ()) {
        storage.child("images/\(name).png").downloadURL { url, error in
            if let error = error {
                completion(NetworkResult.failure(error: NetworkErrorType.customizedError(message: error.localizedDescription)))
                return
            }
            
            if let url = url {
                let urlString = url.absoluteString
                completion(NetworkResult.success(data: urlString))
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            
        }
    }
}
