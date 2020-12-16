//
//  BedroomsTableViewController.swift
//  RentalSystem
//
//  Created by apple on 2020/11/13.
//

import UIKit


class BedroomsTableViewController: UITableViewController {

    

    override func viewDidLoad() {
        super.viewDidLoad()
     

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(reloadItin), for: UIControl.Event.valueChanged)

        self.refreshControl = refreshControl
    }
    @objc func reloadItin() {
            
        self.tableView.reloadData()
        
        refreshControl?.endRefreshing()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Apartment.sampleData.count }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bedroomscell", for: indexPath)
              // Configure the cell...
        if indexPath.row==0{
        cell.textLabel?.text = "bedrooms<= "+"\(Apartment.sampleData[indexPath.row].bedrooms)";
        }else if indexPath.row==1{
            cell.textLabel?.text = "bedrooms>= "+"\(Apartment.sampleData[indexPath.row].bedrooms)";        }
        print(indexPath.row)
        //cell.imageView?.image = UIImage(named: apartment.sampleData[indexPath.row].image_URL);
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
        if let viewController = segue.destination as? propertyTableViewController {
                
                let selectedIndex = tableView.indexPathForSelectedRow!
            
            viewController.bedrooms=Apartment.sampleData[selectedIndex.row].bedrooms
            }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

