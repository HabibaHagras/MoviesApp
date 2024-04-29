//
//  ViewController.swift
//  lab1day2swift
//
//  Created by habiba on 4/24/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    @IBAction func empButton(_ sender: UIButton) {
        print("ddddddddd")

                 let salaryText = salaryTXT.text ?? "0"
                     if let salary = Int(salaryText) {
                         let emp = Emp()
                         emp.s = salary
                        print(emp.s)
                        label.text = String(emp.getSalary())
        
                     } else {
                                label.text = "Invalid input"
                            }
        
    }
    @IBOutlet weak var salaryTXT: UITextField!
    @IBOutlet weak var managerbutton: UIButton!
  
    
    

    
    
    @IBAction func mangAction(_ sender: UIButton) {
        print("ddddddddd")
        let salaryText = salaryTXT.text ?? "0"
        if let salary = Int(salaryText) {
            let manager = Manager()
            manager.s = salary
            print(manager.s)
            label.text = String(manager.getSalary())
            
        } else {
            label.text = "Invalid input"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let p = Person()
        //        self.salaryTXT.text = String(p.s)
        //
        
    }
    
    
}

class Person {
    var s: Int = 0
    
    func getSalary() -> Int {
        return s

    }
}

class Manager: Person {
    override func getSalary() -> Int {
        return super.getSalary() * 3
    }
}

class Emp: Person {
    override func getSalary() -> Int {
        return super.getSalary()
    }
}
