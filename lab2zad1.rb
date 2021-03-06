# Lab 2 zadanie 1 HP - testy: while [ true ]; do ruby lab2zad1.rb; sleep 2; done

def selekcja(tab, k)
	if tab.length < 140
		value = tab.sort![k]

		value
	else
		# Podzial tablicy na mniejsze 5-elementowe
		a = []
		(0..tab.length / 5 - 1).each do | i |
			a.push tab[i + i * 4..i + 4 * (i + 1)]
		end

		if tab.length % 5 != 0
			a.push tab[(tab.length/5)*5..tab.length]
		end

		# Sortowanie mniejszych tablic
		m = []
		(0..a.length - 1).each do |i|
			a[i].sort!
			# Wyznaczenie mediany
			m[i] = a[i][a[i].length / 2]
		end

		# Wywolanie rekurencyjne procedury selekcja, aby wyznaczyc (dolna) mediane m
		m = selekcja(m, m.length/2)

		# Podzial tablicy wejsciowej wzgledem mediany median m
		wynik = []
		wynik.push m
		index = 0

		(0..tab.length - 1).each do |i|
			if tab[i] > m
				wynik.insert(index + 1, tab[i])
			else
				wynik.insert(index, tab[i])
				index = index + 1
			end
		end

		# Jeśli i = k, zwroc m. W przeciwnym razie wywolaj rekurencyjnie procedure selekcja
		if index == k
			m
		else
			if index > k
				selekcja(wynik[0..index - 1], k)
			else
				selekcja(wynik[index + 1..wynik.length - 1], k - index)
			end
		end
	end
end

# Zakres danych: 100 - 10000, po 50 prob
print "+---+-----------+ \n"
print "| n | czas (50) |\n"
(100..10000).step(100) do |i|
	# Generowanie danych poczatkowych
	# Rozmiar danych
	size = i
	average = 0

	(0..50).each do |j|
		k = Random.new_seed % size

		# Tablica z liczbami
		tab = (0..size - 1).sort_by{rand}

		# Wlasciwy algorytm + czas
		t1 = Time.now
		value = selekcja(tab, k)
		t2 = Time.now
		delta = t2 - t1
		average += delta.to_f
	end
	average /=50
	print "| #{i} | #{average/i} |\n"
end
print "+--------------------------------------------------------+\n"
