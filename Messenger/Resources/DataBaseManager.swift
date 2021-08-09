//
//  DataBaseManager.swift
//  Messenger
//
//  Created by James Thang on 09/08/2021.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database(url: "https://messenger-f877a-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
    
    /// Insert New User to Database
    public func insertUser(with user: ChatAppUser) {
        
        database.child(user.safeEmail).setValue([
            "first_name" : user.firstName,
            "last_name" : user.lastName
        ])
    }
    
    public func isUserExist(with email: String, completion: @escaping ((Bool) -> Void) ) {
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
                
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapShot in
            guard snapShot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        })
        
    }
}

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let email: String
//    let profilePicUrl: String
    
    var safeEmail: String {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}
