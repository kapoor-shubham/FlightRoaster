//
//  RoasterViewModel.swift
//  CAERoaster
//
//  Created by Shubham Kapoor on 04/10/21.
//

import Foundation
import CoreData

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
        
        Roaster.saveObjInDB(apiResponse: responseModel) { (success) in
            self.fetchData?(true)
        }
    }
}
