import Foundation
import SceneKit
import PlaygroundSupport

public class MainView: SCNView {
    public var scene1 = SCNScene()
    var cameraNode: SCNNode?
    var guideView: UIView?
    var tapView : UIView?
    var buttonTappedCount = 0 {
        didSet {
            switch buttonTappedCount {
            case 0:
                button.setTitle("Move to Mars", for: .normal)
            case 1:
                buttonLeft.setTitle("Move to Mercury", for: .normal)
                button.setTitle("Move to Venus", for: .normal)
            case 2:
                buttonLeft.setTitle("Move to Mars", for: .normal)
                button.setTitle("Move to Earth", for: .normal)
            case 3:
                buttonLeft.setTitle("Move to Venus", for: .normal)
                button.setTitle("Move to Neptune", for: .normal)
            case 4:
                 buttonLeft.setTitle("Move to Earth", for: .normal)
                 button.setTitle("Move to Uranus", for: .normal)
            case 5:
                button.setTitle("Move to Saturn", for: .normal)
                buttonLeft.setTitle("Move to Neptune", for: .normal)
            case 6:
                buttonLeft.setTitle("Move to Uranus", for: .normal)
                button.setTitle("Move to Jupiter", for: .normal)
            case 7:
                buttonLeft.setTitle("Move to Saturn", for: .normal)
            default:
                break
            }
        }
    }
    let button = UIButton(frame: CGRect(x: 300, y: 400, width: 150, height: 50))
    let buttonLeft = UIButton(frame: CGRect(x: 50, y: 400, width: 150, height: 50))
    
    public override init(frame: CGRect,
   options: [String : Any]? = nil) {
        super.init(frame:frame,options: options)
        //размутитьб
        let stars = SCNParticleSystem(named: "StarsParticles.scnp", inDirectory: nil)!
        scene1.rootNode.addParticleSystem(stars)
        
        createLight()
        cameraNode = createCamera()
        scene1.rootNode.addChildNode(cameraNode!)
        self.scene = scene1
        self.showsStatistics = true
        self.backgroundColor = UIColor.black
        self.allowsCameraControl = false
        self.defaultCameraController.inertiaEnabled = true
        createPlanet()
        createLeft()
        createRight()
        createTapView()
        button.addTarget(self, action: #selector(actionRigth), for: .touchUpInside)
        buttonLeft.addTarget(self, action: #selector(actionLeft), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(setEnable), name: Notification.Name("setEnable"), object: nil)
        
        guideView = GuideView(frame: CGRect(x: 125, y: 150, width: 250, height: 100))
        self.addSubview(guideView!)
        guideView?.transform = CGAffineTransform(translationX: 750, y: 0)
        setDisabled()
        startGuide()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startGuide() {
        UIView.animate(withDuration: 1.0, delay: 1.5, options: .curveEaseOut, animations: {
            self.guideView!.transform = .identity
        }, completion: nil)

        
    }
    
    @objc func setEnable() {
        
        button.isEnabled = true
        buttonLeft.isEnabled = true
        tapView?.isUserInteractionEnabled = true
    }
    
     func setDisabled() {
        button.isEnabled = false
        buttonLeft.isEnabled = false
        tapView?.isUserInteractionEnabled = false
    }
    
    func createLight() {
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 0, z: 150)
        scene1.rootNode.addChildNode(lightNode)
    }
    
    func createCamera() -> SCNNode {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 2)
        return cameraNode
    }
    
    func createPlanet() {
        let mercury = PlanetNode()
        mercury.makePlanet(planet: .mercury)
        scene1.rootNode.addChildNode(mercury)

        let mars = PlanetNode()
        mars.makePlanet(planet: .mars)
        scene1.rootNode.addChildNode(mars)

        let venus = PlanetNode()
        venus.makePlanet(planet: .venus)
        scene1.rootNode.addChildNode(venus)

        let earth = PlanetNode()
        earth.makePlanet(planet: .earth)
        scene1.rootNode.addChildNode(earth)

        let neptune = PlanetNode()
        neptune.makePlanet(planet: .neprune)
        scene1.rootNode.addChildNode(neptune)

        let uranus = PlanetNode()
        uranus.makePlanet(planet: .uranus)
        scene1.rootNode.addChildNode(uranus)

        let saturn = PlanetNode()
        saturn.makePlanet(planet: .saturn)
        scene1.rootNode.addChildNode(saturn)

        let jupiter = PlanetNode()
        jupiter.makePlanet(planet: .jupier)
        scene1.rootNode.addChildNode(jupiter)
    }
    
    func createTapView() {
        tapView = UIView(frame: CGRect(x: 100, y: 100, width: 300, height: 300))
        tapView?.backgroundColor = .clear
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapView?.addGestureRecognizer(tap)
        guard let taptap = tapView else { return }
        self.addSubview(taptap)
    }
    
   @objc func handleTap() {
        setDisabled()
        self.addSubview(CardView(planet:buttonTappedCount))
    }
    
    func createRight() {
        button.backgroundColor = .white
        button.layer.cornerRadius = 25.0
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Move to Mars", for: .normal)
        self.addSubview(button)
    }
    
    func createLeft() {
        buttonLeft.backgroundColor = .white
        buttonLeft.layer.cornerRadius = 25.0
        buttonLeft.setTitleColor(.black, for: .normal)
        buttonLeft.setTitle("Move to Jupiter", for: .normal)
        buttonLeft.isHidden = true
        self.addSubview(buttonLeft)
    }
    
    @objc func actionRigth() {
        var moveForvard: SCNAction?
            switch buttonTappedCount {
            case 0:
                //марс
                moveForvard = SCNAction.move(to: SCNVector3(1.25, 0, 3), duration: 1.0)
                buttonTappedCount += 1
                buttonLeft.isHidden = false
            case 1:
                //венера
                moveForvard = SCNAction.move(to: SCNVector3(3, 0, 4), duration: 1.0)
                buttonTappedCount += 1
            case 2:
                //земля
                moveForvard = SCNAction.move(to: SCNVector3(6, 0, 4), duration: 1.0)
                buttonTappedCount += 1
            case 3:
                //нептун
                moveForvard = SCNAction.move(to: SCNVector3(12, 0, 10), duration: 1.0)
                buttonTappedCount += 1
            case 4:
                //уран
                moveForvard = SCNAction.move(to: SCNVector3(20, 0, 20), duration: 1.0)
                buttonTappedCount += 1
            case 5:
                //сатурн
                moveForvard = SCNAction.move(to: SCNVector3(35, 0, 20), duration: 1.0)
                buttonTappedCount += 1
            case 6:
            //Юпитер
                moveForvard = SCNAction.move(to: SCNVector3(65, 0, 30), duration: 1.0)
                buttonTappedCount += 1
                button.isHidden = true
            default:
                break
            }
        cameraNode?.runAction(moveForvard!)
        }
    
    @objc func actionLeft() {
            var moveBack: SCNAction?
            switch buttonTappedCount {
            case 1:
                moveBack = SCNAction.move(to: SCNVector3(0, 0, 2), duration: 1.0)
                buttonTappedCount -= 1
                buttonLeft.isHidden = true
            case 2:
                moveBack = SCNAction.move(to: SCNVector3(1.25, 0, 3), duration: 1.0)
                buttonTappedCount -= 1
            case 3:
                moveBack = SCNAction.move(to: SCNVector3(3, 0, 4), duration: 1.0)
                buttonTappedCount -= 1
            case 4:
                moveBack = SCNAction.move(to: SCNVector3(6, 0, 4), duration: 1.0)
                buttonTappedCount -= 1
            case 5:
                moveBack = SCNAction.move(to: SCNVector3(12, 0, 10), duration: 1.0)
                buttonTappedCount -= 1
            case 6:
                moveBack = SCNAction.move(to: SCNVector3(20, 0, 20), duration: 1.0)
                buttonTappedCount -= 1
            case 7:
                moveBack = SCNAction.move(to: SCNVector3(35, 0, 20), duration: 1.0)
                buttonTappedCount -= 1
                button.isHidden = false
            default:
                break
            }
            cameraNode?.runAction(moveBack!)
    }
}
