//
//  ViewController.swift
//  ViewPager
//
//  Created by pradip gotamay on 2/21/17.
//  Copyright © 2017 Pradip Gotame. All rights reserved.
//

import UIKit

enum Layer : String{
    case REDLAYER = "redLayer";
}

enum ButtonTag : Int{
    case One   = 6;
    case Two   = 15;
    case Three = 24;
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var activeButton: UIButton!
    var flagForRightSwipe : Bool = false
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btn_one: UIButton!
    @IBAction func btn_one(_ sender: UIButton) {
        if activeButton.tag == ButtonTag.One.rawValue{
            
        }else if activeButton.tag ==  ButtonTag.Two.rawValue{
            flagForRightSwipe = true
            setActiveButton(button: self.btn_one)
        }else{
            flagForRightSwipe = true
            setActiveButton(button: self.btn_one)
        }
    }
    
    @IBOutlet weak var btn_two: UIButton!
    @IBAction func btn_two(_ sender: UIButton) {
        if activeButton.tag == ButtonTag.One.rawValue{
            flagForRightSwipe = false
            setActiveButton(button: self.btn_two)
        }else if activeButton.tag ==  ButtonTag.Two.rawValue{
            
        }else{
            flagForRightSwipe = true
            setActiveButton(button: self.btn_two)
        }
    }
    
    @IBOutlet weak var btn_three: UIButton!
    @IBAction func btn_three(_ sender: UIButton) {
        if activeButton.tag == ButtonTag.One.rawValue{
            flagForRightSwipe = false
            setActiveButton(button: self.btn_three)
        }else if activeButton.tag ==  ButtonTag.Two.rawValue{
            flagForRightSwipe = false
            setActiveButton(button: self.btn_three)
        }else{
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activeButton = btn_one;
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        addAndSwipeLayerBelowButton()
        gesture()
    }
    
    
    func gesture() -> Void {
        let gesture_swipeLeft = UISwipeGestureRecognizer.init(target: self, action: #selector(swipeTowardLeftGesture))
        gesture_swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.tableView.addGestureRecognizer(gesture_swipeLeft)
        
        let gesture_swipeRight = UISwipeGestureRecognizer.init(target: self, action: #selector(swipeTowardRightGesture))
        gesture_swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.tableView.addGestureRecognizer(gesture_swipeRight)
    }
    
    func swipeTowardRightGesture() -> Void {
        
        flagForRightSwipe = true
        
        if activeButton.tag == ButtonTag.Three.rawValue{
            setActiveButton(button: btn_two)
        }else if activeButton.tag == ButtonTag.Two.rawValue{
            setActiveButton(button: btn_one)
        }else{
            
        }
        
        self.tableView.reloadData()
    }
    
    func swipeTowardLeftGesture() -> Void {
        
        flagForRightSwipe = false
        
        if activeButton.tag == ButtonTag.One.rawValue{
            setActiveButton(button: btn_two)
        }else if activeButton.tag == ButtonTag.Two.rawValue{
            setActiveButton(button: btn_three)
        }else{
            
        }
        
    }
    
    func setActiveButton(button : UIButton) -> Void{
        activeButton = button
        
        addAndSwipeLayerBelowButton()
        
        self.tableView.reloadData()
        
        if flagForRightSwipe == false{
            AppManager.addSlideAnimationtoRight(layer: self.tableView.layer)
        }else{
            AppManager.addSlideAnimationtoLeft(layer: self.tableView.layer)
        }
        
    }
    
    /*this method will add red layer below button and also adds the sliding effects*/
    func addAndSwipeLayerBelowButton() -> Void{
        
        let currentButton : UIButton = activeButton
        
        let blueLayer : CALayer = CALayer()
        blueLayer.name  = Layer.REDLAYER.rawValue
        blueLayer.frame = CGRect(x: CGFloat(0), y: CGFloat(30), width: CGFloat(currentButton.frame.size.width), height: CGFloat(3))
        
        //you can change color of layer to any
        blueLayer.backgroundColor = UIColor.red.cgColor
        
        for subViews in self.view.subviews{
            if subViews.isKind(of: UIButton.self){
                let inactiveButton = subViews as! UIButton
                
                if inactiveButton.tag == currentButton.tag {
                    currentButton.layer.addSublayer(blueLayer)
                    
                    if flagForRightSwipe{
                        AppManager.addSlideAnimationtoRight(layer: blueLayer)
                    }else{
                        AppManager.addSlideAnimationtoLeft(layer: blueLayer)
                    }
                    
                    
                }else {
                    
                    
                    // This part will scan redLayer in other button beside active button and removes it
                    
                    let inactiveButtonLayers = inactiveButton.layer.sublayers
                    
                    if inactiveButtonLayers != nil{
                        for layer in inactiveButtonLayers!{
                            if layer.name == Layer.REDLAYER.rawValue{
                                layer.removeFromSuperlayer()
                            }
                            
                        }
                        
                    }else{
                        
                    }
                    
                }
                
            }else{}
        }
        
    }
    
    
    /*table view delegate*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 10}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if activeButton.tag == ButtonTag.One.rawValue{
            cell.textLabel?.text = "Tab 1 : Item = \(indexPath.row)"
        }else if activeButton.tag == ButtonTag.Two.rawValue{
            cell.textLabel?.text = "Tab 2 : Item = \(indexPath.row)"
        }else{
            cell.textLabel?.text = "Tab 3 : Item = \(indexPath.row)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

