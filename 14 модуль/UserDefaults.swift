import Foundation

class UserDefaults1 {
    static let shared = UserDefaults1()
    
    private let kUserNameKey = "UserDefaults1.kUserNameKey"
    private let kUserFamilyKey = "UserDefaults1.kUserFamilyKey"
    
    var userName: String? {
        set { UserDefaults.standard.set(newValue, forKey: "UserDefaults1.kUserNameKey") }
        get { return UserDefaults.standard.string(forKey: "UserDefaults1.kUserNameKey") }
    }
    
    var userFamily: String? {
        set { UserDefaults.standard.set(newValue, forKey: "UserDefaults1.kUserFamilyKey") }
        get { return UserDefaults.standard.string(forKey: "UserDefaults1.kUserFamilyKey") }
    }
}
