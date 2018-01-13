import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet var card1: UIImageView!
    @IBOutlet var card2: UIImageView!
    @IBOutlet var card3: UIImageView!
    @IBOutlet var card4: UIImageView!
    @IBOutlet var card5: UIImageView!
    @IBOutlet var card6: UIImageView!
    @IBOutlet var card7: UIImageView!
    @IBOutlet var card8: UIImageView!
    @IBOutlet var card9: UIImageView!
    @IBOutlet var card10: UIImageView!

    @IBOutlet var MyPoints: UILabel!
    
    @IBOutlet var restartBtn: UIButton!
    @IBAction func restartBtnPressed(_ sender: UIButton) {
        turnCounter=0
        MyturnCounter=1
        YourturnCounter=0
        welcomeLabel.isHidden = false
        
        card1.isHidden = true
        card2.isHidden = true
        card3.isHidden = true
        card4.isHidden = true
        card5.isHidden = true
        card6.isHidden = true
        card7.isHidden = true
        card8.isHidden = true
        card9.isHidden = true
        card10.isHidden = true
       
        
    }
    
    @IBAction func pass2(_ sender: UIButton) {
        //turnCounter+=1
        turnCounter=YourturnCounter
        MyturnCounter+=2
        updateUI()
    }
    
    @IBOutlet var upsideDownBtn: UIButton!
    @IBAction func upsideDownBtnPressed(_ sender: UIButton) {
        //turnCounter+=1
        turnCounter=MyturnCounter
        YourturnCounter+=2
         updateUI()
        
    }
    
    var randomnum:[Int]=[Int]()

    @IBOutlet var cardImage: UIImageView!
    
    @IBOutlet var welcomeLabel: UILabel!
    
    @IBAction func displaymypoints(_ sender: UIButton) {
        //updateUI()
        
        
    }

    @IBOutlet var MessageLabel: UILabel!
    
    var turnCounter:Int=0
    var MyturnCounter:Int=1
    var YourturnCounter:Int=0
    //control what my points is and how to calcaulate it:
    func updateUI() {
        //black jack game rule here
        var totalpoints:Int=0
        
    
        totalpoints+=randomnum[randomnum.count-1]
        
        print(totalpoints)
        MessageLabel.text = "my total points is\(totalpoints)"
        MessageLabel.isHidden = true
        if totalpoints>21{
            MessageLabel.text="Bomb!"
        }
    }
    
    var motionManager: CMMotionManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restartBtn.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        upsideDownBtn.transform =
            CGAffineTransform(rotationAngle: CGFloat.pi)
        MessageLabel.isHidden = true
        welcomeLabel.text = "Shake me"
        card1.isHidden = true
        card2.isHidden = true
        card3.isHidden = true
        card4.isHidden = true
        card5.isHidden = true
        card6.isHidden = true
        card7.isHidden = true
        card8.isHidden = true
        card9.isHidden = true
        card10.isHidden = true
        
        //Assigning instance of MotionManager to variable
        motionManager = CMMotionManager()
        
        //Safely unwrapping and accessing manager
        if let manager = motionManager {
            manager.deviceMotionUpdateInterval=0.2
            print("We have our manager")
            
            //Establish alternate Queueueueue to handle updates
            let myQ = OperationQueue()
            
            //Call method to start updates, sending in myQ and closure to handle data
            manager.startDeviceMotionUpdates(to: myQ, withHandler: {
                (data: CMDeviceMotion?, error: Error?) in
                
                //Safely unwrapping data or error
                if let myData = data {
                    let mynumberBlack=myData.userAcceleration.x
                    let mynumberRed=myData.userAcceleration.y
                    if mynumberBlack>1.0 {
                        DispatchQueue.main.async {
                            self.dealBlack()
                            self.turnCounter+=2
                            if self.turnCounter%2==1
                            {self.MyturnCounter+=2}
                        }
                    } else if mynumberRed>1.0 {
                        DispatchQueue.main.async {
                            self.dealRed()
                            self.turnCounter+=2
                            if self.turnCounter%2==0
                            {self.YourturnCounter+=2}                        }
                    }
                }
                //Safely unwrapping errors
                if let myError = error {
                    print("error",myError)
                    manager.stopDeviceMotionUpdates()
                }
            })
        } else {
            print("We have no manager")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    var mypoint:Int=0
    func dealRed() {
        let random = Int(arc4random_uniform(26)) + 1
        //add random number to a array
        randomnum.append(random)
        print(randomnum)
        let cardName = "red_\(random)"
        if turnCounter==0{
            card1.image = UIImage(named: cardName)
            
            card1.isHidden = false
        }
        if turnCounter==1{
            card6.image = UIImage(named: cardName)
            
            card6.isHidden = false        }
        if turnCounter==2{
            card2.image = UIImage(named: cardName)
            
            card2.isHidden = false        }
        if turnCounter==3{
            card7.image = UIImage(named: cardName)
            
            card7.isHidden = false        }
        if turnCounter==4{
            card3.image = UIImage(named: cardName)
            
            card3.isHidden = false        }
        if turnCounter==5{
            card8.image = UIImage(named: cardName)
            
            card8.isHidden = false        }
        if turnCounter==6{
            card4.image = UIImage(named: cardName)
            
            card4.isHidden = false        }
        if turnCounter==7{
            card9.image = UIImage(named: cardName)
            
            card9.isHidden = false        }
        if turnCounter==8{
            card5.image = UIImage(named: cardName)
            
            card5.isHidden = false        }
        if turnCounter==9{
            card10.image = UIImage(named: cardName)
            
            card10.isHidden = false        }
        welcomeLabel.isHidden = true
        
    }
    func dealBlack() {
        let random = Int(arc4random_uniform(26)) + 1
        randomnum.append(random)
        let cardName = "black_\(random)"
        print(turnCounter)
        print(cardName)
        if turnCounter==0{
        card1.image = UIImage(named: cardName)
        
        card1.isHidden = false
        }
        if turnCounter==1{
            card6.image = UIImage(named: cardName)
            
            card6.isHidden = false        }
        if turnCounter==2{
            card2.image = UIImage(named: cardName)
            
            card2.isHidden = false        }
        if turnCounter==3{
            card7.image = UIImage(named: cardName)
            
            card7.isHidden = false        }
        if turnCounter==4{
            card3.image = UIImage(named: cardName)
            
            card3.isHidden = false        }
        if turnCounter==5{
            card8.image = UIImage(named: cardName)
            
            card8.isHidden = false        }
        if turnCounter==6{
            card4.image = UIImage(named: cardName)
            
            card4.isHidden = false        }
        if turnCounter==7{
            card9.image = UIImage(named: cardName)
            
            card9.isHidden = false        }
        if turnCounter==8{
            card5.image = UIImage(named: cardName)
            
            card5.isHidden = false        }
        if turnCounter==9{
            card10.image = UIImage(named: cardName)
            
            card10.isHidden = false        }
        
        welcomeLabel.isHidden = true
        
    }
}




