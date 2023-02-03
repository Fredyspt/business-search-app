//
//  YelpAPIManager.swift
//  BusinessSearch
//
//  Created by Fredy Sanchez on 02/02/23.
//

import Foundation

protocol YelpAPIManagerDelegate {
    func didFailWithError(_ error: Error)
    func didUpdateBusinessesData(_ manager: YelpAPIManager, businesses: Businesses)
}

struct YelpAPIManager {
    private let baseUrl = "https://api.yelp.com/v3/businesses/search"
    private let apiKey: String? = {
        var apiPlistDict: [String: Any]?
        guard let plistPath = Bundle.main.url(forResource: "API-Info", withExtension: "plist") else {
            print("Could find API-Info.plist file!")
            return String()
        }
        
        do {
            let apiPlistData = try Data(contentsOf: plistPath)
            if let dict = try PropertyListSerialization.propertyList(from: apiPlistData, options: [], format: nil) as? [String: Any] {
                apiPlistDict = dict
            }
        } catch {
            print(error)
        }
        
        return apiPlistDict?["API_KEY"] as? String
    }()
    
    var delegate: YelpAPIManagerDelegate?
    
    func requestBusinesses(at location: String) {
        let urlString = "\(baseUrl)?location=\(location)"
        performRequest(with: urlString)
    }
    
    private func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        guard let apiKey = apiKey else {
            print("No API authentication key found!")
            return
        }
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        let urlSession = URLSession(configuration: .default)
        
        let task = urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                self.delegate?.didFailWithError(error)
                return
            }
            
            guard let safeData = data else { return }
            if let parsedData = self.parseJSON(from: safeData) {
                guard let businesses = parsedData.businesses else { return }
                self.delegate?.didUpdateBusinessesData(self, businesses: businesses)
            }
        }
        task.resume()
    }
    
    private func parseJSON(from data: Data) -> APIResponse? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(APIResponse.self, from: data)
            return decodedData
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}
