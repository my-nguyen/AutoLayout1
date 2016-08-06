//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by My Nguyen on 8/5/16.
//  Copyright © 2016 My Nguyen. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    var countries = [String]()
    var score = 0
    var correctAnswer = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // store country names
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        /*
        countries.append("estonia")
        countries.append("france")
        countries.append("germany")
        countries.append("ireland")
        countries.append("italy")
        countries.append("monaco")
        countries.append("nigeria")
        countries.append("poland")
        countries.append("russia")
        countries.append("spain")
        countries.append("uk")
        countries.append("us")
        */

        // set (black) borders to all 3 flags to avoid confusion between a white flag stripe and the white background
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1

        // set light gray borders to all 3 flags; note the conversion from UIColor to CGColor to fit in CALayer.borderColor
        button1.layer.borderColor = UIColor.lightGrayColor().CGColor
        button2.layer.borderColor = UIColor.lightGrayColor().CGColor
        button3.layer.borderColor = UIColor.lightGrayColor().CGColor
        // another way to set UIColor: UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0)

        askQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func askQuestion(action: UIAlertAction! = nil) {
        // randomly shuffle the order of the 12 countries
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(countries) as! [String]

        // pick the first 3 countries for the 3 buttons
        button1.setImage(UIImage(named: countries[0]), forState: .Normal)
        button2.setImage(UIImage(named: countries[1]), forState: .Normal)
        button3.setImage(UIImage(named: countries[2]), forState: .Normal)

        // generate a random number between 0 and 2, inclusive
        correctAnswer = GKRandomSource.sharedRandom().nextIntWithUpperBound(3)

        // write the answer in uppercase to the navigation bar
        title = countries[correctAnswer].uppercaseString
    }

    @IBAction func buttonTapped(sender: UIButton) {
        var title: String

        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }

        /// pop up a message similar to Android toast
        let message = "Your score is \(score)."
        // create a UIAlertController (dialog box)
        let controller = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        // add a "Continue" button, which when clicked will call askQuestion()
        let action = UIAlertAction(title: "Continue", style: .Default, handler: askQuestion)
        controller.addAction(action)
        // (1) view controller to present; (2) whether to animation the presentation; and (3) a closure
        // (callback) to be executed when the presentation animation has finished
        presentViewController(controller, animated: true, completion: nil)
    }
}

