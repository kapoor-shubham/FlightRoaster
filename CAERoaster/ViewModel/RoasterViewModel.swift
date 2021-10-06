//
//  RoasterViewModel.swift
//  CAERoaster
//
//  Created by Shubham Kapoor on 04/10/21.
//

import Foundation

class RoasterViewModel {
    
    var dataFetchReady:((_ success: Bool) -> Void)?
    var roasterDBResponse:((_ roasterDBModel: [Date: [Roaster]], _ dateArray: [Date]) -> Void)?
    
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
//                    self.sortDBElements(roasterArr: model)
                    self.makeExecutableDBReponse(roasterArr: model)
                }
            }
        }
    }
    
    /// Fetch data from DB and format according to UI need
    private func makeExecutableDBReponse(roasterArr: [Roaster]) {
        var formatedRoasterModel = [Date: [Roaster]]()
        var roasterDateArray = [Date]()
        roasterArr.forEach { item in
            if let date = item.date {
                formatedRoasterModel[date] != nil ? formatedRoasterModel[date]?.append(item) : (formatedRoasterModel[date] = [item])
                roasterDateArray.append(date)
            }
        }
        
        roasterDateArray = Array(Set(roasterDateArray))
        self.roasterDBResponse?(formatedRoasterModel, roasterDateArray)
    }
    
    /// Call APi to get Data
    private func callRoasterDataAPI() {
        parseJSON()
//        let networkManager = NetworkManager()
//        networkManager.apiRequest(for: RoasterAPIResponseModal.self, from: .init(path: URLEndpoints.roasterURL, httpMethod: .get)) { (response) in
//            switch response {
//            case .failure:
//                self.dataFetchReady?(true)
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
                self.dataFetchReady?(true)
            }
        }
    }
    
    /// Delete previous Data and save new one
    private func updatePreviousData(responseModel: RoasterAPIResponseModal) {
        DispatchQueue.main.async {
            Roaster.deleteEntity { _ in
                self.saveDataInDB(responseModel: responseModel) { responseSaveInDB in
                    self.dataFetchReady?(true)
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
