//
//  UserInfo+CoreDataProperties.swift
//  FriendFace
//
//  Created by Toshiki Ichibangase on 2020/06/21.
//  Copyright © 2020 Toshiki Ichibangase. All rights reserved.
//
//

import Foundation
import CoreData


extension UserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }

    @NSManaged public var about: String?
    @NSManaged public var adress: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: String?
    @NSManaged public var tags: Array<String>?
    @NSManaged public var friends: NSSet?

    public var friendsArray: [Friend] {
        let set = friends as? Set<Friend> ?? []
        return set.sorted() {
            $0.wrappedName < $1.wrappedName
        }
    }
    
    public var wrappedAbout: String {
        about ?? "No Information."
    }
    
    public var wrappedAdress: String {
        adress ?? "Unknown Adress"
    }
    
    public var wrappedCompany: String {
        company ?? "Not in Job"
    }
    
    public var wrappedEmail: String {
        email ?? "No email adress"
    }
    
    public var wrappedId: String {
        id ?? "Unknown ID"
    }
    
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    public var wrappedRegistered: String {
        registered ?? "No data"
    }
    
    public var wrappedTags: Array<String> {
        tags ?? ["No tags"]
    }
}

// MARK: Generated accessors for friends
extension UserInfo {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: Friend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: Friend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}
