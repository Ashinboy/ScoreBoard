//
//  ViewController.swift
//  ScoreBoard
//
//  Created by Ashin Wang on 2022/1/6.
//

import UIKit

class ViewController: UIViewController {
    
    
    //winnerLabel
    @IBOutlet var winnerLabel: [UILabel]!
    
    @IBOutlet weak var leftStrokeBtn: UIButton!
    @IBOutlet weak var rightStrokeBtn: UIButton!
    
    //serve發球
    @IBOutlet var serverSwitch: UIButton!
    @IBOutlet var showServe: [UIView]!
    var index = Int.random(in: 0...1)
    
    // team left
    @IBOutlet weak var leftScore: UILabel!
    @IBOutlet weak var leftName: UILabel!
    
    // team right
    
    @IBOutlet weak var rightScore: UILabel!
    @IBOutlet weak var rightName: UILabel!
    
    
    //gameNumber
    @IBOutlet weak var leftGameNumber: UILabel!
    @IBOutlet weak var rightGameNumber: UILabel!
    
    var leftGame:Int = 0
    var rightGame:Int = 0
//    var isGameStarted: Bool = false
    
    var score = Score(leftScoreA: 0, rightScoreB: 0)
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        .landscape
    }
    
    enum Team {
        case left
        case right
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded() ///update layout UI
        // Do any additional setup after loading the view.
        leftName.text = "TEAM 1"
        rightName.text = "TEAM 2"
        
        showServe[index].isHidden = true
        winnerLabel[0].alpha = 0
        winnerLabel[1].alpha = 0
        
        //button stroke
        
        //L
        leftStrokeBtn.backgroundColor = .clear
        leftStrokeBtn.layer.cornerRadius = 5
        leftStrokeBtn.layer.borderWidth = 4
        leftStrokeBtn.layer.borderColor = UIColor.white.cgColor
        leftStrokeBtn.alpha = 0.3
        
        //R
        rightStrokeBtn.backgroundColor = .clear
        rightStrokeBtn.layer.cornerRadius = 5
        rightStrokeBtn.layer.borderWidth = 4
        rightStrokeBtn.layer.borderColor = UIColor.white.cgColor
        rightStrokeBtn.alpha = 0.3
    }
    
    
    @IBAction func teamLGesture(_ sender: UISwipeGestureRecognizer) {
        handleSwipeGesture(for: .left, gesture: sender)
    }
    
    @IBAction func teamRGesture(_ sender: UISwipeGestureRecognizer) {
        handleSwipeGesture(for: .right, gesture: sender)
    }
    
    
    @IBAction func changeSideBtn(_ sender: UIButton) {
        changSide()
    }
    
    //重設比賽，將各隊分數歸零
    @IBAction func resetBtn(_ sender: UIButton) {
        endOfGame(winner: nil)
        viewChange(scoreChanged: false)
        leftGame = 0
        rightGame = 0
        leftGameNumber.text = "0"
        rightGameNumber.text = "0"
        leftName.text = "TEAM 1"
        rightName.text = "TEAM 2"
        winnerLabel[0].isHidden = true
        winnerLabel[1].isHidden = true
        newGame()
    }
    
    
    private func handleSwipeGesture(for team: Team, gesture: UISwipeGestureRecognizer) {
        
        
        let isLeftTeam = team == .left
        
        /// update score variable
        var score = isLeftTeam ? self.score.leftScoreA : self.score.rightScoreB
        let scoreLabel = isLeftTeam ? self.leftScore : self.rightScore
        
        switch gesture.direction {
        case .left:
            score += 1
        case .right:
            score -= 1
            score = max(score,0) ///避免負分
        default:
            break
        }
        
        
        /// update score UI
        scoreLabel?.text = "\(score)"
        scoring(team: scoreLabel!, score: score, direction: gesture.direction, winner: nil)
        
        if isLeftTeam {
            self.score.leftScoreA = score
        }else{
            self.score.rightScoreB = score
        }
        
        let previousScore = score // record score before rightGenture
        
        if self.score.leftScoreA >= 10 && self.score.rightScoreB >= 10 {
            if abs(self.score.leftScoreA - self.score.rightScoreB) >= 2 {
                endOfGame(winner: isLeftTeam ? leftName.text : rightName.text )
            }else{
                deuce()
            }
        }else if score == 11 {
            endOfGame(winner: isLeftTeam ? leftName.text : rightName.text)
        }
        
        let scoreChanged = previousScore != score
        viewChange(scoreChanged: scoreChanged)
    }
    
    
    
    //新的一局
    func newGame(){
        score.leftScoreA = 0
        score.rightScoreB = 0
        leftScore.text = "00"
        rightScore.text = "00"
        
        if leftName.text == "TEAM 1"{
            leftName.text = "TEAM 1"
        }else if leftName.text == "TEAM 2"{
            leftName.text = "TEAM 2"
        }else if rightName.text == "TEAM 2"{
            rightName.text = "TEAM 2"
        }else if rightName.text == "TEAM 1"{
            rightName.text = "TEAM 1"
            
        }
    }
    
    //view change 輪替發球
    func viewChange(scoreChanged: Bool){
        
        
        let leftScoreA = score.leftScoreA
        let rightScoreB = score.rightScoreB
        
        
        print("as_checkScoreChangeed__:\(scoreChanged)")
        if !scoreChanged {
            return
        }
        
        
        if leftScoreA == 0 && rightScoreB == 0 || leftScoreA == 0 && rightScoreB != 0 || rightScoreB == 0 && leftScoreA != 0 {
            return
        }
        
        let totalScore = score.leftScoreA + score.rightScoreB
        
        if totalScore % 2 == 0 {
            showServe[0].isHidden = false
            showServe[1].isHidden = true
        }else{
            showServe[0].isHidden = true
            showServe[1].isHidden = false
        }
        
        
//        if showServe[0].isHidden == true{
//            let sum = score.leftScoreA + score.rightScoreB
//            if sum % 2 == 0{
//                showServe[1].isHidden = true
//                showServe[0].isHidden = false
//            }else{
//                showServe[1].isHidden = false
//                showServe[0].isHidden = true
//            }
//        }else if showServe[0].isHidden == false{
//            let sum = score.leftScoreA + score.rightScoreB
//            if sum % 2 == 0{
//                showServe[0].isHidden = true
//                showServe[1].isHidden = false
//            }else{
//                showServe[0].isHidden = false
//                showServe[1].isHidden = true
//            }
//        }
        
    }
    
    //deuce view deuce的輪替
    func deuceView(){
        if showServe[0].isHidden == false{
            let sum = score.leftScoreA - score.rightScoreB
            if sum  != 1 || sum == 0 || sum == 1{
                showServe[1].isHidden = false
                showServe[0].isHidden = true
            }
        }else{
            let sum = score.leftScoreA - score.rightScoreB
            if sum != 1 || sum == 0 || sum == 1{
                showServe[1].isHidden = true
                showServe[0].isHidden = false
            }
        }
    }
    
    
    // 判斷得分結果，設定參數，得分隊伍，目前分數，滑動方向，是哪一隊贏球，最後判斷比賽是否結束
    func scoring (team:UILabel ,score:Int,direction:UISwipeGestureRecognizer.Direction,winner:String?){
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
    func endOfGame (winner:String?){
        
        
        if winner == leftName.text{
            UIView.animate(withDuration: 0.3) {
                self.winnerLabel[0].alpha = 1
                self.winnerLabel[1].alpha = 0
                self.view.layoutIfNeeded()
            }
            leftGameNumber.text = "\(leftGame + 1)"
            AlertLeft()
            
        }else if winner == rightName.text{
            UIView.animate(withDuration: 0.3) {
                self.winnerLabel[1].alpha = 1
                self.winnerLabel[0].alpha = 0
                self.view.layoutIfNeeded()
            }
            rightGameNumber.text = "\(rightGame + 1)"
            AlertRight()
           
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    //deuce的方法
    func deuce(){
        let sum = score.leftScoreA - score.rightScoreB
        let sum2 = score.rightScoreB - score.leftScoreA
        if sum == 2 {
            winnerLabel[0].isHidden = false
            winnerLabel[1].isHidden = true
            leftGame += 1
            leftGameNumber.text = "\(leftGame)"
            //UIAlert
            if leftName.text == "TEAM 1"{
                AlertLeft()
            }else if leftName.text == "TEAM 2"{
                AlertRight()
            }
            
        }else if sum2 == 2{
            winnerLabel[1].isHidden = false
            winnerLabel[0].isHidden = true
            rightGame += 1
            rightGameNumber.text = "\(rightGame)"
            if rightName.text == "TEAM 1"{
                AlertLeft()
            }else if rightName.text == "TEAM 2"{
                AlertRight()
            }
        }
    }
    
    //UIAlert的方法
    func AlertLeft(){
        let controller = UIAlertController(title: "Amazing!", message: "Congratulations to team 1 for the win!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Done", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
        newGame()
    }
    
    func AlertRight(){
        let controller = UIAlertController(title: "Amazing!", message: "Congratulations to team 2 for the win!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Done", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
        newGame()
    }
    
    
    
    
    func changSide() {
        
        let changeGLNum = leftGame
        let changeGRNum = rightGame
        
        let changeLNum = score.leftScoreA
        let changeRNum = score.rightScoreB
        
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
        
        score.leftScoreA = changeRNum
        score.rightScoreB = changeLNum
        
        if showServe[0].isHidden == true{
            showServe[0].isHidden = false
            showServe[1].isHidden = true
        }else if showServe[1].isHidden == true{
            showServe[1].isHidden = false
            showServe[0].isHidden = true
        }
    }
}

