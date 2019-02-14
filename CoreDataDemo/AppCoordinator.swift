//
//  AppCoordinator.swift
//  CoreDataDemo
//
//  Created by David M. Reed on 2/14/19.
//  Copyright © 2019 David Reed. All rights reserved.
//

import UIKit

class AppCoordinator {

    init(rootViewController: TeamTableViewController) {
        self.rootViewController = rootViewController
        rootViewController.coordinator = self
    }

    func select(team: Team) {
        let vc = PlayerTableViewController.makeFromStoryboard()
        vc.coordinator = self
        vc.team = team
        rootViewController.navigationController?.pushViewController(vc, animated: true)
    }
//    func segueTo(detailViewController: UIViewController) {
//        guard let vc = detailViewController as? ContactDetailViewController else {
//            return
//        }
//        vc.coordinator = self
//        if let index = contactIndex {
//            vc.person = model[index]
//        }
//    }

//    var model = Team.sampleData()
    public private(set) var coreDataStack = CoreDataStack.shared
    public private(set) var rootViewController: TeamTableViewController
}
