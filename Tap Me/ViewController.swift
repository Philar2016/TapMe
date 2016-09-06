//
//  ViewController.swift
//  Tap Me
//
//  Created by LiangMinglong on 17/06/2016.
//  Copyright © 2016 LiangMinglong. All rights reserved.
//

import UIKit
//加入音频文件时 需要import AVFoundation
import AVFoundation

//定义一个叫ViewController的类
class ViewController: UIViewController {
    
    //定义一些变量var scoreLabel,timerLabel,count, second, timer，
    @IBOutlet var scoreLabel : UILabel!
    @IBOutlet var timerLabel : UILabel!
    var count = 0
    var second = 0
    var timer = NSTimer()
    //定义关于音频的变量buttonBeep,secondBeep,backgroundMusic. AVAudioPlayer? ？＝如果找不到值，可以为nil
    var buttonBeep : AVAudioPlayer?
    var secondBeep : AVAudioPlayer?
    var backgroundMusic : AVAudioPlayer?
    
    
    //定义一个setupAudioPlayerWithFile的方法，file类型是nextstep String, type类型是nextstep String
    func setupAudioPlayerWithFile(file:NSString, type: NSString) -> AVAudioPlayer? {
        //1
        print("aaa",file,type)
        //let路径path=NSBundle.mainBundle().pathForResource(file类型string，type类型string
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        //let url调用这个path
        let url = NSURL.fileURLWithPath(path!)
        
        
        //2
        //定义一个audioPlayer的变量，如果找不到AVAudioPlayer,则取值为nil
        var audioPlayer : AVAudioPlayer?
        //3
        //do循环，try audioPlayer,如果找到AVAudioPlayer,catch it, print it.然后return audioPlayer
        do{
            try audioPlayer = AVAudioPlayer(contentsOfURL:url)
        } catch {
            print("player not available")
        }
        return audioPlayer
    }

    //定义一个方法 func viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupGame()
        //调用view.backgroundColor，在Assets.xcassets里。
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_image")!)
        
        //调用ssoreLabel.backgroundColor和timerLabel,在Assets.xcassets里.
        scoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "field_score")!)
        
        timerLabel.backgroundColor = UIColor(patternImage: UIImage(named:"field_time")!)

        //if let检查buttonBeep是否为buttonTap type"wav", 如果是，则把self.buttonBeep赋值给buttonBeep
        if let buttonBeep = self.setupAudioPlayerWithFile("ButtonTap", type: "wav") {
            self.buttonBeep = buttonBeep
        }
        //if let检查secondBeep是否为 type"wav", 如果是，则把self.secondBeep赋值给secondBeep
        if let secondBeep = self.setupAudioPlayerWithFile("SecondBeep", type:"wav"){
            self.secondBeep = secondBeep
        }
        //if let检查backgroundMusic是否为hallofthemountainking type"mp3", 如果是，则把self.backgroundMusic赋值给backgroundMusic
        if let backgroundMusic = self.setupAudioPlayerWithFile("HallOfTheMountainKing", type:"mp3"){
            self.backgroundMusic = backgroundMusic
        }
        
    }
    
    //定义一个叫didReceiveMemoryWarning的方法
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //定义一个方法func, 按钮buttonPressed()
    @IBAction func buttonPressed(){
        //count计数
        count = count + 1
        //显示分数
        scoreLabel.text = "Score \n\(count)"
        buttonBeep?.play()
        
    }
    
    //定义一个叫steupGame()的方法，秒数＝30，计数从0开始
    func setupGame() {
       second = 30
       count = 0
    
    //timerLabel.text显示
    timerLabel.text = "Time: \(second)"
    //scoreLabel.text显示
    scoreLabel.text = "Score: \(count)"
    
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0,target: self, selector: #selector(ViewController.subtractTime), userInfo: nil, repeats: true)
    //backgroundMusic音量为0.3, 0为静音，10为最大，
        backgroundMusic?.volume = 0.3
        backgroundMusic?.play()
        
    }
    
    
    
    //定义一个subtractTime()“计时”的方法
    func subtractTime(){
        second = second - 1
    timerLabel.text = "Time: \(second)"
         secondBeep?.play()
                      //当时间＝0的时候，停止
                        if (second == 0) {
                    timer.invalidate()
     //设置一个UIalert闹钟
      let UIalert = UIAlertController (title: "Time is Up", message: "You scored \(count) points", preferredStyle: UIAlertControllerStyle.Alert)
                    
    UIalert.addAction(UIAlertAction(title:"Play Again", style:UIAlertActionStyle.Default, handler: {action in self.setupGame()}))
        
     presentViewController(UIalert, animated: true, completion:nil)
                
    }

}
}



