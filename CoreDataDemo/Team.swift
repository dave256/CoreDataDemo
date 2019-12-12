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
        let players = [
            "Steelers": ["Terry Bradshaw", "Franco Harris"],
            "Cowboys": ["Roger Staubauch", "Tony Dorsett"]
        ]

        do {
            // get existing Teams from the database
            let teams = try context.performAndWait {
                return try Team.items(for: context)
            }
            // if there no teams
            if teams.count == 0 {
                // insert sample data
                for teamName in ["Steelers", "Cowboys"] {
                    // create a new team
                    let t = Team(context: context)
                    t.teamName = teamName
                    // add players to the team
                    for fullName in players[teamName]! {
                        // create player
                        let p = Player(context: context)
                        // split to get first and last name
                        let names = fullName.components(separatedBy: " ")
                        p.firstName = names[0]
                        p.lastName = names[1]
                        // set player's team to t
                        p.myTeam = t
                    }
                }
            }
        } catch {

        }
    }
}
