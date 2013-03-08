use io::{println,stdin,Reader,ReaderUtil};
use str::{push_str,unshift_char,each_char,len};

const EOF: char = -1 as char;

struct FASTAReader {
    in:              Reader,
    priv mut peeked: char,
}

impl FASTAReader {
    static fn new() -> FASTAReader {
        FASTAReader { in: stdin(), peeked: EOF }
    }

    fn read_line(&self) -> ~str {
        let mut line = self.in.read_line();
        if self.peeked != '>' {
            unshift_char(&mut line, self.peeked);
        }
        self.peeked = self.in.read_char();
        line
    }

    fn read_sequence(&self) -> (~str, ~str) {
        if self.peeked == EOF {
            self.peeked = self.in.read_char();
        }

        let name = self.read_line();
        let mut dna = ~"";
        while !self.in.eof() && self.peeked != '>' {
            let line = self.read_line();
            push_str(&mut dna, line);
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

pure fn gc_content(dna: ~str) -> float {
    let mut content = 0;
    for each_char(dna) |ch| {
        match ch {
            'C' | 'G' => content += 1,
            _         => (),
        }
    }
    (content as float) / (len(dna) as float)
}

fn main() {
    let reader = FASTAReader::new();
    let mut (max_name, max_gc) = (~"", -1f);
    for reader.each_sequence |name, dna| {
        let gc_content = gc_content(dna);
        if gc_content > max_gc {
            max_gc = gc_content;
            max_name = name;
        }
    }
    println(max_name);
    println(fmt!("%.6f", max_gc * 100f));
}
