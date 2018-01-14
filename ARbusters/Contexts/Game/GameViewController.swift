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
    @IBOutlet weak var timeLabel: UILabel!

    // MARK: - PROPERTIES
    var array = [Anchor]()
    let timer = Timer()
    var time = -1

    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTimer()

        let scene = GameScene(size: sceneView.bounds.size)
        scene.scaleMode = .resizeFill
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.controllerDelegate = self

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
        timer.invalidate()
    }

    // MARK: - TIMER

    private func setupTimer() {
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }

    @objc private func updateTime() {
        time+=1
        timeLabel.text = String(time)
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

extension GameViewController: GameSceneProtocol {

    func createdAnchor(anchor: Anchor) {
        array.append(anchor)
    }

    func userPickedBuff(anchor: Anchor) {
        guard let indexKilledAnchor = array.index(of: anchor) else { return }
        array.remove(at: indexKilledAnchor)
    }

    func userDidKill(anchor: Anchor) {
        guard let indexKilledAnchor = array.index(of: anchor) else { return }
        array.remove(at: indexKilledAnchor)

        didWin()
    }

    func userDidShotWithBuff() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: { [weak self] in
            self?.didLose()
        })
    }
}

extension GameViewController {
    
    // MARK: - GAME LOGIC
    private func didLose() {
        var boss = 0
        var buffs = 0
        for anchor in array {
            if anchor.type == NodeType.antiBossBuff {
                buffs+=1
            }

            if anchor.type == NodeType.boss {
                boss+=1
            }
        }

        if boss > buffs {
            // PERDEU
            timer.invalidate()

        }
    }

    private func didWin() {
        if array.count == 0 {
            timer.invalidate()
            // GANHOU
        }
    }

}
