//
//  Question.swift
//  iQuiz
//
//  Created by Lisa Koss on 2/19/18.
//  Copyright © 2018 Lisa Koss. All rights reserved.
//

import UIKit

class Question: NSObject {
    var question:String = ""
    var answers:[String] = []
    var correctAnswer:Int = 0
    
    init(question:String, answers:[String], correctAnswer:Int) {
        self.question = question
        self.answers = answers
        self.correctAnswer = correctAnswer
    }

}
