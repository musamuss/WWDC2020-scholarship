import UIKit
import SceneKit
import QuartzCore   // for the basic animation
import PlaygroundSupport
import SpriteKit

public enum Planet: CaseIterable  {
    case mercury
    case mars
    case venus
    case earth
    case neprune
    case uranus
    case saturn
    case jupier
}

public class PlanetNode: SCNNode {
    public override init() {
        super.init()
    }
    
    public func makePlanet(planet:Planet) {
        let radius: CGFloat?
        let name: String
        switch planet {
        case .mercury:
            radius = 0.38
            name = "mercury"
            self.position = SCNVector3(x: 0, y: 0, z: 0)
        case .mars:
            radius = 0.53
            name = "mars"
            self.position = SCNVector3(x: 1.25, y: 0, z: 0)
        case .venus:
            radius = 0.95
            name = "venus"
            self.position = SCNVector3(x: 3, y: 0, z: 0)
        case .earth:
            radius = 1
            name = "earth"
            self.position = SCNVector3(x: 6, y: 0, z: 0)
        case .neprune:
            radius = 3.88
            name = "neptune"
            self.position = SCNVector3(x: 12, y: 0, z: 0)
        case .uranus:
            radius = 4
            name = "uranus"
            self.position = SCNVector3(x: 20, y: 0, z: 0)
        case .saturn:
            radius = 9.45
            name = "saturn"
            self.position = SCNVector3(x: 35, y: 0, z: 0)
        case .jupier:
            radius = 11.2
            name = "jupiter"
            self.position = SCNVector3(x: 65, y: 0, z: 0)
        }
        self.geometry = SCNSphere(radius: radius!)
        self.geometry?.firstMaterial?.diffuse.contents = UIImage(named:name)
        self.geometry?.firstMaterial?.shininess = 50
        let action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(x:0, y:1, z:0), duration: 8)
        let repeatAction = SCNAction.repeatForever(action)
        self.runAction(repeatAction)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
