//
//  Roaster+CoreDataClass.swift
//  CAERoaster
//
//  Created by Shubham Kapoor on 04/10/21.
//
//

import Foundation
import CoreData

@objc(Roaster)
public class Roaster: NSManagedObject {
    
    
    static var roaster = NSEntityDescription.insertNewObject(forEntityName: "Roaster",
                                                     into: DatabaseManager.sharedManager.context) as! Roaster
    
    private static let dispatchGroup = DispatchGroup()
    
    static func saveObjInDB(apiResponse: RoasterAPIResponseModal, completion: @escaping(_ success: Bool) -> Void) {
        apiResponse.forEach { item in
            roaster.flightnr = item.flightnr
            roaster.date = item.date
            roaster.aircraftType = item.aircraftType
            roaster.tail = item.tail
            roaster.departure = item.departure
            roaster.destination = item.destination
            roaster.timeDepart = item.timeDepart
            roaster.timeArrive = item.timeArrive
            roaster.dutyID = item.dutyID
            roaster.dutyCode = item.dutyCode
            roaster.firstOfficer = item.firstOfficer
            roaster.captain = item.captain
            roaster.flightAttendant = item.flightAttendant
            
            dispatchGroup.enter()
            do {
                try DatabaseManager.sharedManager.context.save()
                dispatchGroup.leave()
            } catch {
                print("Storing data Failed")
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            completion(true)
        }
    }
    
}
