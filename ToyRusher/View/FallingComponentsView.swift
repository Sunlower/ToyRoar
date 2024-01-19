//
//  FallingHeartsView.swift
//
//
//  Created by Sarah Madalena on 04/04/23.
//

import Foundation
import UIKit
import SwiftUI

struct FallingComponentsView: UIViewRepresentable {
    @Binding var pause: Bool
    @Binding var progress: CGFloat
    @State var coordinator = FallingComponentViewCoordinator()
    var componentNotToCollect: Components

    func makeUIView(context: Context) -> UIView {
        let screen = FallingComponent(componentToCollect: componentNotToCollect)
        context.coordinator.screen = screen
        screen.collision.collisionDelegate = context.coordinator
        screen.timer.fire()
        return screen
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if !pause {
            _ = uiView as! FallingComponent
        }
    }

    func didCollectComponent(_ value: CGFloat) {
        progress += 1
        if progress >= 10 { coordinator.screen?.finishDrop() }
    }

    func makeCoordinator() -> FallingComponentViewCoordinator {
        coordinator.didCollectComponents = didCollectComponent
        coordinator.componentNotToCollect = componentNotToCollect
        return coordinator
    }
}

class FallingComponent: UIView {
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var componentToCollect: Components

    let background: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Cenario/cenario")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let topside: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Extras/topBar")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let mesa: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Cenario/mesa")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var timer = Timer.scheduledTimer(
        timeInterval: 1.0,
        target: self,
        selector: #selector(dropComponent),
        userInfo: nil,
        repeats: true
    ) //tempo de queda do coracao

    lazy var pote: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Extras/cesta")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }() //responsavel pela posicao do pote

    var actionWhenPhaseOver: (() -> Void)?
    var components: [UIImageView] = [UIImageView]()

    init(componentToCollect: Components) {
        self.componentToCollect = componentToCollect
        super.init(frame: .zero)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pannedView))
        pote.addGestureRecognizer(panGesture) //reconhece o movimento do gesture
        pote.isUserInteractionEnabled = true //habilita o movimento

        self.backgroundColor = .white
        self.addSubview(background)
        self.addSubview(topside)
        self.addSubview(mesa)
        self.addSubview(pote)

        setConstraints()

        animator = UIDynamicAnimator(referenceView: self)
        gravity = UIGravityBehavior(items: [])
        collision = UICollisionBehavior(items: [])

        addGravityBehavior()
        addCollisionBehavior()
    }

    @objc
    func dropComponent() {
        let component = newComponent()
        self.collision.addItem(component)
        self.gravity.addItem(component)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            background.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            background.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            background.topAnchor.constraint(equalTo: self.topAnchor),


            topside.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            topside.topAnchor.constraint(equalTo: self.topAnchor, constant: -120),
            topside.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2),
            topside.heightAnchor.constraint(equalToConstant: 250),

            mesa.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mesa.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mesa.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            mesa.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height*0.25),

            pote.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -160),
            pote.widthAnchor.constraint(equalToConstant: 150),
            pote.heightAnchor.constraint(equalToConstant: 100),
        ])
    }

    @objc
    func addGravityBehavior() {
        let direction = CGVector(dx: 0, dy: 1)
        gravity.gravityDirection = direction
        gravity.magnitude = 0.25
        animator.addBehavior(gravity)
    }

    func addCollisionBehavior() {
        collision.addBoundary(withIdentifier: "Extras/cesta" as NSString, for: UIBezierPath(rect: pote.frame))
        animator.addBehavior(collision)
    }

    func newComponent() -> UIImageView {
        let componentIcon = UIImageView(
            frame: CGRect(
                x: Int.random(in: 150..<Int(UIScreen.main.bounds.width * 0.8)),
                y: -200,
                width: 120,
                height: 70
            )
        )
        let iconNumber = Int.random(in: 1..<5)

        var componentImage = ""

        switch iconNumber {
            case 1:
                componentImage = "Circuit/Resistor"
                componentIcon.image = UIImage(named: componentImage)
            case 2:
                componentImage = "Circuit/Transistor"
                componentIcon.image = UIImage(named: componentImage)
            case 3:
                componentImage = "Circuit/Diode"
                componentIcon.image = UIImage(named: componentImage)
            case 4:
                componentImage = "Circuit/Transistor"
                componentIcon.image = UIImage(named: componentImage)
            default:
                break
        }

        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = componentIcon.bounds

        if componentToCollect == .transistor && componentImage == "Circuit/Transistor" {
            componentIcon.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            componentIcon.layer.shadowColor = UIColor.systemRed.cgColor
            componentIcon.layer.shadowRadius = 7
            componentIcon.layer.shadowOpacity = 1
        }

        if componentToCollect == .resistor && componentImage == "Circuit/Resistor" {
            componentIcon.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            componentIcon.layer.shadowColor = UIColor.systemRed.cgColor
            componentIcon.layer.shadowRadius = 7
            componentIcon.layer.shadowOpacity = 1
        }

        if componentToCollect == .diode && componentImage == "Circuit/Diode" {
            componentIcon.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            componentIcon.layer.shadowColor = UIColor.systemRed.cgColor
            componentIcon.layer.shadowRadius = 7
            componentIcon.layer.shadowOpacity = 1
        }

        if componentToCollect == .broken && componentImage == "Circuit/Transistor" {
            componentIcon.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            componentIcon.layer.shadowColor = UIColor.white.cgColor
            componentIcon.layer.shadowRadius = 7
            componentIcon.layer.shadowOpacity = 1
        }

        self.background.addSubview(componentIcon)
        components.append(componentIcon)

        return componentIcon
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func finishDrop() {
        components.forEach { $0.removeFromSuperview() }
        timer.invalidate()
    }

    @objc func pannedView(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
            case .changed:
                animator.removeBehavior(collision)
                let translation = recognizer.translation(in: self)
                pote.center = CGPoint(
                    x: pote.center.x + translation.x,
                    y: pote.center.y
                )
                recognizer.setTranslation(.zero, in: self)
                self.addCollisionBehavior()
            default:
                break
        }
    }
}
