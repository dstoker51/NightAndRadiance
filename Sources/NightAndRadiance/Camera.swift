struct Camera {
    private var origin: Point3D
    private var lowerLeftCorner: Point3D
    private var horizontal: Vector4D
    private var vertical: Vector4D

    public init() {
        let aspectRatio = 16.0 / 9.0
        let viewportHeight = 2.0
        let viewportWidth = aspectRatio * viewportHeight
        let focalLength = 1.0

        origin = Point3D(0.0, 0.0, 0.0)
        horizontal = Vector4D(x: viewportWidth, y: 0.0, z: 0.0)
        vertical = Vector4D(x: 0.0, y: viewportHeight, z: 0.0)
        lowerLeftCorner = origin - horizontal * 0.5 - vertical * 0.5 - Vector4D(x: 0, y: 0.0, z: focalLength)
    }

    public func getRay(u: Double, v: Double) -> Ray {
        Ray(emissionPoint: origin, directionVector: lowerLeftCorner + horizontal * u + vertical * v - origin)
    }
}