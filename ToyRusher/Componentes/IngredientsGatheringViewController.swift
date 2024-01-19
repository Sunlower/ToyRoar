import UIKit
import AVFAudio

class IngredientsGatheringViewController: UIViewController {
    var screen: IngredientsGatheringView?

    var collectedIngredientsPercentage = 0

    var collectedIngredientsCounter = 0 

    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        screen = IngredientsGatheringView(frame: UIScreen.main.bounds)
        self.view = screen!
        self.screen!.collision?.collisionDelegate = self

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

}

extension IngredientsGatheringViewController: UICollisionBehaviorDelegate {

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
