extern mod rosalind;
use rosalind::io::input_line;

fn substrings(haystack: &str, needle: &str) -> ~[uint] {
    let mut indices = ~[];
    do str::find_str(haystack, needle).while_some |start| {
        indices.push(start + 1);
        str::find_str_from(haystack, needle, start + 1)
    }
    indices
}

fn main() {
    let haystack = input_line();
    let needle   = input_line();

    let indices = substrings(haystack, needle);

    io::println(str::connect(indices.map(|i| fmt!("%u", *i)), " "))
}
