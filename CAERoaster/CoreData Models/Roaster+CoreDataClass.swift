//
//  Roaster+CoreDataClass.swift
//  CAERoaster
//
//  Created by Shubham Kapoor on 04/10/21.
//
//

import UIKit
import CoreData

@objc(Roaster)
public class Roaster: NSManagedObject {
    
    private static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func saveObjInDB(apiResponse: RoasterAPIResponseModal, completion: @escaping(_ success: Bool) -> Void) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.ddMMyyyy.rawValue
        
        apiResponse.forEach { item in
            let roaster = NSEntityDescription.insertNewObject(forEntityName: "Roaster", into: context)
            roaster.setValue(item.flightnr, forKey: "flightnr")
            roaster.setValue(item.aircraftType, forKey: "aircraftType")
            roaster.setValue(item.tail, forKey: "tail")
            roaster.setValue(item.departure, forKey: "departure")
            roaster.setValue(item.destination, forKey: "destination")
            roaster.setValue(item.timeDepart, forKey: "timeDepart")
            roaster.setValue(item.dutyID, forKey: "dutyID")
            roaster.setValue(item.dutyCode, forKey: "dutyCode")
            roaster.setValue(item.firstOfficer, forKey: "firstOfficer")
            roaster.setValue(item.captain, forKey: "captain")
            roaster.setValue(item.flightAttendant, forKey: "flightAttendant")
            roaster.setValue(item.timeArrive, forKey: "timeArrive")
            if let dateStr = item.date, let date = dateFormatter.date(from: dateStr) {
                roaster.setValue(date, forKey: "date")
            }
        }
        do {
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    static func deleteEntity(completion: @escaping(_ success: Bool) -> Void) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Roaster")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    static func fetchEntity(completion: @escaping(_ dbModel: [Roaster]?) -> Void) {
        
        let fetchRequest = NSFetchRequest<Roaster>(entityName: "Roaster")
        let sort = NSSortDescriptor(key: #keyPath(Roaster.date), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        do {
            let roster = try context.fetch(fetchRequest)
            completion(roster)
        } catch {
            completion(nil)
        }
    }
}
