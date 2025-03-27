# Jelentés a tesztelésről

##

## Szkript tesztelése

### Tesztesetek és eredmények

|#  | p1 | p2  | p3 | p4 | Terv  | Tény | Eredmény      | Értékelés | Dátum      |
|---|----|-----|----|----|-------|------|:-------------:|-----------|:-----------:|
|1  | #H | #H  | #H | #H | Hiba  | Hiba | test_no_1.log | Elogadva  | 2025.03.27 |
|2  | *  | #H  | #H | #H | Hiba  | Hiba | test_no_2.log | Elogadva  | 2025.03.27 |
|3  | *  | *   | #H | #H | Hiba  | Hiba | test_no_3.log | Elogadva  | 2025.03.27 |
|4  | *  | *   | *  | #H | Hiba  | Hiba | test_no_4.log | Elogadva  | 2025.03.27 |
|   |    |     |    |    |       |      |               |           |            |
|5  | 0  | f1  | d1 | D1 | Siker | Hiba | test_no_5.log | <font color="red">Visszautasítva</font> | 2025.03.27 |
|5a | 0  | f1  | d1 | D1 | Siker | Siker| test_no_5a.log| Elogadva  | 2025.03.27 |
|6  | 0  | f1  | d1 | D2 | Hiba  |      | ...           |           |            |
|7  | 0  | f1  | d2 | *  | Hiba  |      | ...           |           |            |
|8  | 0  | f2  | *  | *  | Hiba  |      | ...           |           |            |
|9  |    |     |    |    |       |      |               |           |            |
|10 | 1  | f1  | d1 | D1 |       |      |               |           |            |
|11 |    |     |    |    |       |      |               |           |            |
|12 | 2  | *   | *  | *  | Hiba  |      | ...           | Elogadva  | 2025.03.25 |

#H : hiányzik  
f1 : létező file  
f2 : NEM létező file  
d1 : létező könyvtár  
d2 : NEM létező könyvtár  
D1 : létező drive  
D2 : NEM létező drive  
\* : Bármi

