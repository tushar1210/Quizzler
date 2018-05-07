//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    var progressNumber = 1
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstQuestion = allQuestions.list[0]
        questionLabel.text = firstQuestion.questionText
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        
        if sender.tag == 1{
            
            pickedAnswer = true
        }
        else if sender.tag == 2{
            
            pickedAnswer = false
        }
    checkAnswer()
        
        questionNumber+=1
        nextQuestion()
    }
 
    func updateUI() {
        progressLabel.text = "\(progressNumber)/13"
        scoreLabel.text = "Score: \(score)"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(progressNumber)
    }
    

    func nextQuestion() {
        if questionNumber<=12{
            questionLabel.text = allQuestions.list[questionNumber].questionText
            progressNumber+=1
            updateUI()

        }
        else{
            print("End of Quiz")
            questionNumber = 0
            startOver()
            progressNumber=0
            score = 0
        
        }

    }
    
    
    func checkAnswer() {
        
        let correctAnswer = allQuestions.list[questionNumber].answer
        if correctAnswer ==  pickedAnswer{
            ProgressHUD.showSuccess("Correct Answer")
            
            //print("Correct !")
            score += 10
            updateUI()
        }
        else{
           ProgressHUD.showError("Wrong Answer")
            // print("Wrong !")
        }
    }
    
    
    func startOver() {
        
let alert = UIAlertController(title: "Quiz Completed !", message: "You have completed all the questions !", preferredStyle: .alert)
        let restartAction=UIAlertAction(title: "RESTART ", style: .default) { (UIAlertAction) in
            self.againStartOver()
            
        }
       alert.addAction(restartAction)
        present(alert,animated: true,completion: nil)
    }
    
    func againStartOver(){
        
        questionNumber = 0
        nextQuestion()
        
    }
    
}
