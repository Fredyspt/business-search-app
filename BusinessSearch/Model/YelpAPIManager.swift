//
//  YelpAPIManager.swift
//  BusinessSearch
//
//  Created by Fredy Sanchez on 02/02/23.
//

import UIKit

protocol YelpAPIManagerDelegate {
    func didFailWithError(_ error: Error)
    func didUpdateBusinessesData(_ manager: YelpAPIManager, businesses: Businesses)
}

enum APIError: Error {
    case authentication(String)
    case noData(String)
}

/*
 This structure takes care of all of the necessary networking and JSON response parsing.
 It informs the delegate whenever a fail occurs on an API call, or passes the data when
 the call was successful.
 */
struct YelpAPIManager {
    private let baseUrl = "https://api.yelp.com/v3/businesses/search"
    
    /*
     API Key found on the API-Info.plist file, at the API_KEY field.
     */
    private let apiKey: String? = {
        var apiPlistDict: [String: Any]?
        guard let plistPath = Bundle.main.url(forResource: "API-Info", withExtension: "plist") else {
            print("Could find API-Info.plist file!")
            return nil
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
    
    /*
     Perform API call to request businesses at the given location
     */
    func requestBusinesses(at location: String) {
        let urlString = "\(baseUrl)?location=\(location)"
        performRequest(with: urlString)
    }
    
    private func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        guard let apiKey = apiKey else {
            self.delegate?.didFailWithError(APIError.authentication("No authentication key found!"))
            return
        }
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                self.delegate?.didFailWithError(error)
                return
            }
            
            guard let data else { return }
            if let parsedData = self.parseJSON(from: data) {
                guard let businesses = parsedData.businesses else {
                    self.delegate?.didFailWithError(APIError.noData("No businesses found in the area :("))
                    return
                }
                self.delegate?.didUpdateBusinessesData(self, businesses: businesses)
            }
        }.resume()
    }
    
    /*
     For the current scope of the project, we can define the specific return type of this function
     as we are only making a call to one API endpoint. In the case that more endpoints are required,
     this function should be done using Generics
     */
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
