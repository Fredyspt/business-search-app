//
//  SearchViewController.swift
//  BusinessSearch
//
//  Created by Fredy Sanchez on 02/02/23.
//

import UIKit

class SearchViewController: UIViewController {
    var searchView: SearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchView = SearchView()
        view.addSubview(searchView)
        searchView.pinEdgesToSuperviewEdges()
     
        searchView.searchField.delegate = self
        searchView.searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
    }
    
    @objc func searchButtonPressed() {
        if searchView.searchField.isEditing {
            searchView.searchField.endEditing(true)
        }
    }
}

//MARK: - UITextFieldDelegate conformance
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let location = textField.text else { return }
        var locationTrimmed = location
        if locationTrimmed.last == " " {
            locationTrimmed.removeLast()
        }
        let businessesVC = BusinessesViewController()
        businessesVC.location = locationTrimmed
        navigationController?.pushViewController(businessesVC, animated: true)
        
        textField.text = String()
    }
}
