//
//  UserDefaults.swift
//  Ertakchi
//
//

import Foundation

let UD = UserDefaults(suiteName: "uz.ertakchi.www")!

extension UserDefaults {
    
    public var language: String {
        get { return unarchiveObject(key: "appLanguage").notNullString }
        set { archivedData(key: "appLanguage", object: newValue )    }
    }

    var mode: String? {
        get { return self.string(forKey: "appMode") }
        set { self.set(newValue, forKey: "appMode") }
    }
    
    func unarchiveObject(key: String) -> Any? {
        if let data = value(forKey: key) as? Data {
                do {
                    if let result = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, NSString.self, NSNumber.self], from: data) {
                        return (result as AnyObject).value(forKey: "Data")
                    }
                }
            return nil
        }
        return nil
    }
    
    func archivedData(key: String, object: Any) {
        let result = NSMutableDictionary()
        result.setValue(object, forKey: "Data")
            do {
                let encodedObject = try? NSKeyedArchiver.archivedData(withRootObject: result, requiringSecureCoding: false)
                set(encodedObject, forKey: key)
            }
    }
    
    var token: String? {
        get { return self.string(forKey: "token") }
        set { self.set(newValue, forKey: "token") }
    }
    
    var instruction: String? {
        get { return self.string(forKey: "xxxxxxx") }
        set { self.set(newValue, forKey: "xxxxxxx") }
    }
    
    var username: String? {
        get { return self.string(forKey: "username") }
        set { self.set(newValue, forKey: "username") }
    }
}

extension Optional {
    var notNullString: String {
        switch self {
        case .some(let value): return String(describing: value)
        case .none : return ""
        }
    }
}
