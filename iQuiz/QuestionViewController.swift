//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Lisa Koss on 2/18/18.
//  Copyright © 2018 Lisa Koss. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    var category:Category?
    var questionNumber:Int = 0
    var answer:Int = 0
    var numberCorrect:Int = 0
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    
    @IBAction func firstAnswer(_ sender: UIButton) {
        answer2.backgroundColor = UIColor.black
        answer3.backgroundColor = UIColor.black
        answer4.backgroundColor = UIColor.black
        sender.backgroundColor = UIColor.gray
        answer = 0
        submitButton.isEnabled = true
    }

    @IBAction func secondAnswer(_ sender: UIButton) {
        answer1.backgroundColor = UIColor.black
        answer3.backgroundColor = UIColor.black
        answer4.backgroundColor = UIColor.black
        sender.backgroundColor = UIColor.gray
        answer = 1
        submitButton.isEnabled = true
    }
    
    @IBAction func thirdAnswer(_ sender: UIButton) {
        answer1.backgroundColor = UIColor.black
        answer2.backgroundColor = UIColor.black
        answer4.backgroundColor = UIColor.black
        sender.backgroundColor = UIColor.gray
        answer = 2
        submitButton.isEnabled = true
    }
    
    @IBAction func fourthAnswer(_ sender: UIButton) {
        answer1.backgroundColor = UIColor.black
        answer2.backgroundColor = UIColor.black
        answer3.backgroundColor = UIColor.black
        sender.backgroundColor = UIColor.gray
        answer = 3
        submitButton.isEnabled = true
    }
    
    @IBAction func submit(_ sender: Any) {
        let answerViewController = self.storyboard?.instantiateViewController(withIdentifier: "AnswerViewController") as! AnswerViewController
        answerViewController.category = self.category
        answerViewController.questionNumber = self.questionNumber
        answerViewController.answer = self.answer
        answerViewController.numberCorrect = self.numberCorrect
        self.present(answerViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //catQuestion =
        questionLabel.text = category?.questions[questionNumber].question
        answer1.setTitle(category?.questions[questionNumber].answers[0], for: .normal)
        answer2.setTitle(category?.questions[questionNumber].answers[1], for: .normal)
        answer3.setTitle(category?.questions[questionNumber].answers[2], for: .normal)
        answer4.setTitle(category?.questions[questionNumber].answers[3], for: .normal)
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
