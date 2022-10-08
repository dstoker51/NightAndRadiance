struct HitRecord {
    public var point: Point3D
    public var normal: Vector4D
    public var t: Double = Double.nan
    public var frontFace: Bool = false

    public init() {
        self.point = Point3D(Double.nan, Double.nan, Double.nan)
        self.normal = Vector4D(point: self.point)
        self.t = Double.nan
        self.frontFace = false
    }

    public init(point: Point3D, normal: Vector4D, t: Double, frontFace: Bool) {
        self.point = point
        self.normal = normal
        self.t = t
        self.frontFace = frontFace
    }

    @inlinable
    mutating func setFaceNormal(ray: Ray, outwardNormal: Vector4D) {
        frontFace = ray.directionVector.dot(outwardNormal) < 0
        normal = frontFace ? outwardNormal : outwardNormal * -1.0
    }
}

protocol Hittable {
    func hit(ray: Ray, tMin: Double, tMax: Double, record: inout HitRecord) -> Bool
}