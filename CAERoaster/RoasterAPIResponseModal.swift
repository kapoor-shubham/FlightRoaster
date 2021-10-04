//
//  RoasterAPIResponseModal.swift
//  CAERoaster
//
//  Created by Shubham Kapoor on 04/10/21.
//

import Foundation

// MARK: - RoasterModalElement
struct RoasterModalElement: Codable {
    let flightnr, date: String
    let aircraftType: AircraftType
    let tail, departure, destination, timeDepart: String
    let timeArrive: String
    let dutyID: DutyID
    let dutyCode: DutyCode
    let captain: Captain
    let firstOfficer: FirstOfficer
    let flightAttendant: FlightAttendant

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

enum AircraftType: String, Codable {
    case airbusA330 = "Airbus A330"
    case airbusA380 = "Airbus A380"
    case b737400 = "B737-400"
    case empty = ""
    case the748800E = "748-800E"
}

enum Captain: String, Codable {
    case empty = ""
    case richardVersluis = "Richard Versluis"
}

enum DutyCode: String, Codable {
    case flight = "FLIGHT"
    case layover = "LAYOVER"
    case off = "OFF"
    case positioning = "POSITIONING"
    case standby = "Standby"
}

enum DutyID: String, Codable {
    case dutyIDDO = "DO"
    case flt = "FLT"
    case ofd = "OFD"
    case pos = "POS"
    case sby = "SBY"
}

enum FirstOfficer: String, Codable {
    case empty = ""
    case jeroenDerwort = "Jeroen Derwort"
    case karlJenkins = "Karl Jenkins"
}

enum FlightAttendant: String, Codable {
    case empty = ""
    case lucyStone = "Lucy Stone"
}

typealias RoasterAPIResponseModal = [RoasterModalElement]
