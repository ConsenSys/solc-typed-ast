export function forAll<T>(arr: Iterable<T> | Set<T>, cb: (arg0: T) => boolean): boolean {
    for (const el of arr) {
        if (!cb(el)) {
            return false;
        }
    }

    return true;
}

export function assert(condition: boolean, message: string): asserts condition {
    if (condition) {
        return;
    }

    throw new Error(message);
}
