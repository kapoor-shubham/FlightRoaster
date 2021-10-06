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
        DispatchQueue.main.async {
            Roaster.fetchEntity { dbModel in
                if let model = dbModel {
                    self.sortDBElements(roasterArr: model)
                }
            }
        }
    }
    
    private func sortDBElements(roasterArr: [Roaster]) {
        
    }
    
    /// Call APi to get Data
    private func callRoasterDataAPI() {
        parseJSON()
//        let networkManager = NetworkManager()
//        networkManager.apiRequest(for: RoasterAPIResponseModal.self, from: .init(path: URLEndpoints.roasterURL, httpMethod: .get)) { (response) in
//            switch response {
//            case .failure:
//                self.fetchData?(true)
//            case .success(let responseModel) :
//                if let model = responseModel {
//                    self.updatePreviousData(responseModel: model)
//                }
//            }
//        }
    }
    
    func parseJSON() {
        if let url = Bundle.main.url(forResource: "DummyJson", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(RoasterAPIResponseModal.self, from: data)
                self.updatePreviousData(responseModel: jsonData)
            } catch {
                self.fetchData?(true)
            }
        }
    }
    
    /// Delete previous Data and save new one
    private func updatePreviousData(responseModel: RoasterAPIResponseModal) {
        DispatchQueue.main.async {
            Roaster.deleteEntity { _ in
                self.saveDataInDB(responseModel: responseModel) { responseSaveInDB in
                    self.fetchData?(true)
                }
            }
        }
    }
    
    /// Save API Response in DB
    private func saveDataInDB(responseModel: RoasterAPIResponseModal, completion: @escaping(_ dataSaved: Bool) -> Void) {
        Roaster.saveObjInDB(apiResponse: responseModel) { (success) in
            completion(true)
        }
    }
}
