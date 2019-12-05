//
//  LandmarkListVC.swift
//  LandmarkRemark
//
//  Created by Parth on 05/12/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import UIKit

class LandmarkListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let viewModel = LandmarkListViewModel()

    var landmarkSelection : ((LandmarkRemark)->())?

    let style: Style

    // MARK: - ViewController LifeCycle
    init(nibName:String, style: Style){
        self.style = style
        super.init(nibName: nibName, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return style.preferredStatusBarStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        applyStyle()
    }
    
    // MARK: - Helper methods
    private func applyStyle() {
        tableView.register(LandmarkRemarkListCell.self, forCellReuseIdentifier: "LandmarkListCellIdentifier")
        view.backgroundColor = style.backgroundColor
    }
    
    private func initialSetup() {
        title = viewModel.navigationBarTitle
        searchBar.placeholder = viewModel.searchBarPlaceHolder
    }

}

// MARK: - UISearchBarDelegate methods
extension LandmarkListVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        self.searchBarSearchBegin(searchBar)
    }
    
    func searchBarSearchBegin(_ searchBar: UISearchBar) {
        let strText: String =  searchBar.text!.replacingOccurrences(of: " ", with: "")
        if (strText ).isEmpty {
            return
        } else {
            self.showLoadingIndicator(onView: self.view)
            DispatchQueue.main.async {
                self.viewModel.filteredLandmarkRemark.removeAll()
                self.searchLandmarks(strText)
            }
        }
    }
    
    func searchLandmarks(_ searchText: String) {
        viewModel.searchLandmarkRemarks(text: searchText, completion: {() in
            self.tableView.reloadData()
            self.removeLoadingIndicator()
            if self.viewModel.filteredLandmarkRemark.count == 0 {
                self.presentAlert(withTitle: "Landmark Remark", message: "No results found..")
            }
        })
    }
}

extension LandmarkListVC : UITableViewDataSource, UITableViewDelegate{
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredLandmarkRemark.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LandmarkListCellIdentifier", for: indexPath)
        let landmarkRemark = viewModel.filteredLandmarkRemark[indexPath.row]
        cell.textLabel?.numberOfLines = 1
        cell.detailTextLabel?.numberOfLines = 0
        cell.textLabel?.text = "Username::  " + landmarkRemark.username
        cell.detailTextLabel?.text = "Remark:  " + landmarkRemark.remark
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedLandmarkRemark = viewModel.filteredLandmarkRemark[indexPath.row]
        landmarkSelection?(selectedLandmarkRemark)
        navigationController?.popViewController(animated: true)
    }
    
}
