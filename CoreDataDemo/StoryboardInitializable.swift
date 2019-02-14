//
//  StoryboardInitializable.swift
//  DDRUtils
//
//  Created by David M. Reed on 5/4/18.
//  Copyright © 2018 David Reed. All rights reserved.
//

import UIKit

// from: http://nsscreencast.com/episodes/273-storyboard-initializable

public protocol StoryboardInitializable {
    static var storyboardName: String { get }
    static var storyboardBundle: Bundle? { get }

    static func makeFromStoryboard() -> Self
    static func makeFromStoryboard(storyboardName sbName: String, storyboardBundle sbBundle: Bundle?) -> Self

    func embedInNavigationController() -> UINavigationController
    func embedInNavigationController(navBarClass: AnyClass?) -> UINavigationController
}

public extension StoryboardInitializable where Self : UIViewController {
    static var storyboardName: String {
        return "Main"
    }

    static var storyboardBundle: Bundle? {
        return nil
    }

    static var storyboardIdentifier: String {
        return String(describing: self)
    }

    static func makeFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: storyboardBundle)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }

    static func makeFromStoryboard(storyboardName sbName: String, storyboardBundle sbBundle: Bundle? = nil) -> Self {
        let storyboard = UIStoryboard(name: sbName, bundle: sbBundle)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }

    func embedInNavigationController() -> UINavigationController {
        return embedInNavigationController(navBarClass: nil)
    }

    func embedInNavigationController(navBarClass: AnyClass?) -> UINavigationController {
        let nav = UINavigationController(navigationBarClass: navBarClass, toolbarClass: nil)
        nav.viewControllers = [self]
        return nav
    }
}
