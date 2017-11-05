//
//  ResultsViewController.swift
//  Personality Quiz
//
//  Created by Joseph Barbati on 11/4/17.
//  Copyright © 2017 Joseph Barbati. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController
{
    @IBOutlet weak var resultsAnswer: UILabel!
    @IBOutlet weak var resultsDefinition: UILabel!
    
    var responses: [Answer]!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.hidesBackButton = true
        self.calculatePersonalityResult()
    }
    
    func calculatePersonalityResult()
    {
        var frequencyOfAnswers: [Animal : Int] = [
            .dog : 0,
            .cat : 0,
            .bunny : 0,
            .turtle : 0
        ]
        
        let responsesType = responses.map {$0.type}
        
        for type in responsesType
        {
            frequencyOfAnswers[type] = (frequencyOfAnswers[type] ?? 0) + 1
        }
        
        let sortedFrequency = frequencyOfAnswers.sorted(by: { (pair1, pair2) -> Bool in
            return pair1.value > pair2.value
        })
        
        let mostCommonAnswer = sortedFrequency.first!.key
        
        self.updateLabels(withResult: mostCommonAnswer)
    }
    
    func updateLabels(withResult result: Animal)
    {
        self.resultsAnswer.text = "You are a \(result.rawValue)"
        self.resultsDefinition.text = result.definition
    }

    override func didReceiveMemoryWarning()
    {
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
