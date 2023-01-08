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
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
        }
    }
    
    func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            
        }
    }
}
