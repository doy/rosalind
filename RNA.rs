use io::{stdin,stdout,ReaderUtil,WriterUtil};

extern mod rosalind;
use rosalind::dna::transcribe;

fn main() {
    let stdout = stdout();
    for stdin().each_char() |ch| {
        // each_char returning -1 here is a bug
        if (ch == '\n' || ch == (-1 as char)) {
            stdout.write_char('\n');
            return;
        }
        stdout.write_char(transcribe(ch));
    }
}
