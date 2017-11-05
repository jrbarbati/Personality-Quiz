//
//  QuizViewController.swift
//  Personality Quiz
//
//  Created by Joseph Barbati on 11/4/17.
//  Copyright © 2017 Joseph Barbati. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController
{
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var single: UIStackView!
    @IBOutlet weak var singleFirstChoice: UIButton!
    @IBOutlet weak var singleSecondChoice: UIButton!
    @IBOutlet weak var singleThirdChoice: UIButton!
    @IBOutlet weak var singleFourthChoice: UIButton!
    
    @IBOutlet weak var multiple: UIStackView!
    @IBOutlet weak var multipleFirstLabel: UILabel!
    @IBOutlet weak var multipleFirstSwitch: UISwitch!
    @IBOutlet weak var multipleSecondLabel: UILabel!
    @IBOutlet weak var multipleSecondSwitch: UISwitch!
    @IBOutlet weak var multipleThirdLabel: UILabel!
    @IBOutlet weak var multipleThirdSwitch: UISwitch!
    @IBOutlet weak var multipleFourthLabel: UILabel!
    @IBOutlet weak var multipleFourthSwitch: UISwitch!
    @IBOutlet weak var multipleSubmitButton: UIButton!
    
    @IBOutlet weak var ranged: UIStackView!
    @IBOutlet weak var rangedSlider: UISlider!
    @IBOutlet weak var rangedLowerLabel: UILabel!
    @IBOutlet weak var rangedHigherLabel: UILabel!
    @IBOutlet weak var rangedSubmitButton: UIButton!
    
    @IBOutlet weak var progress: UIProgressView!
    
    let questions: [Question] = [
        Question(text: "Which food do you like most?",
                 type: .single,
                 answers: [
                    Answer(text: "Steak", type: .dog),
                    Answer(text: "Fish", type: .cat),
                    Answer(text: "Carrots", type: .bunny),
                    Answer(text: "Corn", type: .turtle)
            ]),
        Question(text: "Which activities do you enjoy?",
                 type: .multiple,
                 answers: [
                    Answer(text: "Swimming", type: .turtle),
                    Answer(text: "Sleeping", type: .cat),
                    Answer(text: "Cuddling", type: .bunny),
                    Answer(text: "Eating", type: .dog)
            ]),
        Question(text: "How much do you enjoy car rides?",
                 type: .ranged,
                 answers: [
                    Answer(text: "I dislike them", type: .cat),
                    Answer(text: "I get a little nervous", type: .bunny),
                    Answer(text: "I barely notice them", type: .turtle),
                    Answer(text: "I love them", type: .dog)
            ])
    ]
    
    var questionIndex: Int = 0
    
    var answersChosen: [Answer] = [Answer]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.showNextQuestion()
    }
    
    @IBAction func singleButtonPressed(_ sender: UIButton)
    {
        let currAnswers = self.getCurrAnswers()
        
        switch sender
        {
        case self.singleFirstChoice:
            self.answersChosen.append(currAnswers[0])
        case self.singleSecondChoice:
            self.answersChosen.append(currAnswers[1])
        case self.singleThirdChoice:
            self.answersChosen.append(currAnswers[2])
        case self.singleFourthChoice:
            self.answersChosen.append(currAnswers[3])
        default:
            break
        }
        
        self.nextQuestion()
    }
    
    @IBAction func multipleSubmitPressed(_ sender: UIButton)
    {
        let currAnswers = self.getCurrAnswers()
        
        if self.multipleFirstSwitch.isOn
        {
            self.answersChosen.append(currAnswers[0])
        }
        
        if self.multipleSecondSwitch.isOn
        {
            self.answersChosen.append(currAnswers[1])
        }
        
        if self.multipleThirdSwitch.isOn
        {
            self.answersChosen.append(currAnswers[2])
        }
        
        if self.multipleFourthSwitch.isOn
        {
            self.answersChosen.append(currAnswers[3])
        }
        
        self.nextQuestion()
    }
    
    @IBAction func rangedSubmitPressed(_ sender: UIButton)
    {
        let currAnswers = self.getCurrAnswers()
        
        let index = Int(round(self.rangedSlider.value * Float(currAnswers.count - 1)))
        
        self.answersChosen.append(currAnswers[index])
        
        self.nextQuestion()
    }
    
    func nextQuestion()
    {
        self.questionIndex += 1
        
        guard self.questionIndex < self.questions.count else
        {
            performSegue(withIdentifier: "toResults", sender: nil)
            return
        }
        
        self.showNextQuestion()
    }
    
    func showNextQuestion()
    {
        single.isHidden = true
        multiple.isHidden = true
        ranged.isHidden = true
        
        navigationItem.title = "Question \(self.questionIndex + 1)"
        
        let currQuestion = self.questions[self.questionIndex]
        let currAnswers = currQuestion.answers
        let totalProgress = Float(questionIndex) / Float(self.questions.count)
        
        self.questionLabel.text = currQuestion.text
        self.progress.setProgress(totalProgress, animated: true)
        
        switch currQuestion.type
        {
        case .single:
            self.showSingleQuestion(withAnswers: currAnswers)
        case .multiple:
            self.showMultipleQuestion(withAnswers: currAnswers)
        case .ranged:
            self.showRangedQuestion(withAnswers: currAnswers)
        }
    }
    
    func showSingleQuestion(withAnswers answers: [Answer])
    {
        self.single.isHidden = false
        self.singleFirstChoice.setTitle(answers[0].text, for: .normal)
        self.singleSecondChoice.setTitle(answers[1].text, for: .normal)
        self.singleThirdChoice.setTitle(answers[2].text, for: .normal)
        self.singleFourthChoice.setTitle(answers[3].text, for: .normal)
    }
    
    func showMultipleQuestion(withAnswers answers: [Answer])
    {
        self.multiple.isHidden = false
        self.resetSwitches()
        self.multipleFirstLabel.text = answers[0].text
        self.multipleSecondLabel.text = answers[1].text
        self.multipleThirdLabel.text = answers[2].text
        self.multipleFourthLabel.text = answers[3].text
    }
    
    func resetSwitches()
    {
        self.multipleFirstSwitch.isOn = false
        self.multipleSecondSwitch.isOn = false
        self.multipleThirdSwitch.isOn = false
        self.multipleFourthSwitch.isOn = false
    }
    
    func showRangedQuestion(withAnswers answers: [Answer])
    {
        self.ranged.isHidden = false
        self.resetSlider()
        self.rangedLowerLabel.text = answers.first?.text
        self.rangedHigherLabel.text = answers.last?.text
    }
    
    func resetSlider()
    {
        self.rangedSlider.setValue(0.5, animated: false)
    }
    
    func getCurrAnswers() -> [Answer]
    {
         return self.questions[self.questionIndex].answers
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard segue.identifier == "toResults" else
        {
            print("incorrect segue...returning...")
            return
        }
        
        let resultsViewController = segue.destination as! ResultsViewController
        resultsViewController.responses = answersChosen
    }
}
