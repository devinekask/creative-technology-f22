import * as THREE from 'three'
import { GLTFLoader } from 'three/addons/loaders/GLTFLoader.js';
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js'

import portalVertexShader from './shaders/portal/vertex.glsl?raw'
import portalFragmentShader from './shaders/portal/fragment.glsl?raw'

const canvas = document.querySelector('canvas.webgl')
const scene = new THREE.Scene()

const size = {
  width: window.innerWidth,
  height: window.innerHeight
}

const camera = new THREE.PerspectiveCamera(45, size.width / size.height, 0.1, 100)
camera.position.x = 14
camera.position.y = 15
camera.position.z = 12
scene.add(camera)

const controls = new OrbitControls(camera, canvas)
controls.enableDamping = true

const renderer = new THREE.WebGLRenderer({
  canvas: canvas,
  antialias: true
})
renderer.setSize(size.width, size.height)
renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))

const texture = new THREE.TextureLoader().load( 'assets/baked.jpg' )
texture.flipY = -1
const material = new THREE.MeshBasicMaterial({ map: texture })

const monitorPlaneMaterial = new THREE.ShaderMaterial({
  uniforms: {
    uTime: { value: 0 },
    uColorStart: { value: new THREE.Color('#ff0000') },
    uColorEnd: { value: new THREE.Color('#0000ff') },
  },
  vertexShader: portalVertexShader,
  fragmentShader: portalFragmentShader
})

const loader = new GLTFLoader();
loader.load(
	// resource URL
	'assets/Room.glb',
	// called when the resource is loaded
	( gltf ) => {
    gltf.scene.traverse(child => {
      if (child.name === "Monitor_Plane") {
        child.material = monitorPlaneMaterial;
      } else {
        child.material = material;
      }
    })
    scene.add(gltf.scene)
  }
);

const clock = new THREE.Clock()
const draw = () => {
  const elapsedTime = clock.getElapsedTime()
  monitorPlaneMaterial.uniforms.uTime.value = elapsedTime
  renderer.render(scene, camera)
  window.requestAnimationFrame(draw)
}

window.addEventListener('resize', () => {
  // Update size
  size.width = window.innerWidth
  size.height = window.innerHeight

  // Update camera
  camera.aspect = size.width / size.height
  camera.updateProjectionMatrix()

  // Update renderer
  renderer.setSize(size.width, size.height)
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))
})

draw()