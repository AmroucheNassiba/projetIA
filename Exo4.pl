addh([H, M], Minutes, [H2, M2]) :-
    TotalMinutes is M + Minutes,
    H2 is H + TotalMinutes // 60,
    M2 is TotalMinutes mod 60,
    H2 < 24.

affiche([H, M]) :-
    format('Heure resultante : ~|~`0t~d~2+:~|~`0t~d~2+', [H, M]).
ligne(2, metro, [
		 [nation, 0],
		 [avron, 1],
		 [alexandre_dumas,2],
		 [philippe_auguste,1],
		 [pere_lachaise,2],
		 [menilmontant,2],
		 [couronnes,1],
		 [belleville,2],
		 [colonel_fabien,1],
		 [jaures,1],
		 [stalingrad,2],
		 [la_chapelle,1],
		 [barbes_rochechouart,3],
		 [anvers,2],
		 [pigalle,1],
		 [blanche,2],
		 [place_clichy,3],
		 [rome,2],
		 [villiers,3],
		 [monceau,2],
		 [courcelles,2],
		 [ternes,3],
		 [charles_de_gaulle_etoile,3],
		 [victor_hugo,2],
		 [porte_dauphine,3]
		 ], [[5,0],2,[1,45]], [[5,15],2,[1,55]]
).

ligne(3, metro, [
		 [pont_levallois_becon,0],
		 [anatole_france,2],
		 [louise_michel,3],
		 [porte_de_champerret,2],
		 [pereire,2],
		 [wagram,2],
		 [malesherbes,3],
		 [villiers,2],
		 [europe,3],
		 [saint_lazare,4],
		 [havre_caumartin,2],
		 [opera,3],
		 [quatre_septembre,3],
		 [bourse,2],
		 [sentier,3],
		 [reaumur_sebastopol,3],
		 [arts_metiers,3],
		 [temple,2],
		 [republique,3],
		 [parmentier,2],
		 [rue_saint_maur,3],
		 [pere_lachaise,4],
		 [gambetta,2],
		 [porte_de_bagnolet,3],
		 [gallieni,3]
		 ], [[5,35],4,[0,20]], [[5,30],4,[0,20]]
).

ligne(bis_3, metro, [
		    [porte_lilas,0],
		    [saint_fargeau,2],
		    [pelleport,1],
		    [gambetta, 2]
		    ], [[6,0],7,[23,45]], [[6,10],7,[23,55]]
).

ligne(5, metro, [
		 [bobigny_pablo_picasso, 0],
		 [bobigny_pantin, 2],
		 [eglise_de_pantin, 3],
		 [hoche,4],
		 [porte_pantin,3],
		 [ourcq,4],
		 [laumiere,3],
		 [jaures,3],
		 [stalingrad,2],
		 [gare_du_nord,3],
		 [gare_de_est,1],
		 [jacques_bonsergent,2],
		 [republique,3],
		 [oberkampf,2],
		 [richard_lenoir,2],
		 [breguet_sabin,2],
		 [bastille,2],
		 [quai_de_la_rapee,3],
		 [gare_austerlitz,2],
		 [saint_marcel,3],
		 [campo_formio,2],
		 [place_italie,3]
		], [[5,24],3,[1,20]], [[5,30],3,[1,0]]
).

ligne(bis_7, metro, [
		    [pre_saint_gervais,0],
		    [place_fetes, 3],
		    [danube, 0],
		    [bolivar, 2],
		    [buttes_chaumont, 2],
		    [botzaris, 2],
		    [jaures, 3],
		    [louis_blanc,2]
		    ], [[5,35],8,[0,0]], [[5,50],8,[23,45]]
).

ligne(11, metro, [
                   [mairie_lilas, 0],
                   [porte_lilas, 3],
                   [telegraphe,1],
                   [place_fetes,1],
                   [jourdain, 1],
                   [pyrenees, 1],
                   [belleville, 2],
                   [goncourt, 2],
                   [republique, 3],
                   [arts_metiers, 2],
                   [rambuteau, 1],
                   [hotel_de_ville, 1],
                   [chatelet, 1]
                   ], [[5,15],5,[1,30]], [[5,0],5,[2,0]]
).

% Prédicat modifié pour vérifier si une ligne passe par deux arrêts, en tenant compte du type de transport et de la préférence de la longueur du trajet
lig(Arret1, Arret2, Ligne, TypeTransport, LongueurPreference) :-
    ligne(Ligne, TypeTransport, Arrets, _, _),
    member([Arret1, _], Arrets),
    member([Arret2, Longueur], Arrets),
    append(_, [[Arret1, _]|Reste], Arrets),
    append(_, [[Arret2, Longueur]|_], Reste),
    sommeLongueurs(Reste, LongueurTotale),
    LongueurTotale =< LongueurPreference.

% Prédicat pour calculer la somme des longueurs dans une liste darrêts
sommeLongueurs([], 0).
sommeLongueurs([[_, Longueur]|Reste], Somme) :-
    sommeLongueurs(Reste, SommeReste),
    Somme is Longueur + SommeReste.



% Prédicat modifié pour trouver une ligne entre deux arrêts avec un départ le plus tôt possible après un certain horaire, en tenant compte du type de transport et de la préférence de la longueur du trajet
ligtot(Arret1, Arret2, Ligne, Horaire, TypeTransport, LongueurPreference) :-
    lig(Arret1, Arret2, Ligne, TypeTransport, LongueurPreference),
    ligne(Ligne, _, _, [[H, M]|_], _),
    addh([H, M], 1, Horaire).

% Prédicat modifié pour trouver une ligne entre deux arrêts avec une arrivée le plus tard possible avant un certain horaire, en tenant compte du type de transport et de la préférence de la longueur du trajet
ligtard(Arret1, Arret2, Ligne, Horaire, TypeTransport, LongueurPreference) :-
    lig(Arret1, Arret2, Ligne, TypeTransport, LongueurPreference),
    ligne(Ligne, _, _, _, [[H, M]|_]),
    addh([H, M], -1, Horaire).

% Prédicat modifié pour trouver un itinéraire de Arret1 à Arret2 qui part le plus tôt possible après Horaire, en tenant compte du type de transport et de la préférence de la longueur du trajet
itinTot(Arret1, Arret2, Horaire, [Arret1, Horaire, Arret2, Horaire], TypeTransport, LongueurPreference) :-
    lig(Arret1, Arret2, _, TypeTransport, LongueurPreference),
    !.

itinTot(Arret1, Arret2, Horaire, [Arret1, Horaire|Parcours], TypeTransport, LongueurPreference) :-
    ligtot(Arret1, ArretInter, Ligne, Horaire, TypeTransport, LongueurPreference),
    itinTot(ArretInter, Arret2, _, Parcours, TypeTransport, LongueurPreference).

% Prédicat modifié pour trouver un itinéraire de Arret1 à Arret2 qui arrive le plus tard possible avant Horaire, en tenant compte du type de transport et de la préférence de la longueur du trajet
itinTard(Arret1, Arret2, Horaire, [Arret1, Horaire, Arret2, Horaire], TypeTransport, LongueurPreference) :-
    lig(Arret1, Arret2, _, TypeTransport, LongueurPreference),
    !.

itinTard(Arret1, Arret2, Horaire, [Arret1, Horaire|Parcours], TypeTransport, LongueurPreference) :-
    ligtard(Arret1, ArretInter, Ligne, Horaire, TypeTransport, LongueurPreference),
    itinTard(ArretInter, Arret2, _, Parcours, TypeTransport, LongueurPreference).


