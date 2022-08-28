//
//  Anim.swift
//  Kiliaro
//
//  Created by Amir Mohamadi on 8/26/22.
//

import UIKit

class Animator {
    
    public enum AnimType {
        case none
        case expand(TimeInterval)
        case pop(TimeInterval)
    }
    
    static func animate(type: AnimType, view: UIView) {
        switch type {
        case .none:
            break
        case .expand(let timeInterval):
            view.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
            UIView.animate(withDuration: timeInterval){
                view.layer.transform = CATransform3DMakeScale(1, 1, 1)
            }
        case .pop(let timeInterval):
            view.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1)
            UIView.animate(withDuration: timeInterval){
                view.layer.transform = CATransform3DMakeScale(1, 1, 1)
            }
        }
    }
}
