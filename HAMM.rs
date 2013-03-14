extern mod rosalind;
use rosalind::io::input_line;
use rosalind::str::hamming;

fn main() {
    let dna1 = input_line();
    let dna2 = input_line();
    fail_unless!(str::len(dna1) == str::len(dna2));

    io::println(fmt!("%d", hamming(dna1, dna2)));
}
