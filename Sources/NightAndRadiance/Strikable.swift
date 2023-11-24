struct StrikeRecord {
    public var point: Point
    public var normal: Vector
    public var t: Double = Double.nan
    public var frontFace: Bool = false

    public init() {
        self.point = Point(Double.nan, Double.nan, Double.nan)
        self.normal = Vector(point: self.point)
        self.t = Double.nan
        self.frontFace = false
    }

    public init(point: Point, normal: Vector, t: Double, frontFace: Bool) {
        self.point = point
        self.normal = normal
        self.t = t
        self.frontFace = frontFace
    }

    @inlinable
    mutating func setFaceNormal(ray: Ray, outwardNormal: Vector) {
        frontFace = ray.directionVector.dot(outwardNormal) < 0
        normal = frontFace ? outwardNormal : outwardNormal * -1.0
    }
}

protocol Strikeable {
    func hit(ray: Ray, tMin: Double, tMax: Double, record: inout StrikeRecord) -> Bool
}
