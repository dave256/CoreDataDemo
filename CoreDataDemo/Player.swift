//
//  Player.swift
//  CoreDataDemo
//
//  Created by David M. Reed on 2/14/19.
//  Copyright © 2019 David Reed. All rights reserved.
//

import CoreData

@objc(Player) final public class Player: NSManagedObject, DDRCoreData {
    var fullName: String {
        return (firstName ?? "") + " " + (lastName ?? "")
    }
}

extension Player {
    var first: String { return firstName ?? "" }
    var last: String { return lastName ?? "" }
}
