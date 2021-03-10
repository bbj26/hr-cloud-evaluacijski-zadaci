puts "Program ispisuje brojeve od 1 do 100;
      Ako je broj djeljiv s 3, umjesto njega ispisuje se Djeljiv s 3;
      Ako je broj djeljiv s 5, umjesto njega ispisuje se Djeljiv s 5;
      Ako je broj djeljiv i s 3 i s 5, umjesto njega ispisuje se Djeljiv s 3 i 5;
      Ukoliko ništa od navedenog nije zadovoljeno, ispisuje se samo taj broj";
puts ""
puts ""

for broj in 1..100 do
  if broj % 3 == 0 then
    if broj % 5 == 0 then
      puts "Djeljiv s 3 i 5"      
    else
      puts "Djeljiv s 3"
    end
  elsif broj % 5 == 0
    puts "Djeljiv s 5"
  else
    puts broj
  end
end