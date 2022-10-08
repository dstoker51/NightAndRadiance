struct Hittables: Hittable {
    private var objects: [Hittable] = []

    public init() {
        objects = []
    }

    public init(hittableObject: Hittable) {
        add(hittableObject: hittableObject)
    }

    public mutating func clear() {
        objects.removeAll()
    }

    public mutating func add(hittableObject: Hittable) {
        objects.append(hittableObject)
    }

    func hit(ray: Ray, tMin: Double, tMax: Double, record: inout HitRecord) -> Bool {
        var temporaryRecord = HitRecord()
        var hitAnything = false
        var closestSoFar = tMax

        for object in objects {
            if object.hit(ray: ray, tMin: tMin, tMax: closestSoFar, record: &temporaryRecord) {
                hitAnything = true
                closestSoFar = temporaryRecord.t
                record = temporaryRecord
            }
        }

        return hitAnything
    }
}
