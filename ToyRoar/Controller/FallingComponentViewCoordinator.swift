//
//  FallingHeartsViewController.swift
//
//
//  Created by Sarah Madalena on 04/04/23.
//

import Foundation
import UIKit
import SwiftUI

enum Components {
    case broken
    case transistor
    case resistor
    case diode

}

class FallingComponentViewCoordinator: NSObject, UICollisionBehaviorDelegate {
    var screen: FallingComponent?
    var collectedComponentsCounter = 0
    let limiteCounter: Int = 10
    var didCollectComponents: ((CGFloat) -> Void)?
    var componentNotToCollect: Components = .broken

    init(
        screen: FallingComponent? = nil,
        collectedComponentsCounter: Int = 0,
        didCollectComponents: ((CGFloat) -> Void)? = nil,
        componentNotToCollect: Components = .broken
    ) {
        self.screen = screen
        self.collectedComponentsCounter = collectedComponentsCounter
        self.didCollectComponents = didCollectComponents
        self.componentNotToCollect = componentNotToCollect
    }

    func collisionBehavior(
        _ behavior: UICollisionBehavior,
        beganContactFor item: UIDynamicItem,
        withBoundaryIdentifier identifier: NSCopying?,
        at point: CGPoint) {
            guard let screen = self.screen else { return }
            guard let imagemView: UIImageView = item as? UIImageView else { return }
            var component: UIImage?

            switch componentNotToCollect {
                case .resistor:
                    component = UIImage(named: "Circuit/Resistor")
                    if component ==  imagemView.image {
                        collectedComponentsCounter += 1
                        didCollectComponents?(CGFloat(collectedComponentsCounter))
                    }
                case .transistor:
                    component = UIImage(named: "Circuit/Transistor")
                    if component ==  imagemView.image {
                        collectedComponentsCounter += 1
                        didCollectComponents?(CGFloat(collectedComponentsCounter))
                    }
                case .diode:
                    component = UIImage(named: "Circuit/Diode")
                    if component ==  imagemView.image {
                        collectedComponentsCounter += 1
                        didCollectComponents?(CGFloat(collectedComponentsCounter))
                    }
                case .broken:
                    component = UIImage(named: "Circuit/Transistor")
                    if component ==  imagemView.image {
                        collectedComponentsCounter += 1
                        didCollectComponents?(CGFloat(collectedComponentsCounter))
                    }
            }


            screen.collision.removeItem(item)
            imagemView.removeFromSuperview()
        }
}
