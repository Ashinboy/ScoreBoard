//
//  ViewController.swift
//  ScoreBoard
//
//  Created by Ashin Wang on 2022/1/6.
//

import UIKit

class ViewController: UIViewController {

    // team left
    @IBOutlet weak var leftScore: UILabel!
    @IBOutlet weak var leftName: UILabel!
    
    // team right
 
    @IBOutlet weak var rightScore: UILabel!
    @IBOutlet weak var rightName: UILabel!
    
    var teamLScore:Int = 0
    var teamRScore:Int = 0
    
    //gameNumber
    @IBOutlet weak var leftGameNumber: UILabel!
    @IBOutlet weak var rightGameNumber: UILabel!
    
    var leftGame:Int = 0
    var rightGame:Int = 0
    
//    var gameCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func teamLGesture(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left{
        teamLScore += 1
            if teamLScore == 11{
                leftGame += 1
                leftGameNumber.text = "\(leftGame)"
            }else if teamLScore == 0{
                leftName.text = "TEAM1"
                rightName.text = "TEAM2"
                teamRScore = 0
                rightScore.text = "0\(teamRScore)"
            }
            scoring(game: leftGameNumber, count: leftGame,team: leftScore,score: teamLScore, direction: .left, winner: leftName.text)
           

        }else if sender.direction == .right{
            teamLScore -= 1
            if teamLScore < 0 {
                teamLScore = 0
                scoring(game: leftGameNumber, count: leftGame,team: leftScore, score: teamLScore, direction: .right, winner: leftName.text)
               
            }else{
                scoring(game: leftGameNumber, count: leftGame,team: leftScore, score: teamLScore, direction: .left, winner: leftName.text)
            }
    }
       
}
    
    @IBAction func teamRGesture(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left{
        teamRScore += 1
            if teamRScore == 11{
                rightGame += 1
                rightGameNumber.text = "\(rightGame)"
               
                
            }else if teamRScore == 0{
                leftName.text = "TEAM1"
                rightName.text = "TEAM2"
                teamLScore = 0
                leftScore.text = "0\(teamLScore)"
            }
            scoring(game:rightGameNumber, count: rightGame,team: rightScore, score: teamRScore, direction: .left, winner: rightName.text)
            
        }else if sender.direction == .right{
            teamRScore -= 1
            if teamRScore < 0 {
                teamRScore = 0
                scoring(game:rightGameNumber,count: rightGame,team: rightScore , score: teamRScore, direction: .right, winner: rightName.text)
            }else{
                scoring(game:rightGameNumber, count: rightGame,team: rightScore ,score: teamRScore, direction: .left, winner: rightName.text)
            }
    }
    }
    
    
    
    
    @IBAction func changeSideBtn(_ sender: UIButton) {
//        let leftNum = rightGameNumber.text
//        let rightNum = leftGameNumber.text
        if teamLScore < 10 , teamRScore < 10{
            leftScore.text = "0\(teamRScore)"
            rightScore.text = "0\(teamLScore)"
        }
        
        leftGameNumber.text = "\(rightGame)"
        rightGameNumber.text = "\(leftGame)"
        
        teamLScore = teamRScore
        leftGame = rightGame
    }
    
    @IBAction func resetBtn(_ sender: UIButton) {
        resetGame(winner: nil)
        leftGame = 0
        rightGame = 0
        teamLScore = 0
        teamRScore = 0
    }
    
    
    
    // 寫出得分隊伍，目前得分，方向，是哪一隊贏球，最後判斷比賽是否結束
    func
    scoring (game: UILabel,count: Int,team:UILabel ,score:Int,direction:UISwipeGestureRecognizer.Direction,winner:String?){
        if direction == .left{
            if score == 11{
                resetGame(winner: winner)
                team.text = "\(score)"
            }else{
                if score < 10{
                    team.text = "0\(score)"
                }else{
                    team.text = "\(score)"
                }
            }
        }else{
            if score == 0{
                team.text = "00"
            }else{
                if score < 10{
                    team.text = "0\(score)"
                }else{
                    team.text = "\(score)"
                }
            }
        }
    }
    
    //重設比賽，將各隊分數歸零，並判斷誰是獲勝者給予對應的數值
    func
    resetGame (winner:String?){
        if teamLScore == 11{
            teamLScore -= 12
           
        }else if  teamRScore == 11{
           teamRScore -= 12
            
        }
        if winner == leftName.text{
            leftName.text = "WINNER"
            rightName.text = ""
    
        }else if winner == rightName.text{
            rightName.text = "WINNER"
            leftName.text = ""
        }else{
            leftName.text = "TEAM1"
            rightName.text = "TEAM2"
            leftScore.text = "00"
            rightScore.text = "00"
            leftGameNumber.text = "0"
            rightGameNumber.text = "0"
        }
    }
    
    
    
    
    
}

