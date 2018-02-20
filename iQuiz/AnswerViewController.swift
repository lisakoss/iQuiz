//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Lisa Koss on 2/19/18.
//  Copyright © 2018 Lisa Koss. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    var category:Category?
    var questionNumber:Int = 0
    var answer:Int = 0
    var numberCorrect:Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var userAnswer: UILabel!
    
    
    @IBAction func nextScreen(_ sender: Any) {
        if(questionNumber == category?.questions.count) {
            let resultViewController = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
            resultViewController.category = self.category 
            resultViewController.numberCorrect = self.numberCorrect
            self.present(resultViewController, animated: true, completion: nil)
        } else {
            let questionViewController = self.storyboard?.instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController
            questionViewController.category = self.category
            questionViewController.questionNumber = self.questionNumber
            questionViewController.numberCorrect = self.numberCorrect
            self.present(questionViewController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let currQuestion = category?.questions[questionNumber]
        let correctAnswer = currQuestion?.answers[((currQuestion?.correctAnswer)! - 1)]
        let userInput = currQuestion?.answers[answer]
        
        questionLabel.text = currQuestion?.question
        correctLabel.text = "The correct answer was: " + correctAnswer!
        
        if (correctAnswer == userInput) {
            userAnswer.text = "Your answer of " + userInput! + " was correct!"
            userAnswer.backgroundColor = UIColor.green
            numberCorrect += 1
        } else {
            userAnswer.text = "Sorry " + userInput! + " is incorrect!"
            userAnswer.backgroundColor = UIColor.red
            userAnswer.textColor = UIColor.white
        }
        
        questionNumber += 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
