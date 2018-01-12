//
//  ViewController.swift
//  ARniegeddon
//
//  Created by Pedro Carrasco on 10/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import ARKit

class GameViewController: UIViewController {

    // MARK: - OUTLETS
    @IBOutlet var sceneView: ARSKView!

    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = GameScene(size: sceneView.bounds.size)
        scene.scaleMode = .resizeFill
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        sceneView.delegate = self
        sceneView.presentScene(scene)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MusicManager.sharedInstance.playBackgroundMusic()
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
        MusicManager.sharedInstance.stopBackgroundMusic()
    }

    // MARK: - ACTIONS
    @IBAction func closeBtnAction(_ sender: UIButton) {
        sender.touchAnimation()
        navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func musicBtnAction(_ sender: UIButton) {
        MusicManager.sharedInstance.changeMusicState(clicked: sender)
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
                                      message: "It seems we're having trouble with some ghosts.",
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
