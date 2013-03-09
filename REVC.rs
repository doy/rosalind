extern mod rosalind;
use rosalind::dna::complement;
use rosalind::io::input_line;
use rosalind::str::reverse;

fn main() {
    let dna = input_line();
    io::println(str::map(reverse(dna), complement));
}
