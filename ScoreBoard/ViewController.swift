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
            scoring(team: leftScore,score: teamLScore, direction: .left, winner: leftName.text)
           

        }else if sender.direction == .right{
            teamLScore -= 1
            if teamLScore < 0 {
                teamLScore = 0
                scoring(team: leftScore, score: teamLScore, direction: .right, winner: leftName.text)
               
            }else{
                scoring(team: leftScore, score: teamLScore, direction: .left, winner: leftName.text)
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
            scoring(team: rightScore, score: teamRScore, direction: .left, winner: rightName.text)
            
        }else if sender.direction == .right{
            teamRScore -= 1
            if teamRScore < 0 {
                teamRScore = 0
                scoring(team: rightScore , score: teamRScore, direction: .right, winner: rightName.text)
            }else{
                scoring(team: rightScore ,score: teamRScore, direction: .left, winner: rightName.text)
            }
    }
    }
    
    
    
    
    @IBAction func changeSideBtn(_ sender: UIButton) {
        if teamLScore < 10 , teamRScore < 10{
            leftScore.text = "0\(teamRScore)"
            rightScore.text = "0\(teamLScore)"
        }
       
        
        changSign()
        
        
    }
    
    //重設比賽，將各隊分數歸零
    @IBAction func resetBtn(_ sender: UIButton) {
        endOfGame(winner: nil)
        leftGame = 0
        rightGame = 0
        teamLScore = 0
        teamRScore = 0
    }
    
    
    
    // 判斷得分結果，設定參數，得分隊伍，目前分數，滑動方向，是哪一隊贏球，最後判斷比賽是否結束
    func
    scoring (team:UILabel ,score:Int,direction:UISwipeGestureRecognizer.Direction,winner:String?){
        if direction == .left{
            if score == 11{
                endOfGame(winner: winner)
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
    
    //判斷誰是獲勝者給予對應的數值
    func
    endOfGame (winner:String?){
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
    
    func changSign() {
        
        let changeGLNum = leftGame
        let changeGRNum = rightGame
        
        let changeLNum = teamLScore
        let changeRNum = teamRScore
        
        let changeLGame = leftGameNumber.text
        let changeRGame = rightGameNumber.text
        
        let changeLScore = leftScore.text
        let changeRScore = rightScore.text
        
        let changeLName = leftName.text
        let changeRName = rightName.text
        
        leftGameNumber.text = changeRGame
        rightGameNumber.text = changeLGame
        
        leftScore.text = changeRScore
        rightScore.text = changeLScore
        
        leftName.text = changeRName
        rightName.text = changeLName
        
        leftGame = changeGRNum
        rightGame = changeGLNum
        
        teamLScore = changeRNum
        teamRScore = changeLNum
        
    }
    
    
    
}

