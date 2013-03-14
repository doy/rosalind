use str = core::str;

fn gc_content(dna: &str) -> float {
    let mut content = 0;
    for str::each_char(dna) |ch| {
        match ch {
            'C' | 'G' => content += 1,
            _         => (),
        }
    }
    (content as float) / (str::len(dna) as float)
}

fn complement(base: char) -> char {
    match base {
        'A' => 'T',
        'C' => 'G',
        'G' => 'C',
        'T' => 'A',
        _   => fail!(~"Unknown character found"),
    }
}

fn transcribe(base: char) -> char {
    match base {
        'T'             => 'U',
        'A' | 'C' | 'G' => base,
        _               => fail!(~"Unknown character found"),
    }
}
