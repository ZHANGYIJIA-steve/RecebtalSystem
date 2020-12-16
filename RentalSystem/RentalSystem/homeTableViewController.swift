//
//  homeTableViewController.swift
//  RentalSystem
//
//  Created by apple on 2020/11/13.
//

import UIKit

class homeTableViewController: UITableViewController {
    let networkController = NetworkController()
    var apartments: [Apartments] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        networkController.fetchApartments(completionHandler:
            { (apartments) in
                DispatchQueue.main.async {
                    self.apartments = apartments
                    self.tableView.reloadData()
                }
        }) { (error) in
            DispatchQueue.main.async {
                self.apartments = []
                self.tableView.reloadData()
            }
        }
        
       

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
        return apartments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "apartmentcell", for: indexPath)

        if let imageView = cell.viewWithTag(100) as? UIImageView {
                    
            networkController.fetchImage(for: apartments[indexPath.row].image_URL, completionHandler: { (data) in
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data, scale:1)
                }
            }) { (error) in
                DispatchQueue.main.async {
                    imageView.image = UIImage(named: "hkbu_logo")
                }
            }
            
        }
        
        if let cellLabel = cell.viewWithTag(200) as? UILabel {
            cellLabel.text = apartments[indexPath.row].property_title
        }
        
        if let cellLabel = cell.viewWithTag(300) as? UILabel {
            cellLabel.text = apartments[indexPath.row].estate
        }
        if let cellLabel = cell.viewWithTag(400) as? UILabel {
            cellLabel.text = "Rent:  "+"\(apartments[indexPath.row].rent)"+"$"
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? DetailTableViewController {
                
                let selectedIndex = tableView.indexPathForSelectedRow!
            viewController.apartmentid = Int32(apartments[selectedIndex.row].id);
            
//            viewController.estate=Apartment.sampleData[selectedIndex.row].estate
            }         // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    


