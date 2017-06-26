//
//  ViewController.swift
//  grid
//
//  Created by Rohan Lokesh Sharma on 26/06/17.
//  Copyright © 2017 webarch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let numberPerRow = 15;

    var locs = [String:UIView]()
    override func viewDidLoad() {
        doSomething()
        super.viewDidLoad()
    }
    
    
    
    func doSomething(){
        
        let width:CGFloat = self.view.frame.width / CGFloat(numberPerRow);
        
        
        for i in 0...Int(view.frame.width / width){
            for j in 0...Int(view.frame.height/width){
                let someView = UIView(frame: CGRect(x: CGFloat(i) * width, y:  CGFloat(j)*width, width: width, height: width))
                someView.backgroundColor = .random()
                someView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
                someView.layer.borderColor = UIColor.black.cgColor
                someView.layer.borderWidth = 0.5
                
                locs["\(i),\(j)"] = someView
              //  print(Int(CGFloat(i)*width),Int(CGFloat(j)*width))
                view.addSubview(someView)
            }
        }
    }

    
    func getRandom() -> UIColor {
        let red = drand48()
        let green = drand48()
        let blue = drand48()
        
        return UIColor(colorLiteralRed: Float(red), green: Float(green), blue: Float(blue), alpha: 1.0)
    }
    
    
    var selectedCell:UIView?
    
    func handlePan(recog:UIPanGestureRecognizer){
       let width = view.frame.width / CGFloat(numberPerRow)
   
        let column = Int(recog.location(in: view).x / width)
        let row = Int(recog.location(in: view).y / width)
        let key = "\(column),\(row)";
     //   let cell = locs[key];
        
        guard let cell = locs[key] else { return }
        
        if(selectedCell != cell){
            
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                
                self.selectedCell?.transform = CGAffineTransform.identity
            
            
            }, completion: nil)
        }
        
        
        
        view.bringSubview(toFront: cell)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
        
            cell.transform = CGAffineTransform(scaleX: 5, y: 5);
            
        
        }, completion: nil)
        
        selectedCell = cell;
        
        if(recog.state == .ended){
            selectedCell?.transform = CGAffineTransform.identity
            cell.transform = CGAffineTransform.identity
        }
    }

}


extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}



