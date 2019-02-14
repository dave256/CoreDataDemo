//
//  PlayerTableViewController.swift
//  CoreDataDemo
//
//  Created by David M. Reed on 2/14/19.
//  Copyright © 2019 David Reed. All rights reserved.
//

import UIKit

class PlayerTableViewController: UITableViewController, StoryboardInitializable {

    weak var coordinator: AppCoordinator?
    var team: Team? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func reloadPlayers() {
        guard let t = team, let p = t.players as? Set<Player> else {
            return
        }
        players = Array(p)
        players.sort { (p1, p2) -> Bool in
            if p1.last < p2.last {
                return true
            } else if p2.last < p1.last {
                return false
            } else {
                return p1.first < p2.first
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let t = team else {
            return
        }
        self.title = t.teamName
        reloadPlayers()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        let p = players[indexPath.row]
        cell.textLabel?.text = p.fullName
        return cell
    }

    var players: [Player] = []
}
