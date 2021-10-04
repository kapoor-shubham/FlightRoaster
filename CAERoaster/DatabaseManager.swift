//
//  DatabaseManager.swift
//  CAERoaster
//
//  Created by Shubham Kapoor on 04/10/21.
//

import UIKit
import CoreData

class DatabaseManager {
    
    // MARK: Variables declearations
    static let sharedManager = DatabaseManager()
    var context:NSManagedObjectContext! = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init() {} // Prevent clients from creating another instance.
    
    func saveData<T>(dbObject: T, completion: @escaping(_ success: Bool, _ error: Error?) -> Void) {
        do {
            try context.save()
            completion(true, nil)
        } catch (let error) {
            completion(false, error)
        }
    }
    
    func fetchData<T>(entityName: String, dbObject: T, completion: @escaping(_ responseDBObject: T) -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as? [Roaster]
            completion(T.self as! T)
        } catch {
            print("Fetching data Failed")
        }
    }
}
