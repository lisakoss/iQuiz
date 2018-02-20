//
//  ViewController.swift
//  iQuiz
//
//  Created by Lisa Koss on 2/8/18.
//  Copyright © 2018 Lisa Koss. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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
        let category = quizCategories[indexPath.row]
        NSLog("User selected row at \(category)")
        
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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableCategories.dataSource = self
        tableCategories.delegate = self
        tableCategories.tableFooterView = UIView() // makes the table the height of the view
        
        let mathQuestion1 = Question(question: "What is 2 + 2?", answers: ["4", "5", "6", "7"], correctAnswer: 0)
        let mathQuestion2 = Question(question: "What is 2 + 7?", answers: ["2", "55", "9", "7"], correctAnswer: 2)
        let mathQuestion3 = Question(question: "What is 2 x 7?", answers: ["2", "14", "7", "9"], correctAnswer: 1)
        
        let scienceQuestion1 = Question(question: "How many mitochondria are in a cell?", answers: ["1", "2", "12", "Depends on the complexity of the cell"], correctAnswer: 3)
        
        let marvelQuestion1 = Question(question: "The Fantastic Four have headquarters in what building?", answers: ["Stark Tower", "Fantastic Headquarters", "Baxter Building", "Xaiver Institute"], correctAnswer: 2)
        let marvelQuestion2 = Question(question: "Which super hero is green?", answers: ["Spiderman", "Superwoman", "Superman", "Hulk"], correctAnswer: 3)
        
        let mathCategory = Category(categoryTitle: "Mathematics", categoryDescription: "Test your knowledge at Mathematics!", questions:[mathQuestion1, mathQuestion2, mathQuestion3])
        let scienceCategory = Category(categoryTitle: "Science", categoryDescription: "Test your knowledge at Science!", questions: [scienceQuestion1])
        let marvelCategory = Category(categoryTitle: "Marvel Super Heroes", categoryDescription: "Test your knowledge at Marvel Super Heroes!", questions: [marvelQuestion1, marvelQuestion2])
        
        quizCategories = [mathCategory, scienceCategory, marvelCategory]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

