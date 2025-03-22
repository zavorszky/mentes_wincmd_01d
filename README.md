# Mentés Win10 batch script-tel

## A probléma

Az előző (00a, 01a, 01b, 01c) verziók a forrás könyvtárak halmazát tömörítették<br>
és mentették. Mindíg az összes könyvtárat. Ez egyre hosszabb ideig tart, ahogy<br>
növekszik a könyvtárak száma és mérete. Ez a aprobléma.

Az lenne jó, ha egy teljes mentés után csak a változásokat mentenénk. Ennek egy<br>
régi és elegáns módja, ha a tömörítő a file-ok archív bitjét figyeli és mentéskör<br>
törli, ugyanis a Windows a file-ok módosításakor az archív bitet érvényesre állítja.

## Megoldás

1. 7z.exe<br>
Önmagában nem jó mert nem kezeli a forrás file-ok archive bit-jét.

2. XCOPY + 7z.exe<br>
A Windows XCOPY és a 7z.exe kombinálásával megoldható a probléma.
    1. Teljes mentés .../00000000_000000_0/<br>
        Minden file mentés
        Archív bitek törlése
    2. Változások mentése .../ééééhhnn_ooppmm_1/<br>
        Csak a beállított (módosított) file-ok mentése

...

#### Mentendő file-ok összegyűjtése

XCOPY

#### Tömörítés

7z.exe 

#### Problémák

* Az XCOPY megszakad, mert elfogyasztja a memóriát, ha túl sok<br>
    file van a mentendő könyvtárban
    * Megoldás: A könyvtárat több darabra kell bontani

* Az XCOPY megszakad, mert túl hosszú a másolandó fire neve vagy<br>
    elérési útvonala
    * Megoldás: még nem tudom...

## Verzió
01d

## Fejlesztő
zavorszky@yahoo.com
