//
//  LoginViewController.swift
//  RentalSystem
//
//  Created by apple on 2020/11/15.
//

import UIKit



class LoginViewController: UIViewController {
    let networkController = NetworkController()
    
    var name: String?
    var word: String?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func login(_ sender: Any) {
        
        print("!!!!!!!!!!!!!!")
        if let username = self.view.viewWithTag(100) as? UITextField {
            name=username.text
           
            
        }
        if let password = self.view.viewWithTag(200) as? UITextField {
           word = password.text
            
            
        }
        
        
        
      
        networkController.fetchUsers(username:name ?? "??" ,password:word ?? "??",completionHandler: { (users) in
            DispatchQueue.main.async {
                let defaults = UserDefaults.standard
                defaults.set(users.id, forKey: "uid")
                defaults.set(users.username, forKey: "username")
                defaults.set(users.avatar, forKey: "avatar")
                let controller = UIAlertController(title: "Success", message:"Login Success",preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default){ (_) in self.navigationController?.popViewController(animated: true)}
                controller.addAction(okAction)
                self.present(controller, animated: true, completion: nil)
            
            
               
            
            
        }
        }){(error) in
            DispatchQueue.main.async {
                let controller = UIAlertController(title: "Warning", message:"Login Failure",preferredStyle: .alert)
                
                
            
        }
//            self.navigationController?.popViewController(animated: true)
        
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
