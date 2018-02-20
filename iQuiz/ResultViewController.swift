//
//  ResultViewController.swift
//  iQuiz
//
//  Created by Lisa Koss on 2/19/18.
//  Copyright © 2018 Lisa Koss. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var category:Category?
    var numberCorrect:Int = 0

    @IBOutlet weak var correctDescLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let percentageCorrect = Float(numberCorrect) / Float((category?.questions.count)!)
        print(percentageCorrect)
        if((percentageCorrect * 100) == 100) {
            correctDescLabel.text = "Perfect score!"
        } else if((percentageCorrect * 100) >= 75) {
            correctDescLabel.text = "Almost perfect!"
        } else if((percentageCorrect * 100) >= 50) {
           correctDescLabel.text = "You got at least half right!"
        } else {
            correctDescLabel.text = "Study harder next time!"
        }
        correctLabel.text = String(numberCorrect) + " of " + String((category?.questions.count)!) + " correct!"
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
