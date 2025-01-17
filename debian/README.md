# Automatizovaná instalace Zabixx na Debian
_(Screenshoty jsou ve složce "screenshots")_

## Příprava
Jako první jsem si projekt z Githubu překopírval na plochu. Následně jsem zkonzultoval AI a hrdě pokračoval.

## Součásti
Projekt se skládá z několika souborů, ty jsem vytvářel postupně. Postupně jsem také vychytával různé chyby v nich, což vedlo k tomu, že příkaz _vagrant up_ a _vagrant destroy_ jsem použil častěji, než je zdravé.

### .gitignore
Standardní soubor, díky kterému na Gitu není vidět soubor _id_rsa.pub_ a složka _.vagrant_.

### provision.sh
Skript automatizující instalaci Zabbixu. Tenhle soubor dělá nejvíc problémů, přepisoval jsem ho snad pětkrát, než konečně začal pracovat, jak má. Jedná se víceméně o kompilát toho, co máme k dispozici z minulých projektů, co jsem našel na netu, co jsem přepsal a toho co opravila AI. Skript provede aktualizaci systému a přidá a naistaluje Zabbix. Následně nakofiguruje MariaDB databázi, udělá pár dalších užitečných věcí a nakonec ověří funkčnost Zabbixu. Celý proces zpřehledňují výpisky do konzole pomocí příkazu _echo_, díky nimž se příjemněji orientuje v tom, co se zrovna děje. Na závěr pro jistotu opět pomocí _echo_ připomíná, že Zabbix najdu na localhost:8080. Přísahám, že mě+ tenhle soubor bude strašit ve snech.

### Vagrantfile
Tenhle soubor definuje vlastnosti virtuálního stroje (2 GB RAM a 2 CPU) a nastavuje port hosta (8080). Taky pracuje s klíčem, bez kterého by se nic jaksi nespustilo.

## Postup
Se všema souborama vytvořenýma jsem poprvé slavnostně použil _vagrant up_, jen abych zjistil, že něco poněkud nefunguje. Po zopakování tohoto procesu nehorázně mockrát, se konečně vše spustilo. Bohužel, problémem se pro změnu ukázal být proces konfigurace Zabbixu. Problém byl s přihlášením uživatele "zabbix" s heslem "password". Řešení tohoto problému _(viz /screenshots/zabbix_error)_ jsem v tuhle chvíli věnoval již několik hodin, nicméně zatím nemám tušení, kde by mohla být chyba. Rady ze StackOverflow a podobných fór nefungovaly, podobně jako rady od ChatGPT a jiných AI.

Po vyzkoušení několika různých provisionů se Zabbix konečně podařilo rozběhnout _(viz /screenshots/KONECNE)_,bohužel už nestíhám monitoring ověřit.
