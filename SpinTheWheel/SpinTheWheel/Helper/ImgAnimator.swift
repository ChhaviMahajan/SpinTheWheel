//
//  ImgAnimator.swift
//  SpinTheWheel
//
//  Created by Chhavi Mahajan on 12/07/22.
//

import UIKit

protocol AnimatorProtocol
{
    var layerToAnimate:CALayer { get }
}

class ImgAnimator: NSObject, CAAnimationDelegate {

    var animationObject:AnimatorProtocol!
    internal var completionBlocks = [CAAnimation: (Bool) -> Void]()
    internal var updateLayerValueForCompletedAnimation : Bool = false
    
    //Configuration parameters
    var fullRotationsUntilFinish:Int = 13
    var rotationTime: CFTimeInterval = 5.000
    
    init(withObjectToAnimate animationObject:AnimatorProtocol) {
        self.animationObject = animationObject
    }
    
    func addRotationAnimation(completionBlock: ((_ finished: Bool) -> Void)? = nil, rotationOffset:CGFloat = 0.0){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = rotationTime
            completionAnim.delegate = self
            completionAnim.setValue("rotation", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            let layer = animationObject.layerToAnimate
            layer.add(completionAnim, forKey:"rotation")
            if let anim = layer.animation(forKey: "rotation"){
                completionBlocks[anim] = completionBlock
            }
        }
        
        let fillMode : String = CAMediaTimingFillMode.forwards.rawValue
        
        let rotation:CGFloat = CGFloat(fullRotationsUntilFinish) * 360.0 + rotationOffset
//        print(rotation)
        
        let starTransformAnim = CAKeyframeAnimation(keyPath:"transform.rotation.z")
        
        starTransformAnim.values = [0, rotation * CGFloat.pi/180]
        starTransformAnim.keyTimes = [0, 1]
        starTransformAnim.duration = 5
        starTransformAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.0256, 0.874, 0.675, 1)
        starTransformAnim.isRemovedOnCompletion = false
        let starRotationAnim : CAAnimationGroup = AnimationUtility.group(animations: [starTransformAnim], fillMode:fillMode)
        animationObject.layerToAnimate.add(starRotationAnim, forKey:"starRotationAnim")
    }
    
    //MARK: - Animation Cleanup
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool){
        if let completionBlock = completionBlocks[anim]{
            completionBlocks.removeValue(forKey: anim)
            if (flag && updateLayerValueForCompletedAnimation) || anim.value(forKey: "needEndAnim") as! Bool{
                updateLayerValues(forAnimationId: anim.value(forKey: "animId") as! String)
                removeAnimations(forAnimationId: anim.value(forKey: "animId") as! String)
            }
            completionBlock(flag)
        }
    }
    
    func updateLayerValues(forAnimationId identifier: String){
        if identifier == "rotation"{
            AnimationUtility.updateValueFromPresentationLayer(forAnimation: animationObject.layerToAnimate.animation(forKey: "starRotationAnim"), theLayer:animationObject.layerToAnimate)
        }
    }
    
    func removeAnimations(forAnimationId identifier: String){
        if identifier == "rotation"{
            animationObject.layerToAnimate.removeAnimation(forKey: "starRotationAnim")
        }
    }
    
    func removeIndefiniteAnimation() {
        animationObject.layerToAnimate.removeAnimation(forKey: "starRotationIndefiniteAnim")
    }
    
    func removeAllAnimations(){
        animationObject.layerToAnimate.removeAllAnimations()
    }
}
