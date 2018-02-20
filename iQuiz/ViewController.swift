//
//  ViewController.swift
//  iQuiz
//
//  Created by Lisa Koss on 2/8/18.
//  Copyright © 2018 Lisa Koss. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let quizJson = "http://tednewardsandbox.site44.com/questions.json"
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
        let alert = UIAlertController(title: "Alert", message: "Settings go here.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Use URLSession methods
    func getUserDetails(){
        let url = URL(string: quizJson)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error ?? "")
                print("error 1")
            } else {
                do {
                    print("succesS")
                    let response = try JSONSerialization.jsonObject(with: data!, options: [])
                    self.successGetTermsData(response: response)
                } catch let error as NSError {
                    print(error)
                    print("error 2")
                }
            }
            
            DispatchQueue.main.async{
                self.tableCategories.reloadData()
            }
            }.resume()
    }
    
    func successGetTermsData(response: Any){
        let arrayOfDetails = response as? [[String: Any]]
        // Do Something with the Array
        //Here you will be get Array of User Related Details
        
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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableCategories.dataSource = self
        tableCategories.delegate = self
        tableCategories.tableFooterView = UIView() // makes the table the height of the view

        getUserDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

