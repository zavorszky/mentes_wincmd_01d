# Jelentés a tesztelésről

##

## Szkript tesztelése

### Tesztesetek és eredmények

|#  | p1 | p2  | p3 | p4 | Eredmény | Értékelés| Dátum    |
|---|----|-----|----|----|----------|----------|----------|
|1  | #H | #H  | #H | #H | Hiba:....| Elogadva |2025.03.25|
|2  | *  | #H  | #H | #H | Hiba:....| Elogadva |2025.03.25|
|3  | *  | *   | #H | #H | Hiba:....| Elogadva |2025.03.25|
|4  | *  | *   | *  | #H | Hiba:....| Elogadva |2025.03.25|
|5  |    |     |    |    |          |          |          |
|6  | 0  | f1  | d1 | D1 |          |          |          |
|7  | 0  | f1  | d1 | D2 | Hiba:....|          |          |
|8  | 0  | f1  | d2 | *  | Hiba:....|          |          |
|9  | 0  | f2  | *  | *  | Hiba:....|          |          |
|10 |    |     |    |    |          |          |          |
|11 | 1  | f1  | d1 | D1 |          |          |          |
|12 |    |     |    |    |          |          |          |
|13 | 2  | *   | *  | *  | Hiba:....| Elogadva |2025.03.25|

#H : hiányzik  
f1 : létező file  
f2 : NEM létező file
d1 : létező könyvtár
d2 : NEM létező könyvtár
D1 : létező drive
D2 : NEM létező drive
\* : Bármi

