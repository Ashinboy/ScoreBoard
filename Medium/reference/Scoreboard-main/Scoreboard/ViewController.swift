//
//  ViewController.swift
//  Scoreboard
//
//  Created by JianYu on 2021/7/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var player1LargePoint: UILabel!
    @IBOutlet weak var player2LargePoint: UILabel!
    @IBOutlet weak var player1SmallPoint: UILabel!
    @IBOutlet weak var player2SmallPoint: UILabel!
    @IBOutlet weak var player1Status: UILabel!
    @IBOutlet weak var player2Status: UILabel!
    @IBOutlet weak var rewindBtn: UILabel!
    @IBOutlet weak var changeSideBtn: UILabel!
    @IBOutlet weak var resetBtn: UILabel!
    
    let playerStatus = "Serve"
    var ballCount = 0
    var deuceType = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initfunc()
       
        let player1Tap = UITapGestureRecognizer(target: self, action: #selector(self.clickPlayer1LargePoint(_:)))
        player1SmallPoint.isUserInteractionEnabled = true
        player1SmallPoint.addGestureRecognizer(player1Tap)
        
        let player2Tap = UITapGestureRecognizer(target: self, action: #selector(self.clickPlayer2LargePoint(_:)))
        player2SmallPoint.isUserInteractionEnabled = true
        player2SmallPoint.addGestureRecognizer(player2Tap)
        
        let reset = UITapGestureRecognizer(target: self, action: #selector(self.clickReset(_:)))
        resetBtn.isUserInteractionEnabled = true
        resetBtn.addGestureRecognizer(reset)
        
        let changeSide = UITapGestureRecognizer(target: self, action: #selector(self.clickChangeSide(_:)))
        changeSideBtn.isUserInteractionEnabled = true
        changeSideBtn.addGestureRecognizer(changeSide)
        
        let rewind = UITapGestureRecognizer(target: self, action: #selector(self.clickRewind(_:)))
        rewindBtn.isUserInteractionEnabled = true
        rewindBtn.addGestureRecognizer(rewind)
    }
    
    func initfunc(){
        view.backgroundColor = UIColor(red: 0.276, green: 0.464, blue: 0.933, alpha: 1)
        player1Status.text = playerStatus
        player2Status.text = ""
        player1LargePoint.text = "0"
        player2LargePoint.text = "0"
        player1SmallPoint.text = "0"
        player2SmallPoint.text = "0"
        ballCount = 0
        deuceType = false
    }
    
    func addLargePoint(){
        if !deuceType {
            if player1SmallPoint.text == "11" {
                player1LargePoint.text = "\((Int(player1LargePoint.text!) ?? 0) + 1)"
                
                player1SmallPoint.text = "0"
                player2SmallPoint.text = "0"
                view.backgroundColor = UIColor(red: 0.276, green: 0.464, blue: 0.933, alpha: 1)
                player1Status.text = playerStatus
                player2Status.text = ""
                ballCount = 0
            }
            else if player2SmallPoint.text == "11"{
                player2LargePoint.text = "\((Int(player2LargePoint.text!) ?? 0) + 1)"
                
                player1SmallPoint.text = "0"
                player2SmallPoint.text = "0"
                view.backgroundColor = UIColor(red: 0.276, green: 0.464, blue: 0.933, alpha: 1)
                player1Status.text = playerStatus
                player2Status.text = ""
                ballCount = 0
            }
            else if player2SmallPoint.text == "10" && player1SmallPoint.text == "10"{
                deuceType = true
            }
        }else{
            deuceBall()
        }
        
    }
    
    func changeBall(){
        if ballCount == 2 {
            if player1Status.text == playerStatus{
                view.backgroundColor = UIColor(red: 0.454, green: 0.612, blue: 0.294, alpha: 1)
                player2Status.text = playerStatus
                player1Status.text = ""
            }else if player2Status.text == playerStatus{
                view.backgroundColor = UIColor(red: 0.276, green: 0.464, blue: 0.933, alpha: 1)
                player1Status.text = playerStatus
                player2Status.text = ""
            }
            ballCount = 0
        }
    }
    
    func changeSide(){
        let player1Large = player1LargePoint.text
        let player2Large = player2LargePoint.text
        let player1Small = player1SmallPoint.text
        let player2Small = player2SmallPoint.text
        let player1Type = player1Status.text
        let player2Type = player2Status.text
        
        player1LargePoint.text = player2Large
        player2LargePoint.text = player1Large
        player1SmallPoint.text = player2Small
        player2SmallPoint.text = player1Small
        player1Status.text = player2Type
        player2Status.text = player1Type
    }
    
    func deuceBall(){
        ballCount = 2
        let player1Deuce = Int(player1SmallPoint.text!)
        let player2Deuce = Int(player2SmallPoint.text!)
        let difference = player1Deuce! - player2Deuce!
        
        if difference == 2{
            player1LargePoint.text = "\((Int(player1LargePoint.text!) ?? 0) + 1)"
            
            player1SmallPoint.text = "0"
            player2SmallPoint.text = "0"
            view.backgroundColor = UIColor(red: 0.276, green: 0.464, blue: 0.933, alpha: 1)
            player1Status.text = playerStatus
            player2Status.text = ""
            ballCount = 0
            deuceType = false
        }
        else if difference == -2{
            player2LargePoint.text = "\((Int(player2LargePoint.text!) ?? 0) + 1)"
            
            player1SmallPoint.text = "0"
            player2SmallPoint.text = "0"
            view.backgroundColor = UIColor(red: 0.276, green: 0.464, blue: 0.933, alpha: 1)
            player1Status.text = playerStatus
            player2Status.text = ""
            ballCount = 0
            deuceType = false
        }
        changeBall()
    }
    
    @objc func clickPlayer1LargePoint(_ sender: UITapGestureRecognizer){
        ballCount += 1
        let point = Int(player1SmallPoint.text!) ?? 0
        player1SmallPoint.text = "\(point + 1)"
        addLargePoint()
        changeBall()
    }
    
    @objc func clickPlayer2LargePoint(_ sender: UITapGestureRecognizer){
        ballCount += 1
        let point = Int(player2SmallPoint.text!) ?? 0
        player2SmallPoint.text = "\(point + 1)"
        addLargePoint()
        changeBall()
    }
    
    @objc func clickReset(_ sender: UITapGestureRecognizer){
        initfunc()
    }
    
    @objc func clickChangeSide(_ sender: UITapGestureRecognizer){
        changeSide()
    }
    
    @objc func clickRewind(_ sender: UITapGestureRecognizer){
        showAlert()
    }
    
    func showAlert(){
        let controller = UIAlertController(title: "提醒‼️", message: "暫未開放此功能", preferredStyle: .alert)
           let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           controller.addAction(okAction)
           present(controller, animated: true, completion: nil)
    }


}

