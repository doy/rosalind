use str = core::str;

const STOP: char = -1 as char;

fn translate(rna: &str) -> ~str {
    assert str::len(rna) % 3 == 0;

    let codons = str::len(rna) / 3;
    let mut protein = str::with_capacity(codons);

    for uint::range(0, codons) |i| {
        let codon = str::view(rna, i * 3, i * 3 + 3);
        let amino = translate_single(codon);
        if (amino == STOP) {
            break;
        }
        str::push_char(&mut protein, amino);
    }

    protein
}

priv fn translate_single(codon: &str) -> char {
    assert str::len(codon) == 3;
    match codon {
        "UUU" => 'F',     "CUU" => 'L',      "AUU" => 'I',      "GUU" => 'V',
        "UUC" => 'F',     "CUC" => 'L',      "AUC" => 'I',      "GUC" => 'V',
        "UUA" => 'L',     "CUA" => 'L',      "AUA" => 'I',      "GUA" => 'V',
        "UUG" => 'L',     "CUG" => 'L',      "AUG" => 'M',      "GUG" => 'V',
        "UCU" => 'S',     "CCU" => 'P',      "ACU" => 'T',      "GCU" => 'A',
        "UCC" => 'S',     "CCC" => 'P',      "ACC" => 'T',      "GCC" => 'A',
        "UCA" => 'S',     "CCA" => 'P',      "ACA" => 'T',      "GCA" => 'A',
        "UCG" => 'S',     "CCG" => 'P',      "ACG" => 'T',      "GCG" => 'A',
        "UAU" => 'Y',     "CAU" => 'H',      "AAU" => 'N',      "GAU" => 'D',
        "UAC" => 'Y',     "CAC" => 'H',      "AAC" => 'N',      "GAC" => 'D',
        "UAA" => STOP,    "CAA" => 'Q',      "AAA" => 'K',      "GAA" => 'E',
        "UAG" => STOP,    "CAG" => 'Q',      "AAG" => 'K',      "GAG" => 'E',
        "UGU" => 'C',     "CGU" => 'R',      "AGU" => 'S',      "GGU" => 'G',
        "UGC" => 'C',     "CGC" => 'R',      "AGC" => 'S',      "GGC" => 'G',
        "UGA" => STOP,    "CGA" => 'R',      "AGA" => 'R',      "GGA" => 'G',
        "UGG" => 'W',     "CGG" => 'R',      "AGG" => 'R',      "GGG" => 'G',
        _ => fail ~"Unknown codon",
    }
}
