//
//  DDRCoreData.swift
//  CoreDataDemo
//
//  Created by David M. Reed on 2/14/19.
//  Copyright © 2019 David Reed. All rights reserved.
//

import CoreData

public protocol DDRCoreData where Self: NSManagedObject {

    /// fetch NSManagedObject items for a specific entity type; default implementation provided below in extension
    ///
    /// in order to use this, with the default implementation, use Xcode's codegen option of Category/Extension
    /// and then write class such as:
    ///
    /// @objc(Contact) final class Contact: NSManagedObject, DDRCoreData { }
    ///
    /// the class must be declared final so that [Self] can be used as the return type
    ///
    /// - Parameters:
    ///   - context: the NSManagedObjectContext to fetch the values in
    ///   - predicate: optional NSPredicate to limit the values that are fetched
    ///   - sorters: optional array of NSSortDescriptors to sort them by
    /// - Returns: an array of the matching items sorted by the sort descriptors
    static func items(for context: NSManagedObjectContext, sortedBy sorters: [NSSortDescriptor]?, matching predicate: NSPredicate?) throws -> [Self]
}

public extension DDRCoreData {

    public static func items(for context: NSManagedObjectContext, sortedBy sorters: [NSSortDescriptor]? = nil, matching predicate: NSPredicate? = nil) throws -> [Self] {
        return try context.performAndWait {
            let fetchRequest: NSFetchRequest<Self> = Self.fetchRequest() as! NSFetchRequest<Self>
            fetchRequest.predicate = predicate
            fetchRequest.sortDescriptors = sorters
            return try fetchRequest.execute()
        }
    }
}

// https://oleb.net/blog/2018/02/performandwait/

public extension NSManagedObjectContext {
    public func performAndWait<T>(_ block: () throws -> T) rethrows -> T {
        return try _performAndWaitHelper(
            fn: performAndWait, execute: block, rescue: { throw $0 }
        )
    }

    /// Helper function for convincing the type checker that
    /// the rethrows invariant holds for performAndWait.
    ///
    /// Source: https://github.com/apple/swift/blob/bb157a070ec6534e4b534456d208b03adc07704b/stdlib/public/SDK/Dispatch/Queue.swift#L228-L249
    private func _performAndWaitHelper<T>(
        fn: (() -> Void) -> Void,
        execute work: () throws -> T,
        rescue: ((Error) throws -> (T))) rethrows -> T
    {
        var result: T?
        var error: Error?
        withoutActuallyEscaping(work) { _work in
            fn {
                do {
                    result = try _work()
                } catch let e {
                    error = e
                }
            }
        }
        if let e = error {
            return try rescue(e)
        } else {
            return result!
        }
    }
}
