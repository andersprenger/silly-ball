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
    private var motionManager = CMMotionManager()
    private var updateRate: Double = 1/60
    private var floorCategoryBitMask: UInt32 = 1 << 0
    
    //private var node : SKShapeNode?
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 6.8)
        
        setBoundariesPhysics()
        
        var ballNode: SKShapeNode = SKShapeNode(circleOfRadius: 20)
        ballNode.name = "node"
        ballNode.zPosition = 0
        ballNode.fillColor = .red
        ballNode.position = CGPoint(x: ((self.scene?.size.width)!) / 2, y: ((self.scene?.size.height)!) / 2)
        ballNode.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        // node1.physicsBody?.isDynamic = false
        addChild(ballNode)
    }
    
    func setBoundariesPhysics() {
        // Sky creation
        let sky = SKSpriteNode(color: .red, size: CGSize(width: (self.scene?.size.width)!, height: 1.0))
        sky.name = "Sky"
        sky.position = CGPoint(x: ((self.scene?.size.width)!) / 2, y: (self.scene?.size.height)!)
        sky.zPosition = 0
        
        // Sky Physics
        let floorPhysicsBody = SKPhysicsBody(rectangleOf: sky.frame.size)
        floorPhysicsBody.isDynamic = false
        floorPhysicsBody.categoryBitMask = floorCategoryBitMask
        floorPhysicsBody.contactTestBitMask = 00000100
        sky.physicsBody = floorPhysicsBody
        
        
        // Floor creation
        let floor = SKSpriteNode(color: .red, size: CGSize(width: (self.scene?.size.width)!, height: 10.0))
        floor.name = "Floor"
        floor.position = CGPoint(x: ((self.scene?.size.width)!) / 2, y: 0)
        floor.zPosition = 0
        
        // Floor Physics
        let skyPhysicsBody = SKPhysicsBody(rectangleOf: floor.frame.size)
        skyPhysicsBody.isDynamic = false
        floor.physicsBody = skyPhysicsBody
        
        // Left creation
        let left = SKSpriteNode(color: .red, size: CGSize(width: 10.0, height: (self.scene?.size.height)!))
        left.name = "aaaaa"
        left.position = CGPoint(x: 0, y: (self.scene?.size.height)! / 2)
        left.zPosition = 0

        // Left Physics
        let leftPhysicsBody = SKPhysicsBody(rectangleOf: left.frame.size)
        leftPhysicsBody.isDynamic = false
        left.physicsBody = leftPhysicsBody

        // Right creation
        let right = SKSpriteNode(color: .red, size: CGSize(width: 10.0, height: (self.scene?.size.height)!))
        right.name = "bbbbb"
        right.position = CGPoint(x: ((self.scene?.size.width)!), y: (self.scene?.size.height)! / 2)
        right.zPosition = 0

        // Right Physics
        let rightPhysicsBody = SKPhysicsBody(rectangleOf: left.frame.size)
        rightPhysicsBody.isDynamic = false
        right.physicsBody = rightPhysicsBody
        
        addChild(sky)
        addChild(floor)
        addChild(left)
        addChild(right)
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
        if motionManager.isDeviceMotionAvailable{
            motionManager.deviceMotionUpdateInterval = updateRate
            motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical, to: .main){ (data, error) in
                guard let gravityData = data?.gravity else { return }
                
                self.physicsWorld.gravity = CGVector(dx: gravityData.x, dy: gravityData.y)
                
            }
        }
    }
}
