//
//  Team.swift
//  CoreDataDemo
//
//  Created by David M. Reed on 2/14/19.
//  Copyright © 2019 David Reed. All rights reserved.
//

import CoreData

@objc(Team) final public class Team: NSManagedObject, DDRCoreData {

}

extension Team {
    static func insertSampleData(context: NSManagedObjectContext) {
        var players = [
            "Steelers": ["Terry Bradshaw", "Franco Harris"],
            "Cowboys": ["Roger Staubauch", "Tony Dorsett"]
        ]

        do {
            let teams = try context.performAndWait {
                return try Team.items(for: context)
            }
            if teams.count == 0 {
                for teamName in ["Steelers", "Cowboys"] {
                    let t = Team(context: context)
                    t.teamName = teamName
                    for fullName in players[teamName]! {
                        let p = Player(context: context)
                        let names = fullName.components(separatedBy: " ")
                        p.firstName = names[0]
                        p.lastName = names[1]
                        p.myTeam = t
                    }
                }
            }
        } catch {

        }
    }
}
