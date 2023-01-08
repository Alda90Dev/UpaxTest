//
//  Defaults.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 08/01/23.
//

import UIKit

class Defaults
{
    private let defaults = UserDefaults.standard
  
    private let nameKey = "name"
    private let emailKey = "account"
    private let avatarKey = "avatar"
    
    var email: String {
        get {
            return defaults.string(forKey: emailKey) ?? ""
        }
        
        set {
            defaults.setValue(newValue, forKey: emailKey)
        }
    }
    
    var avatar: String {
        get {
            return defaults.string(forKey: avatarKey) ?? ""
        }
        
        set {
            defaults.setValue(newValue, forKey: avatarKey)
        }
    }
    
    var name: String {
        get {
            return defaults.string(forKey: nameKey) ?? ""
        }
        
        set {
            defaults.setValue(newValue, forKey: nameKey)
        }
    }
  
    class var shared: Defaults {
        struct Static {
            static let instance = Defaults()
        }
      
        return Static.instance
    }
    
}
