//
//  TeamTableViewController.swift
//  CoreDataDemo
//
//  Created by David M. Reed on 2/14/19.
//  Copyright © 2019 David Reed. All rights reserved.
//

import UIKit

class TeamTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTeams()
    }

    func reloadTeams() {
        guard let context = coordinator?.coreDataStack.viewContext else {
            return
        }
        do {
            teams = try Team.items(for: context, sortedBy: [NSSortDescriptor(key: "teamName", ascending: true)])
        } catch {
            teams = []
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = teams[indexPath.row].teamName
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let t = teams[indexPath.row]
        coordinator?.select(team: t)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    weak var coordinator: AppCoordinator?
    var teams: [Team] = []
}
