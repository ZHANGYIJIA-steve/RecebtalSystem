//
//  UserViewController.swift
//  RentalSystem
//
//  Created by apple on 2020/11/16.
//

import UIKit

class UserViewController: UIViewController {
    let networkController = NetworkController()

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "avatar") == nil{
            return
        }
        if let imageView = self.view.viewWithTag(100) as? UIImageView {
            networkController.fetchImage(for: defaults.string(forKey: "avatar")!, completionHandler: { (data) in
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data, scale:1)
                }
            }) { (error) in
                DispatchQueue.main.async {
                    imageView.image = UIImage(named: "hkbu_logo")
                }
            }
            if let Label = self.view.viewWithTag(200) as? UILabel {
                Label.text = defaults.string(forKey: "username")
            }
            
           
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func logout(_ sender: Any) {
        networkController.logout()
        
        let userDefaults = UserDefaults.standard
        
        if userDefaults.string(forKey: "avatar") == nil{
            print("empty")
            return
        }
       
          let dics = userDefaults.dictionaryRepresentation()
          for key in dics {
              userDefaults.removeObject(forKey: key.key)
          }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
