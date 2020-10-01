//
//  ViewController.swift
//  Rover
//
//  Created by Smartral M1 on 9.07.2020.
//  Copyright © 2020 Training. All rights reserved.
//

import UIKit
class Canvas : UIView {
    
    var drawingPath = [CGPoint]()
    var context : CGContext?
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        for (i,p) in drawingPath.enumerated() {
            if i == 0 {
//                context.move(to: p)
                context.addRect(CGRect.init(x: p.x, y: p.y, width: 1, height: 1))
                
            }
            else {
//                context.addLine(to: p)
                context.addRect(CGRect.init(x: p.x, y: p.y, width: 1, height: 1))
            }
        }
        
        context.strokePath()

        
    }
    
    func drawPlot(points :[(Int,Int)]) {
        
        
        self.drawingPath = []
        for point in points {
            
                let point = CGPoint.init(x: CGFloat.init(point.0), y: CGFloat.init(point.1))
            self.drawingPath.append(point)
            }
         
        setNeedsDisplay()
        
        
    }
}
class RoverProgramViewController: UIViewController {
    
    let canvas = Canvas()
   
    @IBOutlet weak var txtvwProgramInput: UITextView!
    
    @IBOutlet weak var vwCanvas: UIView!
    
    var program : PointingProgram?
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        self.program = PointingProgram()
        
        
        canvas.frame = self.vwCanvas.bounds
               canvas.backgroundColor = .green
        self.vwCanvas.addSubview(canvas)
       
//        
//        view.addSubview(canvas)
//        canvas.frame = view.frame
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func initalizeRoverPressed(_ sender: Any) {
        
        let program = PointingProgram()
//        program.startNewRover(withStartingCoordinates: (self.vwCanvas.bounds.midX,self.vwCanvas.bounds.midY))
        program.startNewRover(withStartingCoordinates:(0.0,0.0))
        self.program = program
        
        
    }
    
    @IBAction func plotRoutePressed(_ sender: Any) {
        
        
        guard let program = self.program , let rover = program.rover else {
            return
        }
        
            rover.insertMissionProgramming(missionString: program.missionText)
            
        if let canvas =  self.vwCanvas.subviews[0] as? Canvas {
            canvas.drawPlot(points: rover.pointedLocations)
        }
//        self.canvas.frame = CGRect.init(x: 0, y: 0, width: CGFloat(rover.maxY), height:CGFloat(rover.maxX-(rover.minX)) )
//        self.canvas.contentMode = .scaleAspectFill
       
//        print(rover.pointedLocations)
        
    }
    
    
}



extension UIView {
    var screenShot: UIImage?  {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale)
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return screenshot
        }
        return nil
    }
}
