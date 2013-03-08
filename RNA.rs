use io::{stdin,stdout,ReaderUtil,WriterUtil};

fn main() {
    let stdout = stdout();
    for stdin().each_char() |ch| {
        match ch {
            'T' =>  { stdout.write_char('U')        }
            '\n' => { stdout.write_char(ch); return }
            _   =>  { stdout.write_char(ch)         }
        }
    }
}
