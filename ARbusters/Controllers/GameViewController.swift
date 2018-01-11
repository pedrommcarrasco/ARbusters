//
//  ViewController.swift
//  ARniegeddon
//
//  Created by Pedro Carrasco on 10/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import ARKit
import AVKit

class GameViewController: UIViewController {

    // MARK: - OUTLETS
    @IBOutlet var sceneView: ARSKView!
    let avPlayer = AVPlayer(name: "theme", extension: "mp3")

    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        avPlayer?.volume = 0.05
        avPlayer?.playLoop()

        let scene = GameScene(size: sceneView.bounds.size)
        scene.scaleMode = .resizeFill
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        sceneView.delegate = self
        sceneView.presentScene(scene)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    // MARK: - ACTIONS
    @IBAction func closeBtnAction(_ sender: UIButton) {
    }

    @IBAction func musicBtnAction(_ sender: UIButton) {
        guard let avPlayer = avPlayer else { return }
        sender.touchAnimation()
        if avPlayer.volume > 0 {
            avPlayer.volume = 0
            sender.setImage(#imageLiteral(resourceName: "ic-music-turnOn"), for: .normal)
        } else {
            avPlayer.volume = 0.05
            sender.setImage(#imageLiteral(resourceName: "ic-music-turnOff"), for: .normal)
        }
    }
}

extension GameViewController: ARSKViewDelegate {

    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        guard let anchor = anchor as? Anchor, let type = anchor.type else { return nil }

        let node = type.asSprite()
        node.name = type.rawValue

        return node
    }

    func sessionInterruptionEnded(_ session: ARSession) {
        sceneView.session.run(session.configuration!,
                              options: [.resetTracking,
                                        .removeExistingAnchors])
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
        let alert = UIAlertController(title: "Error",
                                      message: "It seems we're having trouble launching ARniegeddon.",
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
