use core::io::{stdin,Reader,ReaderUtil};
use str = core::str;

const EOF: char = -1 as char;

struct FASTAReader {
    in:          Reader,
    priv peeked: char,
}

impl FASTAReader {
    static fn new() -> FASTAReader {
        FASTAReader { in: stdin(), peeked: EOF }
    }

    fn read_line(&mut self) -> ~str {
        let mut line = self.in.read_line();
        if self.peeked != '>' {
            str::unshift_char(&mut line, self.peeked);
        }
        self.peeked = self.in.read_char();
        line
    }

    fn read_sequence(&mut self) -> (~str, ~str) {
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

    pub fn each_sequence(&mut self, cb: &fn(~str, ~str) -> bool) {
        while !self.in.eof() {
            let (name, dna) = self.read_sequence();
            cb(name, dna);
        }
    }

    pub fn sequences(&mut self) -> (~[~str], ~[~str]) {
        let mut names = ~[];
        let mut dnas  = ~[];
        for self.each_sequence |name, dna| {
            names.push(name);
            dnas.push(dna);
        }
        (names, dnas)
    }
}
