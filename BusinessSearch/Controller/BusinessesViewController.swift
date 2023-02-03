//
//  ViewController.swift
//  BusinessSearch
//
//  Created by Fredy Sanchez on 02/02/23.
//

import UIKit

class BusinessesViewController: UIViewController {

    var location = String()
    
    var apiManager = YelpAPIManager()
    var businessesView: BusinessesView!
    var businesses = Businesses()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        businessesView = BusinessesView()
        view.addSubview(businessesView)
        businessesView.pinEdgesToSuperviewEdges()
        
        apiManager.delegate = self
        apiManager.requestBusinesses(at: location)
        
        businessesView.businessesTable.delegate = self
        businessesView.businessesTable.dataSource = self
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource conformance
extension BusinessesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.businesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BusinessCell.identifier, for: indexPath) as? BusinessCell else {
            fatalError("TableView could not dequeue a BusinessCell")
        }
        let business = businesses[indexPath.row]
        cell.configure(with: business)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let businessInfoVC = BusinessInfoViewController()
        let business = businesses[indexPath.row]
        businessInfoVC.business = business
        self.present(businessInfoVC, animated: true)
    }
}

//MARK: - YelpAPIManagerDelegate conformance
extension BusinessesViewController: YelpAPIManagerDelegate {
    func didFailWithError(_ error: Error) {
        DispatchQueue.main.async {
            switch(error) {
            case APIError.noData(let message):
                let errorLabel = UILabel()
                errorLabel.font = .systemFont(ofSize: 25)
                errorLabel.text = message
                errorLabel.textAlignment = .center
                self.businessesView.businessesTable.backgroundView = errorLabel
            default:
                print(error.localizedDescription)
            }
        }
    }
    
    func didUpdateBusinessesData(_ manager: YelpAPIManager, businesses: Businesses) {
        DispatchQueue.main.async {
            self.businesses = businesses
            self.businessesView.businessesTable.reloadData()
        }
    }
}
