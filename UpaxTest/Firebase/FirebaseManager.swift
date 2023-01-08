//
//  FirebaseManager.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 07/01/23.
//

import Foundation
import FirebaseAuth

class FirebaseManager {
    
    class var shared: FirebaseManager {
        struct Static {
            static let instance = FirebaseManager()
        }
        
        return Static.instance
    }
    
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
    
    func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print(error)
            }
            
            if let result = result {
                print(result)
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
