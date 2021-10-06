//
//  RoasterAPIResponseModal.swift
//  CAERoaster
//
//  Created by Shubham Kapoor on 04/10/21.
//

import Foundation

// MARK: - RoasterModalElement
struct RoasterModalElement: Codable {
    let flightnr, date: String?
    let aircraftType: String?
    let tail, departure, destination, timeDepart: String?
    let timeArrive: String?
    let dutyID: String?
    let dutyCode: String?
    let captain: String?
    let firstOfficer: String?
    let flightAttendant: String?

    enum CodingKeys: String, CodingKey {
        case flightnr = "Flightnr"
        case date = "Date"
        case aircraftType = "Aircraft Type"
        case tail = "Tail"
        case departure = "Departure"
        case destination = "Destination"
        case timeDepart = "Time_Depart"
        case timeArrive = "Time_Arrive"
        case dutyID = "DutyID"
        case dutyCode = "DutyCode"
        case captain = "Captain"
        case firstOfficer = "First Officer"
        case flightAttendant = "Flight Attendant"
    }
}

enum DutyCode: String, Codable {
    case flight = "FLIGHT"
    case layover = "LAYOVER"
    case off = "OFF"
    case positioning = "POSITIONING"
    case standby = "Standby"
}

typealias RoasterAPIResponseModal = [RoasterModalElement]
