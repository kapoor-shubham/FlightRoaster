//
//  DateFormatable.swift
//  CAERoaster
//
//  Created by Shubham Kapoor on 06/10/21.
//

import Foundation

protocol DateFormatable {
    func convertDateToString(date: Date, dateFormat: DateFormats) -> String
    func convertStringToDate(dateStr: String, dateFormat: DateFormats) -> Date?
}

extension DateFormatable {
    
    func convertDateToString(date: Date, dateFormat: DateFormats) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.string(from: date)
    }
    
    func convertStringToDate(dateStr: String, dateFormat: DateFormats) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.date(from: dateStr)
    }
}

enum DateFormats: String {
    case yyyyMMddHHmmssSSS = "YYYY-MM-dd HH:mm:ss.SSS"
    case ddMMyyyyHHmm = "dd/MM/yyyy HH:mm"
    case yyyyMMdd = "YYYY-MM-dd"
    case eeeeddMMMMyyyy = "EEEE, dd MMMM yyyy"
    case ddMMyyyy = "dd/MM/yyyy"
    case hhMM = "HH:mm"
    case ddMMMyyyyHHmmss = "dd MMM yyyy HH:mm:ss"
    case ddMMMyyyyHHmm = "dd MMM yyyy HH:mm"
    case ddMMMyyyyHHmma = "dd MMM yyyy HH:mm a"
    case ddMMMyyyy = "dd MMM YYYY"
}
