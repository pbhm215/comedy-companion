# comedy-companion
Eine Witze App. Programmiert als Prüfungsleistung im Wahlkurs Swift-Programmierung im 4. Semester an der DHBW Stuttgart.

## Beschreibung
ComedyCompanion ist eine Komedie-App, die Witze aus dem Internet laden, dem
Bunutzer anzeigen und vorlesen kann. Als Quelle der Scherz-Texte dient die ”
JokeAPI“von sv443.net. In Abbildung 1 kann das App-Icon der App betrachtet werden,
Abbildung 1: App-Icon von ComedyCompanion
Die App besitzt im wesentlichen zwei Ansichten, deren Funktionalit¨aten im Folgenden in Kurze beschrieben werden. ¨

### Hauptansicht - ContentView
Abbildung 2 zeigt die Hauptansicht bzw. ContentView der App.
Hier die wichtigsten UI-Elemente im Uberblick: ¨
• Zentral wird der geladene Scherz angezeigt. Bei ihm handelt es sich je nach
Typ um einen Einzeiler, der als ”
Joke“bezeichnet wird oder einem Zweizeiler,
der mit ”
Setup“und ”
Punchline“angezeigt wird.
• Unter dem angezeigten Scherz befindet sich der Button ”
Read for me“. Wird
er bet¨atigt, wird der Witz in der jeweiligen Landessprache (momentan entweder Deutsch oder Englisch) vorgelesen. Dies wurde mit dem Framework
”
AVFoundation“realisiert, die fur Text-to-Speech ¨ Ubersetzung zust ¨ ¨andig ist.
• Links daneben befindet sich der Button ”
Next Joke“, der den n¨achsten Witz
von der JOKE-API l¨adt. Wird ein vorheriger Scherz noch vorgelesen und der
Button ”
Next Joke“bet¨atigt, so wird die aktuelle Sprachausgabe abgebrochen
und der neue Scherz geladen.
• Im oberen Bereich der ContentView befindet sich ein Button mit ZahnradSymbol. Durch ihn gelangt der Benutzter auf die Einstellungsansicht bzw.
”
SettingsView“.
Sollte beim Laden eines Witzes, beispielsweise durch eine fehlerhafte URL oder
ein nicht vorhandener Scherz bei den aktuell eingestellten Parametern auftreten,
wird eine entsprechende Fehlermeldung im Bereich der Scherz-Anzeige ausgegeben.

### Einstellungsansicht - SettingsView
Abbildung 3 zeigt die Hauptansicht bzw. ContentView der App. Auf der Einstellungsansicht hat der Benutzer die M¨oglichkeit, mehrere Einstellungen fur die gela- ¨
denen Scherze zu treffen. Folgende Parameter k¨onnen hier eingestellt werden:
• Language: Hier kann die Sprache der geladenen Witze durch einmaliges Tippen
zwischen Deutsch und Englisch getoggled werden. Achtung: hier handelt es sich
nur um die Sprach des Scherz-Inhalts! Die Sprache der UI-Elemente wird dadurch nicht ver¨andert, da hierzu die System-Sprache in den Ger¨ateeinstellungen
ver¨andert werden musste. Dies ist ¨ uber die programmierte App nicht m ¨ ¨oglich.
• Safe Mode: Beim Togglen des Buttons wird der Safe Mode ein- und ausgeschaltet. Der eingeschaltete Safe Mode verhindert, dass Scherze mit anst¨oßigem
Inhalt geladen werden.
• Category: Hier kann der Benutzer eine Kategorie festlegen, aus dem der Witz
stammt. Standardm¨aßig ist die Kategorie nicht, bzw. auf None”gesetzt, wodurch Scherze aller Kategorien geladen werden.
Bei der SettingsView handelt es sich um ein Sheet bzw. Pop-Up-Window. Sie kann
somit ganz einfach durch eine Wischgeste nach unten wieder geschlossen werden, wodurch der Benutzer zur Hauptansicht zuruckkehrt, sobald er seine Scherz-Konfiguration ¨
getroffen hat.

## Abh¨angigkeiten und Frameworks
Als Framework wurde neben SwiftUI fur die GUI-Elemente, die AVFoundation f ¨ ur ¨
die Text-to-Speech Ubersetzung verwendet. Mit diesem kann auch die auch die Stim- ¨
me fur die jeweilige Landessprache angepasst werden, in der der Scherz vorgelesen ¨
wird. Das ist notwendig, da beispielsweise ein deutscher Text mit der englischen
Stimme ¨außerst unverst¨andlich vorgelesen wird und umgekehrt.
Die offizielle Dokumentation ist uber den folgenden Link zu finden: ¨
https://developer.apple.com/documentation/avfoundation
Als Quelle der Scherze dient eine RESTful-API von sv443.net. Hierfur wird die ¨
URL entsprechend der gesetzten Parameter in der SettingsView zusammengebaut
und eine Anfrage an die REST-API gesendet. Als Antwort werden Scherz-Daten im
JSON-Format gesendet, die intern verarbeitet werden k¨onnen.
Die offizielle Dokumentation der API und ihrer Datenstruktur und Parameter ist
hier zu finden:
https://sv443.net/jokeapi/v2/

## Architektur
Als Architektur wurde das fur iOS-Apps typische MVVM-Modell gew ¨ ¨ahlt.
• Model: Hierin wird die Datenstruktur eines Scherzes festgelegt. Sie ist im
Wesentlichen dieselbe Datenstruktur wie die der geladenen JSON-Daten der
REST-API
• View: Wie im Abschnitt 2.1 beschrieben, existieren die beiden Ansichten ”
ContentView“fur das Anzeigen der Witze, sowie ¨
”
SettingsView“zur Benutzerdefinierten Konfiguration der Witze
• ViewModel: Hierin befindet sich die Gesch¨aftslogik der App: Mithilfe der
Funktion fetchJokeData() wird je nach gesetzten Parametern eine entsprechende URL zusammengebaut und an die REST-API gesendet. Die ankommenden JSON-Daten werden dekodiert und in der Funktion fetchJoke() einer Scherz-Instanz zugewiesen. Die Funktion speakJoke() ist fur die Text-to- ¨
Speech Ubersetzung mithilfe der AVFoundation zust ¨ ¨andig.
Genauere Hinweise zu einzelnen Code-Zeilen sind im Quellcode als Kommentare
gegeben.

## Klick-Anleitung
Die App ist relativ selbsterkl¨arend zu bedienen. Um alle Funktionen einmal zu erleben, hier eine kurze Klick-Anleitung:
1. Nach dem Offnen wird Hauptansicht, wie in Kapitel ¨ 2.1.1 beschrieben, gezeigt.
2. Um den n¨achsten Scherz zu laden, klicke auf den Knopf ”
Next Joke“.
3. Um den Scherz vorzulesen, klicke auf den Knopf ”
Read for me“.
4. Um die Einstellungsansicht zu ¨offnen, klicke auf den Knopf oben rechts mit
dem Zahnradsymbol.
5. Um die Sprache zu ¨andern, klicke einmalig auf den oberen, blau markierten
Button. Das Flaggensymbol wechselt von einer US-Amerikanischen zu einer
deutschen Flagge. Die Sprache ist nun auf Deutsch eingestellt.
6. Um den Safe Mode zu aktivieren, setze den Schieberegler bei ”
Enable Safe
Mode“durch einmaliges Klicken auf die rechte ”
Ein“-Position.
10
7. Um eine Kategorie zu w¨ahlen, aus der der Witz stammt, klicke auf die gewunschte ¨
Kategorie. Im Rahmen dieser Anleitung beispielsweise auf ”
Programming“Die
Auswahl wird mit einem blauen Haken auf der rechten Bildschirmseite angezeigt. Es kann immer nur eine Kategorie gleichzeitig ausgew¨ahlt werden.
8. Um die Einstellungsseite wieder zu verlassen, ziehe eine Wischgeste von oben
nach unten. Es wird nun wieder die Hauptansicht gezeigt.
9. Um die benutzerdefinierten Konfigurationen fur den n ¨ ¨achsten Scherz wirksam
zu machen, klicke auf ”
Next Joke“. Es wird ein Scherz entsprechend der eingestellten Parameter angezeigt. In diesem Fall ein deutscher, unanst¨oßiger Scherz
aus der Programmier-Kategorie.
Wie bereits beschrieben k¨onnen auch Fehler beim Laden der Scherze auftreten, die im Textbereich des Scherzes angezeigt werden. Dies passiert beispielsweise,
wenn es keinen Scherz zu den gew¨ahlten Parametern gibt oder kontr¨are Parameter wie beispielsweise ein Witz aus der Kategorie ”
Dark“mit eingeschaltetem Safe
Mode gesetzt werden. Um solch einen Fehler zu provozieren kann folgendermaßen
vorgegangen werden:
1. Klicke auf den Button mit Zahnradsymbol in der oberen, rechten Ecke um die
Einstellungsseite zu ¨offnen.
2. Klicke auf den Button ”
Language of Joke“, solange bis das Flaggensymbol auf
deutscher Sprache eingestellt ist.
3. Schalte den Safe Mode durch Klicken auf den entsprechenden Toggle-Buttoon
aus.
4. W¨ahle als Kategorie ”
Dark“durch entsprechendes Klicken.
5. Schließe die Einstellungsansicht durch eine Wischgeste nach unten
6. Klicke auf den Knopf ”
Next Joke“.
7. Statt eines Scherzes sollte nun eine rote Fehlermeldung angezeigt werden, die
den Fehler beim Laden des Scherzes genauer beschreibt (”
ERROR: Fehler
beim Laden der Daten: The data couldn´t be read because it is missing“.) Der
Fehler kommt zustande, da momentan kein deutscher Scherz aus der Kategorie
”
Dark“in der Datenbank der REST-API vorhanden ist.
8. Beim Klick auf den Knopf ”
Read for me“wird die Fehlermeldung nicht vorgelesen, da es sich hierbei nicht um einen Scherz handelt.

## Fehler und Warnungen
Die App l¨asst sich ohne Fehler und Warnungen in der Preview ausfuhren. ¨
Bei der Ausfuhrung im Simulator kann es beim Laden und Vorlesen der ersten ein ¨
bis zwei Scherze zu Warnungen wie beispielsweise ”
Unable to list voice folder“in
der Kommandozeile kommen. Allesamt beeintr¨achtigen jedoch in keinster Weise
die Funktionalit¨at der App und entstehen dadurch, dass mit dem AVFoundationFramework auf I-/O-Ger¨ate wie Kamera oder Lautsprecher des Apple-Ger¨ats zugegriffen wird. Da die Ausfuhrung jedoch im Simulator stattfindet kann es zu unver- ¨
meidbaren Problemen kommen. Bei nachfolgenden Scherzabfragen (nach dem ersten
bis zweiten Mal) treten diese Probleme kaum bis gar nicht mehr auf.
