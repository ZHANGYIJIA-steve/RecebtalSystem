//
//  titleTableViewController.swift
//  RentalSystem
//
//  Created by apple on 2020/11/13.
//

import UIKit
import CoreData
class propertyTableViewController: UITableViewController{
    var estate: String?
    var bedrooms: Int?
    
    
    var viewContext: NSManagedObjectContext?
        
    lazy var fetchedResultsController: NSFetchedResultsController<ApartmentManagedObject> = {
        
        let fetchRequest = NSFetchRequest<ApartmentManagedObject>(entityName:"ApartmentManagedObject")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending:true)]
        
        if let estate = estate{
            fetchRequest.predicate = NSPredicate(format: "estate = %@", estate)
        }else if bedrooms==2{
            fetchRequest.predicate = NSPredicate(format: "bedrooms <= 2")
            
        }else if bedrooms==3{
            fetchRequest.predicate = NSPredicate(format: "bedrooms >= 3")        }
        
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
//         #warning Incomplete implementation, return the number of rows
//        chosenapartment = Apartment.sampleData.filter{$0.estate==estate||$0.bedrooms==bedrooms}
//
//        return chosenapartment.count
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "propertycell", for: indexPath)
        
//        cell.textLabel?.text = chosenapartment[indexPath.row].property_title
//        cell.detailTextLabel?.text = chosenapartment[indexPath.row].estate
        cell.textLabel?.text = fetchedResultsController.object(at: indexPath).property_title
        cell.detailTextLabel?.text = fetchedResultsController.object(at: indexPath).estate

        // Configure the cell...

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
            viewController.apartmentid = fetchedResultsController.object(at: selectedIndex).id
            
//            viewController.estate=Apartment.sampleData[selectedIndex.row].estate
            }         // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
extension propertyTableViewController: NSFetchedResultsControllerDelegate {

}
