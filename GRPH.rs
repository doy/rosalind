use core::str::{len,view};

extern mod rosalind;
use rosalind::fasta::FASTAReader;

fn main() {
    let mut dna: ~[(~str, ~str)] = ~[];
    let mut reader = FASTAReader::new();
    for reader.each_sequence |cur_name, cur_seq| {
        let cur_len = len(cur_seq);
        for dna.each |&(prev_name, prev_seq)| {
            let prev_len = len(prev_seq);
            if view(cur_seq, 0, 3) == view(prev_seq, prev_len - 3, prev_len) {
                io::println(fmt!("%s %s", prev_name, cur_name));
            }
            if view(prev_seq, 0, 3) == view(cur_seq, cur_len - 3, cur_len) {
                io::println(fmt!("%s %s", cur_name, prev_name));
            }
        }
        dna.push((cur_name, cur_seq));
    }
}
