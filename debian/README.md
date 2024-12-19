# Automatizovaná instalace Zabixx na Debian
## Příprava
Jako první jsem si projekt z Githubu překopírval na plochu. Následně jsem zkonzultoval AI a hrdě pokračoval. 

## Součásti
Projekt se skládá z několika souborů, ty jsem vytvářel postupně. Postupně jsem také vychytával různé chyby v nich, což vedlo k tomu, že příkaz "vagrant up" a "vagrant destroy" jsem používal častěji, než je zdravé.

### .gitignore
Standartní soubor, díky kterému na Gitu není vidět soubor id_rsa.pub a složka .vagrant.

### provision.sh
Skript automatizující instalaci Zabbixu. Tenhle soubor dělá nejvíc problémů, přepisoval jsem ho snad pětkrát, než konečně začal pracovat, jak má. Jedná se víceméně o kompilát toho, co máme k dispozici z minulých projektů, co jsem našel na netu, co jsem přepsal a toho co opravila AI. Skript provede aktualizaci systému a přidá a naistaluje Zabbix. Následně nakofiguruje MariaDB databázi, udělá pár dalších užitečných věcí a nakonec ověří funkčnost Zabbixu. Celý proces  zpřehledňují výpisky do konzole pomocí příkazu "echo", díky nimž se příjemněji orientuje v tom, co se zrovna děje. Na závěr pro jistotu opět pomocí "echo" připomíná, že Zabbix najdu na localhost:8080.

### Vagrantfile
Tenhle soubor definuje vlastnosti virtuálního stroje (2 GB RAM a 2 CPU) a nastavuje port hosta (8080). Taky pracuje s klíčem, bez kterého by se nic jaksi nespustilo.
