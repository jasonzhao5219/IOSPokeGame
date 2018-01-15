import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet var cardGroup1: [UIImageView]!
    
    @IBOutlet var cardGroup2: [UIImageView]!
    
    @IBOutlet var welcomeLabel: UILabel!
    
    @IBOutlet var restartBtn: UIButton!
    @IBAction func restartBtnPressed(_ sender: UIButton) {
        endMatch = false
        playerTurn = 1
        for card in cardGroup1 {
            card.isHidden = true
        }
        for card in cardGroup2 {
            card.isHidden = true
        }
    }
    
    @IBOutlet var player2PassBtn: UIButton!
    @IBAction func player2PassBtnPressed(_ sender: UIButton) {
        playerTurn += 1
        updateUI()
    }
    
    @IBOutlet var upsideDownBtn: UIButton!
    @IBAction func upsideDownBtnPressed(_ sender: UIButton) {
        playerTurn += 1
        updateUI()
    }
    
    var turnCounter: Int = 0
    var MyturnCounter: Int = 1
    var YourturnCounter: Int = 0
    //control what my points is and how to calcaulate it:
    var motionManager: CMMotionManager?
    
    let player1 = Player(name: "Player 1")
    let player2 = Player(name: "Player 2")
    var endMatch = false
    var playerTurn = 1
    
    func updateUI() {
        motionManager = CMMotionManager()
        if let manager = motionManager {
            manager.deviceMotionUpdateInterval = 0.2
            let myQueue = OperationQueue()
            manager.startDeviceMotionUpdates(to: myQueue, withHandler: {(data: CMDeviceMotion?, error: Error?) in
                var cardSum1 = 0
                var cardSum2 = 0
                while self.endMatch == false {
                    if self.playerTurn % 2 != 0 {
                        //Player 1's turn
                        self.welcomeLabel.text = "\(self.player1.playerName)'s turn"
                        self.welcomeLabel.isHidden = false
                        if let myData = data {
                            let myNumberBlack = myData.userAcceleration.x
                            let myNumberRed = myData.userAcceleration.y
                            for number in self.player1.hand {
                                if number == 1 {
                                    cardSum1 += 11
                                } else if number > 10 {
                                    cardSum1 += 10
                                }
                                else {
                                    cardSum1 += number
                                }
                            }
                            if cardSum1 < 22 {
                                if myNumberBlack > 0.6 {
                                    DispatchQueue.main.async {
                                        let newCard = self.dealBlack()
                                        self.cardGroup1[self.playerTurn].image = UIImage(named: newCard.0)
                                        self.cardGroup1[self.playerTurn].isHidden = false
                                        self.player1.hand.append(newCard.1)
                                    }
                                } else if myNumberRed > 0.6 {
                                    DispatchQueue.main.async {
                                        let newCard = self.dealRed()
                                        self.cardGroup1[self.playerTurn].image = UIImage(named: newCard.0)
                                        self.cardGroup1[self.playerTurn].isHidden = false
                                        self.player1.hand.append(newCard.1)
                                    }
                                }
                            } else if cardSum1 > 21 && self.player1.hand.contains(1) {
                                cardSum1 -= 10
                                if myNumberBlack > 0.6 {
                                    DispatchQueue.main.async {
                                        let newCard = self.dealBlack()
                                        self.cardGroup1[self.playerTurn].image = UIImage(named: newCard.0)
                                        self.cardGroup1[self.playerTurn].isHidden = false
                                        self.player1.hand.append(newCard.1)
                                    }
                                } else if myNumberRed > 0.6 {
                                    DispatchQueue.main.async {
                                        let newCard = self.dealRed()
                                        self.cardGroup1[self.playerTurn].image = UIImage(named: newCard.0)
                                        self.cardGroup1[self.playerTurn].isHidden = false
                                        self.player1.hand.append(newCard.1)
                                    }
                                }
                            } else if cardSum1 > 21 {
                                self.endMatch = true
                                self.welcomeLabel.text = "Player 2 wins!"
                                self.welcomeLabel.isHidden = false
                            }
                        }
                        //Safely unwrapping errors
                        if let myError = error {
                            print("error", myError)
                            manager.stopDeviceMotionUpdates()
                        }
                        self.welcomeLabel.text = "\(cardSum1)"
                        self.welcomeLabel.isHidden = false
                        self.playerTurn += 1
                    }
                    else {
                        // Player 2's turn
                        self.welcomeLabel.text = "\(self.player2.playerName)'s turn"
                        self.welcomeLabel.isHidden = false
                        if let myData = data {
                            let myNumberBlack = myData.userAcceleration.x
                            let myNumberRed = myData.userAcceleration.y
                            for number in self.player2.hand {
                                if number == 1 {
                                    cardSum2 += 11
                                } else if number > 10 {
                                    cardSum2 += 10
                                }
                                else {
                                    cardSum2 += number
                                }
                            }
                            if cardSum2 < 22 {
                                if myNumberBlack > 0.6 {
                                    DispatchQueue.main.async {
                                        let newCard = self.dealBlack()
                                        self.cardGroup2[self.playerTurn].image = UIImage(named: newCard.0)
                                        self.cardGroup2[self.playerTurn].isHidden = false
                                        self.player2.hand.append(newCard.1)
                                    }
                                } else if myNumberRed > 0.6 {
                                    DispatchQueue.main.async {
                                        let newCard = self.dealRed()
                                        self.cardGroup2[self.playerTurn].image = UIImage(named: newCard.0)
                                        self.cardGroup2[self.playerTurn].isHidden = false
                                        self.player2.hand.append(newCard.1)
                                    }
                                }
                            } else if cardSum2 > 21 && self.player2.hand.contains(1) {
                                cardSum2 -= 10
                                if myNumberBlack > 0.6 {
                                    DispatchQueue.main.async {
                                        let newCard = self.dealBlack()
                                        self.cardGroup2[self.playerTurn].image = UIImage(named: newCard.0)
                                        self.cardGroup2[self.playerTurn].isHidden = false
                                        self.player2.hand.append(newCard.1)
                                    }
                                } else if myNumberRed > 0.6 {
                                    DispatchQueue.main.async {
                                        let newCard = self.dealRed()
                                        self.cardGroup2[self.playerTurn].image = UIImage(named: newCard.0)
                                        self.cardGroup2[self.playerTurn].isHidden = false
                                        self.player2.hand.append(newCard.1)
                                    }
                                }
                            } else if cardSum2 > 21 {
                                self.endMatch = true
                                self.welcomeLabel.text = "Player 1 wins!"
                                self.welcomeLabel.isHidden = false
                            }
                        }
                        //Safely unwrapping errors
                        if let myError = error {
                            print("error", myError)
                            manager.stopDeviceMotionUpdates()
                        }
                        self.playerTurn += 1
                        self.welcomeLabel.text = "\(cardSum2)"
                    }
                //Below bracket is endwhile
                }
                if let myData = data {
                    let myNumberBlack = myData.userAcceleration.x
                    let myNumberRed = myData.userAcceleration.y
                    if myNumberBlack > 0.6 || myNumberRed > 0.6 {
                        self.endMatch = false
                        self.playerTurn = 1
                    }
                }
                if let myError = error {
                    print("error", myError)
                    manager.stopDeviceMotionUpdates()
                }
            })
        } else {
            print("We have no manager")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restartBtn.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        upsideDownBtn.transform =
            CGAffineTransform(rotationAngle: CGFloat.pi)
        welcomeLabel.text = "Shake me"
        for card in cardGroup1 {
            card.isHidden = true
        }
        for card in cardGroup2 {
            card.isHidden = true
        }
        updateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dealRed() -> (String, Int) {
        let random = Int(arc4random_uniform(26)) + 1
        let cardName = "red_\(random)"
        let cardValue = random % 13
        return (cardName, cardValue)
    }
    
    func dealBlack() -> (String, Int) {
        let random = Int(arc4random_uniform(26)) + 1
        let cardName = "black_\(random)"
        let cardValue = random % 13
        return (cardName, cardValue)
    }
}

class Player {
    var playerName: String
    var hand = [Int]()
    init(name: String) {
        self.playerName = name
    }
}




