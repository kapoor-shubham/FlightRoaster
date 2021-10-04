//
//  RoasterViewModel.swift
//  CAERoaster
//
//  Created by Shubham Kapoor on 04/10/21.
//

import Foundation

class RoasterViewModel {
    
    var fetchData:((_ success: Bool) -> Void)?
    
    /// Get RoasterData
    func getRoasterData() {
        checkForInternet() ? self.callRoasterDataAPI() : self.getRoasterDataFromDB()
    }
    
    /// Check for Internet
    private func checkForInternet () -> Bool {
        return Reachability.isConnectedToNetwork() ? true : false
    }
    
    /// Get Data from Database when no Internet
    func getRoasterDataFromDB() {
        DatabaseManager.sharedManager.fetchData(entityName: "Roaster", dbObject: [Roaster]()) { (response) in
            print(response)
        }
    }
    
    private func callRoasterDataAPI() {
        let networkManager = NetworkManager()
        networkManager.apiRequest(for: RoasterAPIResponseModal.self, from: .init(path: URLEndpoints.roasterURL, httpMethod: .get)) { (response) in
            switch response {
            case .failure( let error) :
                print(error)
            case .success(let responseModel) :
                if let model = responseModel {
                    self.saveDataInDB(responseModel: model) { responseSaveInDB in
                        self.fetchData?(true)
                    }
                }
            }
        }
    }
    
    private func saveDataInDB(responseModel: RoasterAPIResponseModal, completion: @escaping(_ dataSaved: Bool) -> Void) {
        
        let dispatchGroup = DispatchGroup()
        
        responseModel.forEach { item in
            let dbObj = Roaster()
            dbObj.flightnr = item.flightnr
            dbObj.date = item.date
            dbObj.aircraftType = item.aircraftType
            dbObj.tail = item.tail
            dbObj.departure = item.departure
            dbObj.destination = item.destination
            dbObj.timeDepart = item.timeDepart
            dbObj.timeArrive = item.timeArrive
            dbObj.dutyID = item.dutyID
            dbObj.dutyCode = item.dutyCode
            dbObj.firstOfficer = item.firstOfficer
            dbObj.captain = item.captain
            dbObj.flightAttendant = item.flightnr
            
            dispatchGroup.enter()
            DatabaseManager.sharedManager.saveData(dbObject: dbObj) { saved, error in
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            completion(true)
        }
    }
}
