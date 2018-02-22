//
//  ViewController.swift
//  iQuiz
//
//  Created by Lisa Koss on 2/8/18.
//  Copyright © 2018 Lisa Koss. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var quizJson = "http://tednewardsandbox.site44.com/questions.json"
    var quizCategories: [Category] = []
    @IBOutlet weak var tableCategories: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        let categoryName = quizCategories[indexPath.row]
        
        cell.textLabel?.text = categoryName.categoryTitle
        cell.detailTextLabel?.text = categoryName.categoryDescription
        cell.imageView?.image = UIImage(named: categoryName.categoryTitle)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let questionViewController = self.storyboard?.instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController
        questionViewController.category = self.quizCategories[indexPath.row]
        self.present(questionViewController, animated: true, completion: nil)
    }
    
    @IBAction func settingsButton(_ sender: Any) {
        let alert = UIAlertController(title: "Data Retrieval", message: "Enter URL to retrieve data from:", preferredStyle: .alert)
        let defaults = UserDefaults.standard
        
        alert.addTextField(configurationHandler: {(textField: UITextField!) in })
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Check Now", comment: "Default action"), style: .default, handler: { (UIAlertAction) in
            print(alert.textFields![0].text!)
            
            self.quizCategories = []
            self.quizJson = alert.textFields![0].text!
            defaults.set(self.quizJson, forKey: "json_url")
            self.getUserDetails()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if let quizUrl = defaults.string(forKey: "json_url") {
            alert.textFields![0].text! = quizUrl
        } else {
            alert.textFields![0].text! = ""
        }
    
        self.present(alert, animated: true, completion: nil)
    }
    
    // Use URLSession methods
    // referenced from https://stackoverflow.com/questions/42130002/post-data-and-get-data-from-json-url-in-swift
    // referenced from https://www.simplifiedios.net/swift-json-tutorial/
    func getUserDetails(){
        if Reachability.isConnectedToNetwork() == true {
            let url = URL(string: quizJson)
            URLSession.shared.dataTask(with:url!) { (data, response, error) in
                if error != nil {
                    print(error ?? "")
                    let alert = UIAlertController(title: "Error", message: "Cannot retrieve JSON file.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: "Default action"), style: .default, handler: nil ))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    do {
                        let response = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray
                        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("questions.json")
                        try response?.write(to: path)

                        print(NSHomeDirectory())
                        self.successGetTermsData(response: response!)
                    } catch let error as NSError {
                        print(error)
                        
                        let alert = UIAlertController(title: "Error", message: "Please provide a valid JSON file.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: "Default action"), style: .default, handler: nil ))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
                DispatchQueue.main.async{
                    self.tableCategories.reloadData()
                }
                }.resume()
        } else {
            DispatchQueue.main.async{
                let alert = UIAlertController(title: "No Internet Connection", message: "Please reconnect to the internet.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: "Default action"), style: .default, handler: nil ))
                self.present(alert, animated: true, completion: nil)
                
                let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("questions.json")
                let localJson = NSArray(contentsOf: path)
                self.successGetTermsData(response: localJson!)
            }
        }
    }
    
    func successGetTermsData(response: NSArray){
        let arrayOfDetails = response as? [[String: Any]]

        for category in arrayOfDetails! {
            var questions:[Question] = []
            var answers:[String] = []
    
            let title = category["title"] as! String
            let description = category["desc"] as! String
            let questionContents = category["questions"] as! [[String: Any]]
            
            for question in questionContents {
                let text = question["text"] as! String
                let correctAnswer = question["answer"] as! String

                answers = question["answers"] as! [String]

                let finalQuestion = Question(question: text, answers: answers, correctAnswer: Int(correctAnswer)!)
                questions.append(finalQuestion)
            }
            
            let finalCategory = Category(categoryTitle: title, categoryDescription: description, questions:questions)
            quizCategories.append(finalCategory)
        }
    }
    
    // referenced from: https://makeapppie.com/2016/03/14/using-settings-bundles-with-swift/
    func registerSettingsBundle(){
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableCategories.dataSource = self
        tableCategories.delegate = self
        tableCategories.tableFooterView = UIView() // makes the table the height of the view

        registerSettingsBundle()
        if(UserDefaults.standard.string(forKey: "json_url") != nil) {
            quizJson = UserDefaults.standard.string(forKey: "json_url")!
        }
        
        getUserDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

