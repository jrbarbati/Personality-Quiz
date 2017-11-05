//
//  ViewController.swift
//  Personality Quiz
//
//  Created by Joseph Barbati on 11/4/17.
//  Copyright © 2017 Joseph Barbati. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var beginBtn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.beginBtn.layer.cornerRadius = 7.0
    }
    
    @IBAction func beginQuiz(_ sender: UIButton)
    {
        performSegue(withIdentifier: "toQuiz", sender: sender)
    }
    
    @IBAction func unwindToLandingPage(segue: UIStoryboardSegue)
    {
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
