//
//  HomeScreenVC.swift
//  LandmarkRemark
//
//  Created by Parth on 03/12/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import UIKit
import MapKit

class HomeScreenVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!

    let style: Style
    
    let viewModel: HomeScreenViewModel

    // MARK: - ViewController LifeCycle
    init(nibName:String, style: Style, viewModel: HomeScreenViewModel){
        self.style = style
        self.viewModel = viewModel
        super.init(nibName: nibName, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialSetup()
        applyStyle()
        requestUserLocation()
        setUpData()
    }

    private func setUpData() {
        title = viewModel.navigationBarTitle
        setUpAllLandmarkRemarksInMap()
    }
    
    // MARK: - Helper methods
    private func initialSetup() {
        let refreshButton = UIBarButtonItem(barButtonSystemItem:
            UIBarButtonItem.SystemItem.refresh, target: self, action:
            #selector(refreshCurrentLocation))
        let searchButton = UIBarButtonItem(barButtonSystemItem:
            UIBarButtonItem.SystemItem.search, target: self, action:
            #selector(searchButtonTapped))

        navigationItem.leftBarButtonItems  = [refreshButton, searchButton]
        let createNoteButton = UIBarButtonItem(barButtonSystemItem:
            UIBarButtonItem.SystemItem.compose, target: self, action:
            #selector(createNote))
        
        let logOutButton = UIBarButtonItem(image: UIImage.init(named: "Logout"), style: .plain, target: self, action: #selector(logOut))
        navigationItem.rightBarButtonItems = [createNoteButton, logOutButton]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    private func applyStyle() {
        view.backgroundColor = style.backgroundColor
    }
    
    @objc private func searchButtonTapped() {
        let landmarkListVC = LandmarkListVC(nibName: "LandmarkListVC", style: .landmarkRemark)
        landmarkListVC.landmarkSelection = { selectedRemark in
            self.setUpSelectedLandmarkRemarkInMap(selectedRemark)
        }
        self.navigationController?.pushViewController(landmarkListVC, animated:true)
    }
    
    @objc private func refreshCurrentLocation() {
        requestUserLocation()
    }
    
    @objc private func logOut() {
        
        let dialogMessage = UIAlertController(title: "LandmarkRemark", message: "Are you sure you want to Logout?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.executeLogout()
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
        }
        
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        present(dialogMessage, animated: true, completion: nil)
    }
    
    @objc private func createNote() {
        requestUserLocation()
        let alert = UIAlertController(title: "Enter remark for this landmark/place.", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter your remark here.."
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if let remark = alert.textFields?.first?.text {
                self.showLoadingIndicator(onView: self.view)
                self.viewModel.createLandmarkRemark(text: remark, completion: { (landmarkRemark) in
                    DispatchQueue.main.async {
                        //update UI
                        self.removeLoadingIndicator()
                        if let errorMessage = self.viewModel.error {
                            self.presentAlert(withTitle: "Error", message: errorMessage)
                        }
                        else{
                            //Add nealy created annotation to map...
                            self.addAnnotation(landmarkRemark!)
                        }
                    }
                })
            }
        }))
        
        self.present(alert, animated: true)
    }
    
    private func addAnnotation(_ remark: LandmarkRemark) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = Coordinate(latitude: remark.latitude, longitude: remark.longitude)
        annotation.title = remark.username
        annotation.subtitle = remark.remark
        DispatchQueue.main.async {
            self.mapView.addAnnotation(annotation)
        }
    }
    
    private func executeLogout() {
        viewModel.executeLogout {
            if self.viewModel.error == nil {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.redirectToLandingScreen()
            }
        }
    }

    private func requestUserLocation() {
        viewModel.locationProvider.findUserLocation { [weak self] location, error in
            if error == nil {
                self?.viewModel.userLocation = location
                self?.removeLastUserLocationAnnotation()
                self?.setUpUserLocationInMap()
            } else {
                self?.presentAlert(withTitle: "Error", message: error!.localizedDescription)
            }
        }
    }
    
    private func removeLastUserLocationAnnotation() {
        for annotation in mapView.annotations as [MKAnnotation] {
            if let _ = annotation as? UserAnnotation {
                mapView.removeAnnotation(annotation)
                break
            }
        }
    }
    
    private func setUpUserLocationInMap() {
        if let location = viewModel.userLocation {
            let span = MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
            let annotation = UserAnnotation(coordinate: location.coordinate, title: "You")
            DispatchQueue.main.async {
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    private func setUpSelectedLandmarkRemarkInMap(_ remark: LandmarkRemark) {
        let span = MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
        let coordinate = CLLocationCoordinate2D(latitude: remark.latitude, longitude: remark.longitude)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        DispatchQueue.main.async {
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    private func setUpAllLandmarkRemarksInMap() {
        viewModel.getAllLandmarkRemarks {
            for remark in self.viewModel.allLandmarkRemarksArray {
                self.addAnnotation(remark)
            }
        }
    }
    
    // MARK: - mapView methods
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "LandmarkRemarkAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.isEnabled = true
            annotationView!.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView!.rightCalloutAccessoryView = btn
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation, let strRemark = annotation.subtitle {
            presentAlert(withTitle: "remark", message: strRemark ?? "No remark found..")
        }
    }
}
