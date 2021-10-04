//
//  Roaster+CoreDataProperties.swift
//  CAERoaster
//
//  Created by Shubham Kapoor on 04/10/21.
//
//

import Foundation
import CoreData


extension Roaster {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Roaster> {
        return NSFetchRequest<Roaster>(entityName: "Roaster")
    }

    @NSManaged public var flightnr: String?
    @NSManaged public var date: String?
    @NSManaged public var aircraftType: String?
    @NSManaged public var tail: String?
    @NSManaged public var departure: String?
    @NSManaged public var destination: String?
    @NSManaged public var timeDepart: String?
    @NSManaged public var timeArrive: String?
    @NSManaged public var dutyID: String?
    @NSManaged public var dutyCode: String?
    @NSManaged public var firstOfficer: String?
    @NSManaged public var captain: String?
    @NSManaged public var flightAttendant: String?

}

extension Roaster : Identifiable {

}
