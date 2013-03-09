extern mod rosalind;
use rosalind::io::input_line;
use rosalind::protein::translate;

fn main() {
    let rna = input_line();
    io::println(translate(rna));
}
