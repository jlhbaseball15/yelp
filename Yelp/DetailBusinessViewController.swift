//
//  DetailBusinessViewController.swift
//  Yelp
//
//  Created by John Henning on 1/31/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class DetailBusinessViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingsImageView: UIImageView!
    
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    var business: Business!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodImageView.setImageWithURL(business.imageURL!)
        foodImageView.layer.cornerRadius = 3
        foodImageView.clipsToBounds = true;
        nameLabel.text = business.name
        nameLabel.sizeToFit()
        addressLabel.text = business.address
        addressLabel.sizeToFit()
        descriptionLabel.text = business.categories
        descriptionLabel.sizeToFit()
        
        reviewCountLabel.text = "\(business.reviewCount!) Reviews"
        
        
        ratingsImageView.setImageWithURL(business.ratingImageURL!)
        
        self.addByAddress(business)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addByAddress(business: Business) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(business.address!, completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            if let placemark = (placemarks![0]) as? CLPlacemark {
                self.goToLocation(CLLocation(latitude: business.latitude!, longitude: business.longitude!))
                self.addAnnotationAtCoordinate(business.name!, place: MKPlacemark(placemark: placemark))
            }
        })
    }
    
    
    func addAnnotationAtCoordinate(name: String, place: MKPlacemark) {
        let placeLat = place.coordinate.latitude
        let placeLong = place.coordinate.longitude
        
        print(name)
        
        let annotation = MKPointAnnotation()
        annotation.title = name
        annotation.coordinate.latitude = placeLat
        annotation.coordinate.longitude = placeLong
        mapView.addAnnotation(annotation)
    }
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
