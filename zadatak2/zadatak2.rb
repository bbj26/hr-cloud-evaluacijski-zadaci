=begin
  
Ispisati strukturu direktorija za proizvoljni ulazni direktorij.
Metoda kao ulazni argument prima direktorij ili file.
Potrebno je identirano ispisati sve pod direktorije i fileove koji se nalaze u direktorijima(uključujući i ulazni argument).
Identacija ide na način, da prva "djeca" direktoriji i fileovi su identacije 1, 
zatim njihova djeca identacije 2 i tako redom, tako da se dobije stablasta struktura.
Uz ime direktorija treba biti ukupan broj fileova i direktorija koji se nalaze u tom direktoriju 

=end

puts "Unesite apsolutnu putanju (bez navodnika) do direktorija ciju strukturu zelite ispisati:"
@putanja = gets.chomp!()

puts "Ispis stablaste strukture navedenog direktorija:"
puts ""



def OdrediIndent(homePath, newPath)
  indent = newPath.sub(homePath, "").count("/")
  indent
end

def OdrediBrojFileovaUDirektoriju (path)
  all = path + "/**/*"
  ukupanBroj = Dir[all].length
  ukupanBroj
end

def IspisiDjecu(path) 
  if Dir[path].empty? then
    puts "empty"
  else
    if File.directory?(path) then 
      Dir.children(path).each {|child|
        newPath = path + '/' + child
        indent = OdrediIndent(@putanja, newPath)
        indent.times do print "\t" end
        if File.directory?(newPath) 
          brFajlova = OdrediBrojFileovaUDirektoriju(newPath)
          print child + "  #{brFajlova}" + "\n"
        else
          print child + "\n"
        end
        
        IspisiDjecu(newPath)
      }
    end
  end
end

puts @putanja.split('/').last + "  #{OdrediBrojFileovaUDirektoriju(@putanja)}" #polazni direktorij
IspisiDjecu(@putanja)

