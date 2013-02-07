import io._

def countNucleotides (dna: Stream[Char]): List[Int] = {
  var a, c, g, t = 0
  for (base <- dna) {
    base match {
      case 'A'  => a += 1
      case 'C'  => c += 1
      case 'G'  => g += 1
      case 'T'  => t += 1
      case c    => println("Unknown character: " + c)
    }
  }
  List(a, c, g, t)
}

val dna = Source.fromInputStream(System.in).toStream.takeWhile(_ != '\n')
println(countNucleotides(dna).mkString(" "))
