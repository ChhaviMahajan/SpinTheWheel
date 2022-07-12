//
//  ViewController.swift
//  SpinTheWheel
//
//  Created by Chhavi Mahajan on 12/07/22.
//

import UIKit

class SpinnerWheelVC: UIViewController {
    
    @IBOutlet weak var spinnerImgView: SpinnerImgView!
    
    let slices = Array(repeating: 0, count: 8)
    let coinsArr: [Int] = [50, 500, 10, 100, 5, 200, 20, 300]
    
    static var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        spinnerImgView.slices = slices
    }
    
    @IBAction func spinButtonClicked(_ sender: Any)
    {
        let index = Int.random(in: 0...7)
        print("Index: \(index)")
        
        self.spinnerImgView.startAnimating(fininshIndex: index, offset: CGFloat(-(360/self.slices.count)/2), { (finished) in
                print(finished)
            print("Coins won: \(self.coinsArr[index])")
            
            let alertController = UIAlertController(title: "You have won \(self.coinsArr[index]) coins!", message: "\n\n\n\n", preferredStyle: .alert)
            
            let image = UIImageView(image: UIImage(named: "confetti.png"))
            alertController.view.addSubview(image)
            image.translatesAutoresizingMaskIntoConstraints = false
            alertController.view.addConstraint(NSLayoutConstraint(item: image, attribute: .centerX, relatedBy: .equal, toItem: alertController.view, attribute: .centerX, multiplier: 1, constant: 0))
            alertController.view.addConstraint(NSLayoutConstraint(item: image, attribute: .centerY, relatedBy: .equal, toItem: alertController.view, attribute: .centerY, multiplier: 1, constant: 0))
            alertController.view.addConstraint(NSLayoutConstraint(item: image, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 64.0))
            alertController.view.addConstraint(NSLayoutConstraint(item: image, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 64.0))
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)

            self.present(alertController, animated: true, completion: nil)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

