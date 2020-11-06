//
//  ViewController.swift
//  Firebase101
//
//  Created by 서보경 on 2020/11/06.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var numOfCustomers: UILabel!
    
    let db = Database.database().reference()
    
    var customers: [Customer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabel()
        fetchCustomers()
    }
    
    func updateLabel() {
        db.child("firstdata").observeSingleEvent(of: .value) { snapshot in
            let value = snapshot.value as? String ?? ""
            
            DispatchQueue.main.async {
                self.firstLabel.text = value
            }
            
        }
    }

    @IBAction func createCustomer(_ sender: UIButton) {
        saveCustomers()
    }
    
    
    @IBAction func fetchCustomer(_ sender: UIButton) {
        fetchCustomers()
    }
    
    func updateCustomers() {
        guard customers.isEmpty == false else { return }
        customers[0].name = "Cocoa"
        
        let dict = customers.map{ $0.toDictionary }
        db.updateChildValues(["customers": dict])

    }
    
    @IBAction func updateCustomer(_ sender: UIButton) {
        updateCustomers()
    }
    
    func deleteCustomers() {
        
    }
    
    @IBAction func deleteCustomer(_ sender: UIButton) {
        deleteCustomers()
    }
}

// MARK: - Update Data, Delete Data
extension ViewController {
    func updateBasicTypes() {
        db.updateChildValues(["int": 6])
        db.updateChildValues(["double": 5.5])
        db.updateChildValues(["str": "updated"])
    }
    func deleteBasicTypes() {
        db.child("int").removeValue()
        db.child("double").removeValue()
        db.child("str").removeValue()
    }
}

// MARK: - Read(Fetch) Data
extension ViewController {
    func fetchCustomers() {
        db.child("customers").observeSingleEvent(of: .value) { snapshot in
            do {
                let data = try JSONSerialization.data(withJSONObject: snapshot.value, options: [])
                let decoder = JSONDecoder()
                self.customers = try decoder.decode([Customer].self, from: data)
                
                DispatchQueue.main.async {
                    self.numOfCustomers.text = "# of Customers: \(self.customers.count)"
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }
    }
}

// MARK: - Save Data
extension ViewController {
    func saveBasicTypes() {
        db.child("int").setValue(10)
        db.child("double").setValue(3.5)
        db.child("str").setValue("Hello World")
        db.child("array").setValue([ "a", "b", "c" ])
        db.child("dict").setValue([ "id": "abc", "age": 10, "city": "seoul" ])
    }
    
    func saveCustomers() {
        // 서점
        // 사용자를 저장함
        // 모델 Customer + Book
        let books = [
            Book(title: "Good to Great", author: "someone"),
            Book(title: "Hacking Growth", author: "somebody")
        ]
        let customer1 = Customer(id: "\(Customer.id)", name: "Dotty", books: books)
        Customer.id += 1
        let customer2 = Customer(id: "\(Customer.id)", name: "Tammy", books: books)
        Customer.id += 1
        let customer3 = Customer(id: "\(Customer.id)", name: "Maple", books: books)
        Customer.id += 1
        let customer4 = Customer(id: "\(Customer.id)", name: "Rosie", books: books)
        Customer.id += 1
        let customer5 = Customer(id: "\(Customer.id)", name: "Flurry", books: books)
        Customer.id += 1
        
        db.child("customers").child(customer1.id).setValue(customer1.toDictionary)
        db.child("customers").child(customer2.id).setValue(customer2.toDictionary)
        db.child("customers").child(customer3.id).setValue(customer3.toDictionary)
        db.child("customers").child(customer4.id).setValue(customer4.toDictionary)
        db.child("customers").child(customer5.id).setValue(customer5.toDictionary)
    }
}

struct Customer: Codable {
    let id: String
    var name: String
    let books: [Book]
    
    var toDictionary: [String: Any] {
        let booksArray = books.map{ $0.toDictionary }
        let dict: [String: Any] = ["id": id, "name": name, "books": booksArray]
        return dict
    }
    
    static var id: Int = 0
    
}


struct Book: Codable {
    let title: String
    let author: String
    var toDictionary: [String: Any] {
        let dict: [String: Any] = ["title": title, "author": author]
        return dict
    }
}
