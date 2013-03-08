use io::{stdin,println,ReaderUtil};

fn count_nucleotides(dna: &str) -> (int, int, int, int) {
    let mut (a, c, g, t) = (0, 0, 0, 0);
    for str::each_char(dna) |ch| {
        match ch {
            'A' => a += 1,
            'C' => c += 1,
            'G' => g += 1,
            'T' => t += 1,
            _   => fail ~"Unexpected character found"
        }
    }
    (a, c, g, t)
}

fn count_nucleotides_2(dna: &str) -> (int, int, int, int) {
    do iter::foldl(&str::chars(dna), (0, 0, 0, 0)) |res, &ch| {
        let (a, c, g, t) = *res;
        match ch {
            'A' => (a + 1, c, g, t),
            'C' => (a, c + 1, g, t),
            'G' => (a, c, g + 1, t),
            'T' => (a, c, g, t + 1),
            _   => fail ~"Unexpected character found"
        }
    }
}

fn main() {
    let dna = stdin().read_line();
    let (a, c, g, t) = count_nucleotides(dna);
    /*let (a, c, g, t) = count_nucleotides_2(dna);*/
    println(fmt!("%d %d %d %d", a, c, g, t));
}
