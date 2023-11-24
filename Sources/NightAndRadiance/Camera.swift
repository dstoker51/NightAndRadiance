struct Camera {
    private var origin: Point
    private var lowerLeftCorner: Point
    private var horizontal: Vector
    private var vertical: Vector

    public init() {
        let aspectRatio = 16.0 / 9.0
        let viewportHeight = 2.0
        let viewportWidth = aspectRatio * viewportHeight
        let focalLength = 1.0

        origin = Point(0.0, 0.0, 0.0)
        horizontal = Vector(x: viewportWidth, y: 0.0, z: 0.0)
        vertical = Vector(x: 0.0, y: viewportHeight, z: 0.0)
        lowerLeftCorner = origin - horizontal * 0.5 - vertical * 0.5 - Vector(x: 0, y: 0.0, z: focalLength)
    }

    public func getRay(u: Double, v: Double) -> Ray {
        Ray(emissionPoint: origin, directionVector: lowerLeftCorner + horizontal * u + vertical * v - origin)
    }
}
