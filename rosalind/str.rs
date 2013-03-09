use str = core::str;

/* really feels like there should be a more efficient way to do this */
fn reverse(s: &str) -> ~str {
    let mut r = ~"";
    str::reserve(&mut r, str::len(s));
    for str::each_char(s) |ch| {
        str::unshift_char(&mut r, ch)
    }
    r
}

pure fn hamming(string1: ~str, string2: ~str) -> int {
    let mut hamming = 0;
    for str::each_chari(string1) |i, ch| {
        if ch != str::char_at(string2, i) {
            hamming += 1;
        }
    }
    hamming
}
