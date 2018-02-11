//
//  ViewController.swift
//  iQuiz
//
//  Created by Lisa Koss on 2/8/18.
//  Copyright © 2018 Lisa Koss. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    var quizCategories = ["Mathematics", "Marvel Super Heroes", "Science"]
    @IBOutlet weak var tableCategories: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        let categoryName = quizCategories[indexPath.row]
        
        cell.textLabel?.text = categoryName
        cell.detailTextLabel?.text = "Test your knowledge at \(categoryName)!"
        cell.imageView?.image = UIImage(named: categoryName)
        
        return cell
    }
    
    @IBAction func settingsButton(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "Settings go here.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableCategories.dataSource = self
        tableCategories.tableFooterView = UIView() // makes the table the height of the view
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

