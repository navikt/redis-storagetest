redis-storagetest
=================

> En liten "ytelstetest" av Redis-HA

Brukes til å teste litt utfordringer vi har hatt med Redis, både som HA og som singleton.

Appen har to egenskaper:
* et endepunkt som heter `/bump` som legger inn en vilkårlig nøkkel med en value på 1mb
* fra den starter opp, så spytter den inn vilkårlig antall verdier, med vilkårlig nøkkel og innhold. Så sover den en tilfeldig lengde, før den gjør det samme igjen
