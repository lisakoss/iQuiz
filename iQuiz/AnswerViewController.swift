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
    var catQuestion:Question?
    var questionNumber:Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var userAnswer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        questionLabel.text = category?.questions[questionNumber].question
        // Do any additional setup after loading the view.
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
