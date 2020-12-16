//
//  DetailTableViewController.swift
//  RentalSystem
//
//  Created by apple on 2020/11/15.
//

import UIKit
import CoreData
class DetailTableViewController: UITableViewController {
    var property_title: String?
    var apartmentid:Int32?
    let networkController = NetworkController()
    
    
    
    var viewContext: NSManagedObjectContext?
    lazy var fetchedResultsController: NSFetchedResultsController<ApartmentManagedObject> = {
        
        let fetchRequest = NSFetchRequest<ApartmentManagedObject>(entityName:"ApartmentManagedObject")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending:true)]
        
        if let apartmentid = apartmentid{
            fetchRequest.predicate = NSPredicate(format: "id = %d", apartmentid)
        }
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: viewContext!,
                                                    sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        
        do {
            try controller.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let dataController = (UIApplication.shared.delegate as? AppDelegate)!.dataController!
        viewContext = dataController.persistentContainer.viewContext
        

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
        // #warning Incomplete implementation, return the number of rows
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell", for: indexPath)

        if let imageView = cell.viewWithTag(100) as? UIImageView {
                    
            networkController.fetchImage(for: fetchedResultsController.object(at: indexPath).image_URL!, completionHandler: { (data) in
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
            cellLabel.text = fetchedResultsController.object(at: indexPath).property_title
        }
        
        if let cellLabel = cell.viewWithTag(300) as? UILabel {
            cellLabel.text = "Estate: "+fetchedResultsController.object(at: indexPath).estate!+". Bedrooms: "+"\(fetchedResultsController.object(at: indexPath).bedrooms)"+". Rent: $"+"\(fetchedResultsController.object(at: indexPath).rent)"+". Tenants: "+"\(fetchedResultsController.object(at: indexPath).expected_tenants)"+". Area: "+"\(fetchedResultsController.object(at: indexPath).gross_area)";
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
        if let viewController = segue.destination as? MapViewController {
                
            
            viewController.Uestate = fetchedResultsController.object(at: [0,0]).estate            }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func movin(_ sender: Any) {
        let controller = UIAlertController(title: "Are you sure?", message:"to move in this apartment?",preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
         let okAction = UIAlertAction(title: "Yes", style: .default, handler: {
            action in
            print("点击了确定")
            self.networkController.moveIn(uid: Int(self.fetchedResultsController.object(at: [0,0]).id), completionHandler: { (response) in
                DispatchQueue.main.async {
                    
                    let success = UIAlertController(title: "Move-in successfully", message: "", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                    success.addAction(ok)
                    self.present(success,animated: true, completion: nil)
                }
            }) { (error) in
                DispatchQueue.main.async {
                    let fail = UIAlertController(title: "Already full", message: "", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                    fail.addAction(ok)
                    self.present(fail,animated: true, completion: nil)
                }
            
            
        }
            
        })
        controller.addAction(cancelAction)
        controller.addAction(okAction)
        self.present(controller, animated: true, completion: nil)
    }
    
}
extension DetailTableViewController: NSFetchedResultsControllerDelegate {

}
