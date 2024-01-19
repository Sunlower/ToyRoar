//
//  IngredientsGatheringView.swift
//  PotionCompendium
//
//  Created by Lais Godinho on 17/10/22.
//

import UIKit

class IngredientsGatheringView: UIView {
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!

    var fallenIngredientsCounter = 0


    lazy var basket: UIImageView = {
        let image = UIImageView(frame: CGRect(
            x: self.bounds.midX - 50,
            y: self.bounds.maxY - 150,
            width: 100,
            height: 100))
        image.image = UIImage(named: "cesta")
        return image
    }()

    let backgroundView = SceneMain()

    lazy var remainingTime = 60 {
//    lazy var remainingTime = 1 {
        didSet {


            if remainingTime == 0 {
                self.collision?.removeAllBoundaries()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    if self.actionWhenPhaseOver != nil {
                        self.actionWhenPhaseOver!()
                    }
                }
            }
        }
    }

    lazy var isBasketFull: Bool = false {
        didSet {
            if isBasketFull {
                self.remainingTime = 0
            }
        }
    }

    var actionWhenPhaseOver: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pannedView))
        basket.addGestureRecognizer(panGesture)
        basket.isUserInteractionEnabled = true

        self.addSubview(basket)

        animator = UIDynamicAnimator(referenceView: self)
        gravity = UIGravityBehavior(items: [])
        collision = UICollisionBehavior(items: [])
        addGravityBehavior()
        addCollisionBehavior()
        setTimer()


    }


    func setTimer() {
        let dropIngredients = dropIngredients()
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.remainingTime <= 0 {
                dropIngredients.invalidate()
                timer.invalidate()
            }
            self.remainingTime -= 1
        }

    }

    func dropIngredients() -> Timer {
        let timer = Timer.scheduledTimer(withTimeInterval: 0.45, repeats: true) { _ in
            let ingredient = self.newIngredient()
            self.collision.addItem(ingredient)
            self.gravity.addItem(ingredient)
        }

        return timer
    }

    func addGravityBehavior() {
        let direction = CGVector(dx: 0, dy: 1)
        gravity.gravityDirection = direction
        gravity.magnitude = 0.25
        animator.addBehavior(gravity)
    }

    func addCollisionBehavior() {
        collision.addBoundary(withIdentifier: "basket" as NSString, for: UIBezierPath(rect: basket.frame))
        animator.addBehavior(collision)
    }

    func newIngredient() -> IngredientIcon {
        let ingredientIcon = IngredientIcon(frame: CGRect(
            x: Int.random(in: 0..<350),
            y: -20,
            width: 35,
            height: 35))

        ingredientIcon.image = UIImage(named: "ingredient-\(Int.random(in: 1...8))")
        self.addSubview(ingredientIcon)
        self.sendSubviewToBack(ingredientIcon)

        return ingredientIcon
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func pannedView(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .changed:
            animator.removeBehavior(collision)
            let translation = recognizer.translation(in: self)
            basket.center = CGPoint(
                x: basket.center.x + translation.x,
                y: basket.center.y)
            recognizer.setTranslation(.zero, in: self)
            self.addCollisionBehavior()
        default:
            break
        }
    }
}
