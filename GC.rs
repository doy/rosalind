extern mod rosalind;
use rosalind::dna::gc_content;
use rosalind::fasta::FASTAReader;

fn main() {
    let mut reader = FASTAReader::new();
    let mut (max_name, max_gc) = (~"", -1f);
    for reader.each_sequence |name, dna| {
        let gc_content = gc_content(dna);
        if gc_content > max_gc {
            max_gc = gc_content;
            max_name = name;
        }
    }
    io::println(max_name);
    io::println(fmt!("%.6f", max_gc * 100f));
}
