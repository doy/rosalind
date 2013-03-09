use core::io::{stdin,Reader,ReaderUtil};
use str = core::str;

const EOF: char = -1 as char;

struct FASTAReader {
    in:              Reader,
    priv mut peeked: char,
}

impl FASTAReader {
    static fn new() -> FASTAReader {
        FASTAReader { in: stdin(), peeked: EOF }
    }

    priv fn read_line(&self) -> ~str {
        let mut line = self.in.read_line();
        if self.peeked != '>' {
            str::unshift_char(&mut line, self.peeked);
        }
        self.peeked = self.in.read_char();
        line
    }

    priv fn read_sequence(&self) -> (~str, ~str) {
        if self.peeked == EOF {
            self.peeked = self.in.read_char();
        }

        let name = self.read_line();
        let mut dna = ~"";
        while !self.in.eof() && self.peeked != '>' {
            let line = self.read_line();
            str::push_str(&mut dna, line);
        }
        (name, dna)
    }

    fn each_sequence(&self, cb: fn(~str, ~str) -> bool) {
        while !self.in.eof() {
            let (name, dna) = self.read_sequence();
            cb(name, dna);
        }
    }
}
