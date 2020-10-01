//
//  Rover.swift
//  Rover
//
//  Created by Smartral M1 on 9.07.2020.
//  Copyright © 2020 Training. All rights reserved.
//

import Foundation

enum RoverCommands : String {
    case Left = "L"
    case Move = "M"
    case Right = "R"
    case Point = "P"
    
   
}
enum Directions : String {
    
    case North = "N"
    case South = "S"
    case East = "E"
    case West = "W"
    
    func turnLeft() -> Directions{
        switch self {
            
        case .North:
            return .West
        case .South:
            return.East
        case .East:
            return .North
        case .West:
            return .South
        }
    }
    func turnRight() ->Directions{
        switch self {
            
        case .North:
            return .East
        case .South:
            return.West
        case .East:
            return .South
        case .West:
            return .North
        }
    }
}

class Rover : NSObject{
     var availableCommands : [String] = [RoverCommands.Left.rawValue,RoverCommands.Move.rawValue,RoverCommands.Right.rawValue,RoverCommands.Point.rawValue]
    var currentX : Int = 0
    var currentY : Int = 0
    var maxX : Int = 0
    var minX : Int = 0
    var maxY : Int = 0
    var minY : Int = 0
    var currentDirection : Directions = .North
    var pointedLocations : [(Int,Int)] = []
    
    
    
    func currentPosition() ->(Int,Int){
//        let positionString = "Current X: " + String(self.currentX) + "Current Y: " + String(self.currentY) + " Direction: " + self.currentDirection.rawValue
//        print(positionString)
        return (self.currentX,self.currentY)
    }
    
    
    func processCommand(command : RoverCommands) {
        
        switch command{
            
            
        case .Left:
            self.currentDirection = self.currentDirection.turnLeft()
            
        case .Move:
            switch self.currentDirection {
             // Below code is 90 degrees wrong because of ios coord system
//            case .North:
//                self.currentX+=1
//            case .South:
//                self.currentX-=1
//            case .East:
//                self.currentY+=1
//            case .West:
//                self.currentY-=1
                
                case .North:
                    self.currentY-=1
                case .South:
                    self.currentY+=1
                case .East:
                    self.currentX+=1
                case .West:
                    self.currentX-=1
            }
        case .Right:
            self.currentDirection =   self.currentDirection.turnRight()
        case .Point:
            if self.currentX < self.minX {
                self.minX = self.currentX
            }
            if self.currentX > self.maxX {
                self.maxX = self.currentX
            }
            if self.currentY < self.minY {
                           self.minY = self.currentY
                       }
                       if self.currentY > self.maxY {
                           self.maxY = self.currentY
                       }
            self.pointedLocations.append(self.currentPosition())
            
        }
    }
    func insertMissionProgramming(missionString : String){
           for command in missionString {
               if self.availableCommands.contains(String(command)) {
                   
                   self.processCommand(command: RoverCommands(rawValue: String(command))!)
               }
               else {
                   print("Command : \(command) is not a valid command. Execution will now end.")
                break
               }
           }
           
       }
    
    func paintLocation()->[Int:Int] {
        return [0:0]
    }
    
}
