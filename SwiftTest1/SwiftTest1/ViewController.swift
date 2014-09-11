//
//  ViewController.swift
//  SwiftTest1
//
//  Created by Utveckla1 on 04/09/14.
//  Copyright (c) 2014 Utveckla1. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var blueView: UIView!
    var greenBlueVertical, greenBlueHorizontal, blueGreenVertical, blueGreenHorizontal: NSArray!
    var outlets: NSDictionary!
    var constraintsSets: [NSString: NSArray]!
    var currentConstraintSet: NSString!
    var allConstraints: [NSString]!
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Basic setup of required sets of Constraints
        outlets = ["greenView": greenView, "blueView": blueView]
        greenBlueVertical = NSLayoutConstraint.constraintsWithVisualFormat("H:|[greenView]-20-[blueView(==greenView)]|", options: nil, metrics: nil, views: outlets)
        greenBlueVertical = greenBlueVertical + NSLayoutConstraint.constraintsWithVisualFormat("V:|[greenView]|", options: nil, metrics: nil, views: outlets)
        greenBlueVertical = greenBlueVertical + NSLayoutConstraint.constraintsWithVisualFormat("V:|[blueView]|", options: nil, metrics: nil, views: outlets)
        
        greenBlueHorizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|[greenView]|", options: nil, metrics: nil, views: outlets)
        greenBlueHorizontal = greenBlueHorizontal + NSLayoutConstraint.constraintsWithVisualFormat("H:|[blueView]|", options: nil, metrics: nil, views: outlets)
        greenBlueHorizontal = greenBlueHorizontal + NSLayoutConstraint.constraintsWithVisualFormat("V:|[greenView]-[blueView(==greenView)]|", options: nil, metrics: nil, views: outlets)

        
        blueGreenVertical = NSLayoutConstraint.constraintsWithVisualFormat("H:|[blueView]-20-[greenView(==blueView)]|", options: nil, metrics: nil, views: outlets)
        blueGreenVertical = blueGreenVertical + NSLayoutConstraint.constraintsWithVisualFormat("V:|[blueView]|", options: nil, metrics: nil, views: outlets)
        blueGreenVertical = blueGreenVertical + NSLayoutConstraint.constraintsWithVisualFormat("V:|[greenView]|", options: nil, metrics: nil, views: outlets)

        blueGreenHorizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|[blueView]|", options: nil, metrics: nil, views: outlets)
        blueGreenHorizontal = blueGreenHorizontal + NSLayoutConstraint.constraintsWithVisualFormat("H:|[greenView]|", options: nil, metrics: nil, views: outlets)
        blueGreenHorizontal = blueGreenHorizontal + NSLayoutConstraint.constraintsWithVisualFormat("V:|[blueView]-[greenView(==blueView)]|", options: nil, metrics: nil, views: outlets)
        
        allConstraints = ["gbV", "gbH", "bgV", "bgH"]
        constraintsSets = [allConstraints[0]: greenBlueVertical, allConstraints[1]: greenBlueHorizontal, allConstraints[2]: blueGreenVertical, allConstraints[3]: blueGreenHorizontal]
        currentConstraintSet = constraintsSets.keys.first
        
        self.view.addConstraints(constraintsSets[currentConstraintSet]!);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBAction func toggleViewsConstraints(sender: AnyObject) {
        var nextSetIndex: Int
        for index in 0...allConstraints.count-1 {
            if(allConstraints[index] == currentConstraintSet) {
                nextSetIndex = (index + 1) % allConstraints.count
                currentConstraintSet = allConstraints[nextSetIndex]
                break
            }
        }
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            for constraintSet in self.constraintsSets.keys.array {
                if (!constraintSet.isEqualToString(self.currentConstraintSet)) {
                    self.view.removeConstraints(self.constraintsSets[constraintSet]!)
                } else {
                    self.view.addConstraints(self.constraintsSets[constraintSet]!)
                }
                self.view.layoutIfNeeded()
            }
        })
    }
}

