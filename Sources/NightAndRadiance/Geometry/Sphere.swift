struct Sphere: Strikeable {
    public var center = Point(0.0, 0.0, 0.0)
    public var radius = 0.0

    init(center: Point, radius: Double) {
        self.center = center
        self.radius = radius
    }

    func hit(ray: Ray, tMin: Double, tMax: Double, record: inout StrikeRecord) -> Bool {
        let oc = ray.emissionPoint - center
        let a = ray.directionVector.magnitude * ray.directionVector.magnitude
        let halfB = oc.dot(ray.directionVector)
        let c = oc.magnitude * oc.magnitude - radius * radius

        let discriminant = halfB * halfB - a * c
        if discriminant < 0 {
            return false
        }
        let sqrtD = discriminant.squareRoot()

        // Find the nearest root lies in the acceptable range
        var root = (-halfB - sqrtD) / a
        if root < tMin || tMax < root {
            root = (-halfB + sqrtD) / a
            if root < tMin || tMax < root {
                return false
            }
        }

        record.t = root
        record.point = ray.at(t: record.t)
        let outwardNormal = (record.point - center) / radius
        record.setFaceNormal(ray: ray, outwardNormal: outwardNormal)

        return true
    }
}
