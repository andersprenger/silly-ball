//
//  GameScene.swift
//  silly-ball
//
//  Created by Anderson Sprenger on 02/12/21.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // imput helper vars
    var motionManager = CMMotionManager()
    var updateRate: Double = 1/60
    var yaw: Double = 0
    private var floorCategoryBitMask: UInt32 = 1 << 0

    
    //private var node : SKShapeNode?
    
    func startControl() {
        if motionManager.isDeviceMotionAvailable{
            motionManager.deviceMotionUpdateInterval = updateRate
            motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical, to: .main){ (data, error) in
                guard let validData = data else{return}
                
                self.yaw = validData.attitude.pitch*58
            }
        }
    }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 6.8)
        
        setBoundariesPhysics()
        
        var node1: SKShapeNode = SKShapeNode(circleOfRadius: 20)
        node1.name = "node"
        node1.zPosition = 0
        node1.fillColor = .red
        node1.position = CGPoint(x: ((self.scene?.size.width)!) / 2, y: ((self.scene?.size.height)!) / 2)
        node1.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        // node1.physicsBody?.isDynamic = false
        addChild(node1)
    }
    
    func setBoundariesPhysics() {
            
            // Floor creation
            let sky = SKSpriteNode(color: .red, size: CGSize(width: (self.scene?.size.width)!, height: 1.0))
            sky.name = "Floor"
            sky.position = CGPoint(x: ((self.scene?.size.width)!) / 2, y: (self.scene?.size.height)!)
            sky.zPosition = 0
            
            // Floor Physics
            let floorPhysicsBody = SKPhysicsBody(rectangleOf: sky.frame.size)
            floorPhysicsBody.isDynamic = false
            floorPhysicsBody.categoryBitMask = floorCategoryBitMask
            floorPhysicsBody.contactTestBitMask = 00000100
            sky.physicsBody = floorPhysicsBody
            
            
            // Sky creation
            let floor = SKSpriteNode(color: .red, size: CGSize(width: (self.scene?.size.width)!, height: 10.0))
            floor.name = "Sky"
            floor.position = CGPoint(x: ((self.scene?.size.width)!) / 2, y: 0)
            floor.zPosition = 0
            
            // Sky Physics
            let skyPhysicsBody = SKPhysicsBody(rectangleOf: floor.frame.size)
            skyPhysicsBody.isDynamic = false
            floor.physicsBody = skyPhysicsBody
            
            addChild(sky)
            addChild(floor)
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
