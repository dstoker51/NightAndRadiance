//TODO: Get rid of this

struct Strikables: Strikeable {
    private var objects: [Strikeable] = []

    public init() {
        objects = []
    }

    public init(strikeableObject: Strikeable) {
        add(strikeableObject: strikeableObject)
    }

    public mutating func clear() {
        objects.removeAll()
    }

    public mutating func add(strikeableObject: Strikeable) {
        objects.append(strikeableObject)
    }

    func hit(ray: Ray, tMin: Double, tMax: Double, record: inout StrikeRecord) -> Bool {
        var temporaryRecord = StrikeRecord()
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
