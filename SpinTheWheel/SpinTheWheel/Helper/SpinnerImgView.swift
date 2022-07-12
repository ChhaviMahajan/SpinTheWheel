//
//  SpinnerImgView.swift
//  SpinTheWheel
//
//  Created by Chhavi Mahajan on 12/07/22.
//

import UIKit

class SpinnerImgView: UIImageView,AnimatorProtocol {
    
    internal var layerToAnimate: CALayer {
        return self.layer
    }

    open var slices:[Int] = []{
        didSet{
           setTheSliceDegree()
        }
    }
    
    lazy private var animator:ImgAnimator = ImgAnimator(withObjectToAnimate: self)
    private(set) var sliceDegree:CGFloat?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setTheSliceDegree(){
        sliceDegree = 360.0 / CGFloat(slices.count)
    }
    
    // MARK: - Animation
    open func startAnimating(fininshIndex:Int = 0, offset:CGFloat, _ completion:((Bool) -> Void)?) {
        let rotation = 360.0 - computeRadian(from: fininshIndex) + offset
        self.startAnimating(rotationCompletionOffset: rotation,  completion)
    }
    
    private func computeRadian(from finishIndex:Int) -> CGFloat {
        return CGFloat(finishIndex) * sliceDegree!
    }
    
    open func startAnimating(rotationCompletionOffset:CGFloat = 0.0, _ completion:((Bool) -> Void)?) {
        self.stopAnimating()
        self.animator.addRotationAnimation(completionBlock: completion,rotationOffset:rotationCompletionOffset)
    }
    
//    open override func stopAnimating() {
//          self.animator.removeAllAnimations()
//      }

}
