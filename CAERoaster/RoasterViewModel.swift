//
//  RoasterViewModel.swift
//  CAERoaster
//
//  Created by Shubham Kapoor on 04/10/21.
//

import Foundation

class RoasterViewModel {
    
    /// Get RoasterData
    func getRoasterData() {
        checkForInternet() ? self.callRoasterDataAPI() : self.getRoasterDataFromDB()
    }
    
    /// Check for Internet
    private func checkForInternet () -> Bool {
        return Reachability.isConnectedToNetwork() ? true : false
    }
    
    /// Get Data from Database when no Internet
    private func getRoasterDataFromDB() {
        
    }
    
    private func callRoasterDataAPI() {
        let networkManager = NetworkManager()
        networkManager.apiRequest(for: RoasterAPIResponseModal.self, from: .init(path: URLEndpoints.roasterURL, httpMethod: .get)) { (response) in
            switch response {
            case .failure( let error) :
                print(error)
            case .success(let responseModel) :
                print(responseModel)
            }
        }
    }
}
