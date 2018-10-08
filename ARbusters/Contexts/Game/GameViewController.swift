//
//  GameViewController.swift
//  ARbusters
//
//  Created by Pedro Carrasco on 10/01/18.
//  Copyright © 2018 Pedro Carrasco. All rights reserved.
//

import ARKit

// MARK: - GameViewController
class GameViewController: UIViewController {
    
    // MARK: Constants
    private enum Constant {
        static let anchorPoint = CGPoint(x: 0.5, y: 0.5)
        static let timeTransitionDuration = 0.33
    }
    
    // MARK: Outlets
    @IBOutlet private var sceneView: ARSKView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var timeUnitLabel: UILabel!
    @IBOutlet private weak var sightImageView: UIImageView!
    
    // MARK: Properties
    var anchorsArray = [Anchor]()
    var timer = Timer()
    var time = 0
    var wonGame = false
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
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
}

// MARK: - Navigation
extension GameViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ResultViewController.name {
            guard let resultViewController = segue.destination as? ResultViewController else { return }
            resultViewController.didWin = wonGame
            resultViewController.timeTook = time
        }
    }
}

// MARK: - ARSKViewDelegate
extension GameViewController: ARSKViewDelegate {
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        guard let anchor = anchor as? Anchor, let type = anchor.type else { return nil }
        
        let node = type.asSprite()
        node.name = type.rawValue
        
        return node
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        
        guard let configuration = session.configuration else { return }
        
        sceneView.session.run(configuration, options: [.resetTracking,.removeExistingAnchors])
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        timer.invalidate()
        self.presentAlert()
    }
}

// MARK: - GameSceneProtocol
extension GameViewController: GameSceneProtocol {
    
    func gameScene(gameScene: GameScene, created anchor: Anchor) {
        anchorsArray.append(anchor)
    }
    
    func gameScene(gameScene: GameScene, killed anchor: Anchor) {
        guard let indexKilledAnchor = anchorsArray.index(of: anchor) else { return }
        
        anchorsArray.remove(at: indexKilledAnchor)
        didUserWin()
    }
    
    func gameScene(gameScene: GameScene, picked buff: Anchor) {
        guard let indexBuff = anchorsArray.index(of: buff) else { return }
        anchorsArray.remove(at: indexBuff)
    }
    
    func gameSceneDidShotWithBuff(gameScene: GameScene) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: { [weak self] in
            self?.didUserLose()
        })
    }
}

// MARK: - Alertable
extension GameViewController: Alertable {}

// MARK: - Configuration
private extension GameViewController {
    
    func configure() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                     selector: #selector(updateTime),
                                     userInfo: nil, repeats: true)
        timeUnitLabel.text = StringKey.General.seconds.localizedString
        
        configureScene()
    }
    
    func configureScene() {
        let scene = GameScene(size: sceneView.bounds.size)
        scene.scaleMode = .resizeFill
        scene.anchorPoint = Constant.anchorPoint
        scene.controllerDelegate = self
        
        sceneView.delegate = self
        sceneView.presentScene(scene)
    }
}

// MARK: - Game Logic
private extension GameViewController {
    
    @objc private func updateTime() {
        time+=1
        timeLabel.text = String(time)
        UIView.transition(with: timeLabel, duration: Constant.timeTransitionDuration, options: .transitionFlipFromTop, animations: nil, completion: nil)
    }
    
    private func didUserLose() {
        var boss = 0
        var buffs = 0
        for anchor in anchorsArray {
            if anchor.type == NodeType.antiBossBuff {
                buffs+=1
            }
            
            if anchor.type == NodeType.boss {
                boss+=1
            }
        }
        
        if boss > buffs {
            timer.invalidate()
            performSegue(withIdentifier: ResultViewController.name, sender: self)
        }
    }
    
    private func didUserWin() {
        if anchorsArray.count == 0 {
            timer.invalidate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
                self?.wonGame = true
                self?.performSegue(withIdentifier: ResultViewController.name, sender: self)
            })
        }
    }
}

// MARK: - Actions
private extension GameViewController {
    
    @IBAction func closeBtnAction(_ sender: UIButton) {
        sender.touchAnimation()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func musicBtnAction(_ sender: UIButton) {
        MusicManager.sharedInstance.changeMusicState(clicked: sender)
    }
}
