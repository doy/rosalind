use io::{stdin,println,ReaderUtil};

fn main() {
    let dna1 = stdin().read_line();
    let dna2 = stdin().read_line();
    assert str::len(dna1) == str::len(dna2);

    let mut hamming = 0;
    for str::each_chari(dna1) |i, ch| {
        if ch != str::char_at(dna2, i) {
            hamming += 1;
        }
    }

    println(fmt!("%d", hamming));
}
