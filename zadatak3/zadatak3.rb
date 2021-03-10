class Slika
  attr_accessor :brRedaka, :brStupaca, :slika, :tockaP
  def initialize
    @boje = ["X", "."]
    @brRedaka = UnosBrojaRedaka()
    @brStupaca = UnosBrojaStupaca()
    @slika = StvoriSliku(@brRedaka, @brStupaca)
    puts "Dimenzije slike: #{brRedaka}x#{brStupaca}"
    puts ""
    PrintSlike(@slika, @brRedaka, @brStupaca)
    puts ""
    @tockaP = UnosKoordinataProizvoljneTocke(@brRedaka, @brStupaca)
    puts "Odabrana točka: P(#{@tockaP[0]}, #{@tockaP[1]})"
    @slika[@tockaP[0]][@tockaP[1]] = "P"
    PrintSlike(@slika, @brRedaka, @brStupaca)
    puts ""
    puts "Rješenje:"
    puts ""
    obojiSusjedeCrno(@slika, @brRedaka, @brStupaca, @tockaP)
  end

  def UnosBrojaRedaka
    puts "Unesite broj redaka M slike"
    brRedaka = gets.chomp!
    until ((brRedaka.to_i.to_s == brRedaka) && brRedaka.to_i > 0 )
      puts "Krivi unos, unesite broj redaka kao pozitivan cijeli broj veći od 0"
      brRedaka = gets.chomp!
    end
    brRedaka = brRedaka.to_i
    brRedaka
  end

  def UnosBrojaStupaca
    puts "Unesite broj stupaca N slike"
    brStupaca = gets.chomp!
    until ((brStupaca.to_i.to_s == brStupaca) && brStupaca.to_i > 0 )
      puts "Krivi unos, unesite broj stupaca kao pozitivan cijeli broj veći od 0"
      brStupaca = gets.chomp!
    end
    brStupaca = brStupaca.to_i
    brStupaca
  end

  def StvoriSliku(brRedaka, brStupaca)
    slika = Array.new(brRedaka) { Array.new(brStupaca) { @boje.sample } }
  end
  
  def PrintSlike (nazivSlike,brRedaka, brStupaca)
    for i in 0..brRedaka-1 do
      for j in 0..brStupaca-1 do
        print " #{nazivSlike[i][j]} "
      end
      puts ""
    end
  end
  
  def UnosKoordinataProizvoljneTocke(brRedaka, brStupaca)  
    puts "Unesite broj retka točke P"
    yP = gets.chomp!
    until ((yP.to_i.to_s == yP) && yP.to_i >= 0 && yP.to_i < brRedaka)
      puts "Krivi unos, unesite broj retka kao cijeli broj veći ili jednak od 0, a manji od broja redaka, tj. #{brRedaka}"
      yP = gets.chomp!
    end
    yP = yP.to_i
  
    puts "Unesite broj stupca točke P"
    xP = gets.chomp!
    until ((xP.to_i.to_s == xP) && xP.to_i >= 0 && xP.to_i < brStupaca)
      puts "Krivi unos, unesite broj stupca kao cijeli broj veći ili jednak od 0, a manji od broja stupaca, tj. #{brStupaca}"
      xP = gets.chomp!
    end
    xP = xP.to_i
  
    pCoords = [yP, xP]
    pCoords
  end

  def traziIznad(slika, brRedaka, brStupaca, tockaP)
    tockaPcopy = tockaP.dup 
    redakIznad = tockaPcopy[0] - 1
    if brRedaka > redakIznad && redakIznad >= 0
      if (slika[redakIznad][tockaPcopy[1]] != nil && slika[redakIznad][tockaPcopy[1]] == ".")
        slika[redakIznad][tockaPcopy[1]] = "X"
        tockaPcopy[0] = redakIznad
        traziIznad(slika, brRedaka, brStupaca, tockaPcopy)
        traziLijevo(slika, brRedaka, brStupaca, tockaP)
        traziDesno(slika, brRedaka, brStupaca, tockaP)
      end 
    end
  end
  
  def traziIspod(slika, brRedaka, brStupaca, tockaP)
    tockaPcopy = tockaP.dup 
    redakIspod = tockaPcopy[0] + 1
    if brRedaka > redakIspod 
      if (slika[redakIspod][tockaPcopy[1]] != nil && slika[redakIspod][tockaPcopy[1]] == ".")
        slika[redakIspod][tockaPcopy[1]] = "X"
        tockaPcopy[0] = redakIspod
        traziIspod(slika, brRedaka, brStupaca, tockaPcopy)
        traziLijevo(slika, brRedaka, brStupaca, tockaP)
        traziDesno(slika, brRedaka, brStupaca, tockaP)
      end 
    end
  end
  
  def traziLijevo(slika, brRedaka, brStupaca, tockaP)
    tockaPcopy = tockaP.dup 
    stupacLijevo = tockaPcopy[1] - 1
    if brStupaca > stupacLijevo && stupacLijevo >= 0
      if (slika[tockaPcopy[0]][stupacLijevo] != nil && slika[tockaPcopy[0]][stupacLijevo] == ".")
        slika[tockaPcopy[0]][stupacLijevo] = "X"
        tockaPcopy[1] = stupacLijevo
        traziLijevo(slika, brRedaka, brStupaca, tockaPcopy)
        traziIznad(slika, brRedaka, brStupaca, tockaPcopy)
        traziIspod(slika, brRedaka, brStupaca, tockaPcopy)
      end
    end
  end
  
  def traziDesno(slika, brRedaka, brStupaca, tockaP)
    tockaPcopy = tockaP.dup 
    stupacDesno = tockaPcopy[1] + 1
    if brStupaca > stupacDesno
      if (slika[tockaPcopy[0]][stupacDesno] != nil && slika[tockaPcopy[0]][stupacDesno] == ".")
        slika[tockaPcopy[0]][stupacDesno] = "X"
        tockaPcopy[1] = stupacDesno
        traziDesno(slika, brRedaka, brStupaca, tockaPcopy)
        traziIznad(slika, brRedaka, brStupaca, tockaPcopy)
        traziIspod(slika, brRedaka, brStupaca, tockaPcopy)
      end
    end
  end
  
  def obojiSusjedeCrno(slika, brRedaka, brStupaca, tockaP)
    traziIznad(slika, brRedaka, brStupaca, tockaP)
    traziIspod(slika, brRedaka, brStupaca, tockaP)
    traziLijevo(slika, brRedaka, brStupaca, tockaP)
    traziDesno(slika, brRedaka, brStupaca, tockaP)
    PrintSlike(slika, brRedaka, brStupaca)
  end
end

slika = Slika.new









