use io::{stdin,println,ReaderUtil};

/* really feels like there should be a more efficient way to do this */
fn reverse(s: &str) -> ~str {
    let mut r = ~"";
    str::reserve(&mut r, str::len(s));
    for str::each_char(s) |ch| {
        str::unshift_char(&mut r, ch)
    }
    r
}

fn complement(ch: char) -> char {
    match ch {
        'A' => 'T',
        'C' => 'G',
        'G' => 'C',
        'T' => 'A',
        _   => fail ~"Unknown character found",
    }
}

fn main() {
    let dna = stdin().read_line();
    println(str::map(reverse(dna), complement));
}
