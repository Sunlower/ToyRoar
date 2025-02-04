//
//  ComponentsViewController.swift
//  ToyRusher
//
//  Created by Ieda Xavier on 08/01/24.
//

import UIKit
import AVFAudio

class ComponentsViewController: UIViewController {
    var collectedIngredientsPercentage = 0
    var collectedIngredientsCounter = 0 {
        
    }

    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        screen = IngredientsGatheringView(frame: UIScreen.main.bounds)
        self.view = screen!
        self.screen!.collision?.collisionDelegate = self
        self.screen?.actionWhenPhaseOver = nextPhase

        loadAudio()
    }

    func loadAudio() {
        if let asset = NSDataAsset(name: "pickup") {
            do {
                player = try AVAudioPlayer(data: asset.data, fileTypeHint: "mp3")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }

    func nextPhase() {
        let nextScreen = PotionBrewingViewController()
        nextScreen.collectedIngredientsPercentage = self.collectedIngredientsCounter
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(nextScreen, animated: true)
    }

    func getSecondsAsMinutesAndSeconds(_ seconds: Double) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad

        let formattedString = formatter.string(from: TimeInterval(seconds))
        return formattedString
    }
}

extension ComponentsViewController: UICollisionBehaviorDelegate {

    func collisionBehavior(
        _ behavior: UICollisionBehavior,
        beganContactFor item: UIDynamicItem,
        withBoundaryIdentifier identifier: NSCopying?,
        at point: CGPoint) {
            (item as? UIView)?.frame = CGRect(
                x: item.bounds.midX,
                y: item.bounds.midY,
                width: 0,
                height: 0)
            player?.play()
            player?.volume = 0.5
    }

    func collisionBehavior(
        _ behavior: UICollisionBehavior,
        endedContactFor item: UIDynamicItem,
        withBoundaryIdentifier identifier: NSCopying?) {
            guard let screen = self.screen else {
                return
            }
            collectedIngredientsCounter += 1
            screen.collision.removeItem(item)
    }
}


#Preview {
    ComponentsViewController()
}
