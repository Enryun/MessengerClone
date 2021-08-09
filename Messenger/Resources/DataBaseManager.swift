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
        database.child(user.email).setValue([
            "first_name" : user.firstName,
            "last_name" : user.lastName
        ])
    }
    
    public func isUserExist(with email: String, completion: @escaping ((Bool) -> Void) ) {
        database.child(email).observeSingleEvent(of: .value) { snapShot in
            guard snapShot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        }
        
    }
}

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let email: String
//    let profilePicUrl: String
}
