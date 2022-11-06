//
//  ContentView.swift
//  Hello3D
//
//  Created by Wouter Verweirder on 05/11/2022.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    
    static func createScene() -> SCNScene? {
        let scene = SCNScene(named: "Room.scn")
        if let plane = scene?.rootNode.childNode(withName: "MonitorPlane", recursively: false) {
            let material = SCNMaterial()
            let program = SCNProgram()
            program.vertexFunctionName = "monitorShaderVertex"
            program.fragmentFunctionName = "monitorShaderFragment"
            material.program = program
            plane.geometry?.firstMaterial = material
        }
        return scene
    }
    
    let scene = createScene()
    
    var cameraNode: SCNNode? {
        scene?.rootNode.childNode(withName: "camera", recursively: false)
    }
    
    var body: some View {
        VStack {
            Text("My Room")
                .font(.largeTitle)
                .padding()
            SceneView(
                scene: scene,
                pointOfView: cameraNode,
                options: [
                    .allowsCameraControl,
                    .rendersContinuously
                ]
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
