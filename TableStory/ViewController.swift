//
//  ViewController.swift
//  TableStory
//
//  Created by Hastings, Lettie on 3/20/24.
//

import UIKit
import MapKit


//array objects of our data.
let data = [
    Item(name: "Alive + Well", neighborhood: "Austin", desc: "Alive and Well offers an inclusive environment with a wide variety of wellness options to achieve optimal health.", lat: 30.308961298558728, long: -97.94721837010198 , imageName: "spa1"),
    Item(name: "Infinity Wellness", neighborhood: "Austin", desc: "They can find the root causes of your chronic fatigue, anxiety, hormonal imbalances and gut issues, then fix them using a data-driven approach.", lat: 30.17376897757856, long: -97.81290415846024, imageName: "spa2"),
    Item(name: "Kuya", neighborhood: "Austin", desc: "A sanctuary of health & community that transcends the boundaries of traditional healthcare.", lat: 30.20691673122389, long: -97.7478957738018, imageName: "spa3"),
    Item(name: "Breath of Life", neighborhood: ":Pflugerville", desc: "Offers the highest standard of care to our patients to help them look and feel their best.", lat: 30.449772806687445, long: -97.63771526270367, imageName: "spa4"),
    Item(name: "Serasana", neighborhood: "Dripping Springs", desc: "This clinic uses ancient wellness practices, specializing in rejuvenation through stress and pain management.", lat: 30.20433405865484, long: -97.98069375476194, imageName: "spa5")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}





class ViewController: 
        UIViewController,
        UITableViewDelegate,
        UITableViewDataSource {

    
    
    
    
    
    
    @IBOutlet weak var theTable: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return data.count
   }


   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
       let item = data[indexPath.row]
       cell?.textLabel?.text = item.name
       
       
       
       
       //Add image references
       let image = UIImage(named: item.imageName)
       cell?.imageView?.image = image
       cell?.imageView?.layer.cornerRadius = 10
       cell?.imageView?.layer.borderWidth = 5
       cell?.imageView?.layer.borderColor = UIColor.white.cgColor
       
       
       
       return cell!
   }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        performSegue(withIdentifier: "ShowDetailSegue", sender: item)
      
    }
    
    // add this function to original ViewController
           override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "ShowDetailSegue" {
                 if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                     // Pass the selected item to the detail view controller
                     detailViewController.item = selectedItem
                 }
             }
         }
         
             
        
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        theTable.delegate = self
        theTable.dataSource = self
       
        //add this code in viewDidLoad function in the original ViewController, below the self statements

        //set center, zoom level and region of the map
            let coordinate = CLLocationCoordinate2D(latitude: 30.247634229222076, longitude: -97.77718089764139)
            let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
            mapView.setRegion(region, animated: true)
            
         // loop through the items in the dataset and place them on the map
             for item in data {
                let annotation = MKPointAnnotation()
                let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                annotation.coordinate = eachCoordinate
                    annotation.title = item.name
                    mapView.addAnnotation(annotation)
                    }
    }


}

