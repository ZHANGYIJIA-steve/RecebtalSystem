//
//  NetworkController.swift
//  RentalSystem
//
//  Created by apple on 2020/11/13.
//

import Foundation
class NetworkController {
    func fetchApartments(completionHandler: @escaping ([Apartments]) -> (),
                        errorHandler: @escaping (Error?) -> ()) {
        
        let url = URL(string: "https://morning-plains-00409.herokuapp.com/property/json")!
        
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                // Server error encountered
                errorHandler(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode < 300 else {
                    // Client error encountered
                    errorHandler(nil)
                    return
            }
            
            guard let data = data, let apartments =
                try? JSONDecoder().decode([Apartments].self, from: data) else {
                    errorHandler(nil)
                    return
            }
            
            // Call our completion handler with our news
            completionHandler(apartments)
        }
        
        task.resume()
    }
    func fetchMyRentals(completionHandler: @escaping ([Apartments]) -> (),
                        errorHandler: @escaping (Error?) -> ()) {
        
        let url = URL(string: "https://morning-plains-00409.herokuapp.com/user/myRentals")!
        
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                // Server error encountered
                errorHandler(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode < 300 else {
                    // Client error encountered
                    errorHandler(nil)
                    return
            }
            
            guard let data = data, let apartments =
                try? JSONDecoder().decode([Apartments].self, from: data) else {
                    errorHandler(nil)
                    return
            }
            
            // Call our completion handler with our news
            completionHandler(apartments)
        }
        
        task.resume()
    }
    func fetchUsers(username: String,password:String,completionHandler: @escaping (User) -> (),
                        errorHandler: @escaping (Error?) -> ()) {
        
        let url = URL(string: "https://morning-plains-00409.herokuapp.com/user/login")!
        var request = URLRequest(url: url)
           request.httpMethod = "POST"
        let address = "username="+username+"&password="+password
        
     
        request.httpBody = address.data(using: .utf8)
            // pass dictionary to nsdata object and set it as request body
           
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Accept")
//        
        print("?????????")
        print(request)
        let task = URLSession.shared.dataTask(with:request) { (data, response, error) in
            if let error = error {
                // Server error encountered
                
                print("111111111111111")
                errorHandler(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode < 300 else {
                    // Client error encountered
                print("2222222222222222")
                    errorHandler(nil)
                    return
            }
            print(response.statusCode)
            
            guard let data = data, let user =
                try? JSONDecoder().decode(User.self, from: data) else {
                print("3333333333333")
                    errorHandler(nil)
                    return
            }
            
            // Call our completion handler with our news
            completionHandler(user)
        }
        
        task.resume()
    }
    func moveIn(uid:Int,completionHandler: @escaping (User) -> (),
                        errorHandler: @escaping (Error?) -> ()) {
        
        let url = URL(string: "https://morning-plains-00409.herokuapp.com/user/rent/\(uid)")!
        var request = URLRequest(url: url)
           request.httpMethod = "POST"
        
        
     
        
            // pass dictionary to nsdata object and set it as request body
           
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Accept")
//
        print(request)
        let task = URLSession.shared.dataTask(with:request) { (data, response, error) in
            if let error = error {
                // Server error encountered
                
                print("111111111111111")
                errorHandler(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode != 404 else {
                    // Client error encountered
                print("2222222222222222")
                    errorHandler(nil)
                    return
            }
            print(response.statusCode)
            
        }
        
        task.resume()
    }
    func logout() {
        
        let url = URL(string: "https://morning-plains-00409.herokuapp.com/user/logout")!
        var request = URLRequest(url: url)
           request.httpMethod = "POST"
       
            // pass dictionary to nsdata object and set it as request body
           
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Accept")
//
        print("?????????")
        print(request)
        let task = URLSession.shared.dataTask(with:request) { (data, response, error) in
            if let error = error {
                // Server error encountered
                
                print("111111111111111")
                //errorHandler(error)
                return
            }
            guard let response = response as? HTTPURLResponse,
                response.statusCode < 300 else {
                    // Client error encountered
                print("2222222222222222")
                    //errorHandler(nil)
                    return
            }
            print(response.statusCode)
            
           
            
            
            
            // Call our completion handler with our news
           
        }
        
        task.resume()
    }
    func fetchImage(for imageUrl: String, completionHandler: @escaping (Data) -> (),
                    errorHandler: @escaping (Error?) -> ()) {
        
        let url = URL(string: imageUrl)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                // Server error encountered
                errorHandler(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode < 300 else {
                    // Client error encountered
                    errorHandler(nil)
                    return
            }
            
            guard let data = data else {
                errorHandler(nil)
                return
            }
            
            // Call our completion handler with our news
            completionHandler(data)
        }
        
        task.resume()
    }
}



   

struct Apartments: Codable {

    let id: Int
    let property_title : String
    let image_URL:String
    let estate: String
    let bedrooms: Int
    let gross_area:Int
    let expected_tenants : Int
    let rent:Int

}
struct User: Codable{
        let id: Int
        let username :String
        let avatar: String
}
