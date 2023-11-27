addh([H, M], Minutes, [H2, M2]) :-
    TotalMinutes is M + Minutes,
    H2 is H + TotalMinutes // 60,
    M2 is TotalMinutes mod 60,
    H2 < 24.

affiche([H, M]) :-
    format('~|~`0t~d~2+H~|~`0t~d~2+', [H, M]).
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
lig(Arret1, Arret2, Ligne) :-
    ligne(Ligne, _, Arrets, _, _),
    member([Arret1, _], Arrets),
    member([Arret2, _], Arrets),
    connectes(Arrets, Arret1, Arret2).

% Vérifie si deux arrêts sont connectés dans la liste des arrêts
connectes(Arrets, Arret1, Arret2) :-
    append(_, [[Arret1, _]|Reste], Arrets),
    append(_, [[Arret2, _]|_], Reste).
ligtot(Arret1, Arret2, Ligne, Horaire) :-
    ligne(Ligne, _, Arrets, [[H, M]|_], _),
    lig(Arret1, Arret2, Ligne),
    Horaire = [Heure, Minutes],
    H >= Heure,
    horaireDepartPlusTard(Arrets, Horaire, PlusTard),
    addh([H, M], PlusTard, Horaire).

connectes(Arrets, Arret1, Arret2) :-
    append(_, [[Arret1, _]|Reste], Arrets),
    append(_, [[Arret2, _]|_], Reste).

horaireDepartPlusTard([[_, _]|_], _, 0). 
horaireDepartPlusTard([[_, _]|_], [H, M], PlusTard) :-
    HoraireActuel = [H, M],
    addh(HoraireActuel, 1, PlusTard).
horaireDepartPlusTard([[_, _]|Reste], Horaire, PlusTard) :-
    horaireDepartPlusTard(Reste, Horaire, PlusTard).
% Prédicat pour ajouter des minutes à un horaire
addMinutes([H, M], Minutes, [H2, M2]) :-
    TotalMinutes is M + Minutes,
    H2 is H + TotalMinutes // 60,
    M2 is TotalMinutes mod 60,
    H2 < 24.
ligtard(Arret1, Arret2, Ligne, Horaire) :-
    ligne(Ligne, _, Arrets, _, [[H, M]|_]),
    lig(Arret1, Arret2, Ligne),
    Horaire = [Heure, Minutes],
    HorairePlusTard is Heure * 60 + Minutes,
    horaireArriveePlusTard(Arrets, HorairePlusTard, PlusTard),
    addh([H, M], PlusTard, Horaire).

% Vérifie si deux arrêts sont connectés dans la liste des arrêts
connectes(Arrets, Arret1, Arret2) :-
    append(_, [[Arret1, _]|Reste], Arrets),
    append(_, [[Arret2, _]|_], Reste).

% Trouve le temps minimal entre deux arrêts dans la liste
tempsMinimal(Arrets, Arret1, Arret2, Temps) :-
    member([Arret1, Temps1], Arrets),
    member([Arret2, Temps2], Arrets),
    connectes(Arrets, Arret1, Arret2),
    Temps is min(Temps1, Temps2).

% Calcule lhoraire darrivée le plus tard possible
horaireArriveePlusTard([[_, _]|_], _, 0).
horaireArriveePlusTard([[_, _]|_], HorairePlusTard, PlusTard) :-
    HoraireActuel = [H, M],
    addh(HoraireActuel, 1, PlusTard),
    PlusTard =< HorairePlusTard.
horaireArriveePlusTard([[_, _]|Reste], HorairePlusTard, PlusTard) :-
    horaireArriveePlusTard(Reste, HorairePlusTard, PlusTard).
% Prédicat principal pour trouver un itinéraire total de Arret1 à Arret2 à partir dun certain horaire
itinTot(Arret1, Arret2, Horaire, Parcours) :-
    ligtot(Arret1, Arret2, Ligne, Horaire, TypeTransport),
    itinRec(Arret1, Arret2, Ligne, TypeTransport, Horaire, [], Parcours).

% Prédicat récursif pour explorer les itinéraires possibles
itinRec(ArretActuel, ArretFinal, Ligne, TypeTransport, HoraireDepart, Horaire, [ArretActuel | Parcours]) :-
    ligtot(ArretActuel, ArretSuivant, Ligne, HoraireDepart, TypeTransport),
    HoraireActuel = HoraireDepart, % Vous pouvez ajuster cette condition selon vos besoins
    itinRec(ArretSuivant, ArretFinal, Ligne, TypeTransport, HoraireActuel, Horaire, Parcours).
    
itinRec(ArretFinal, ArretFinal, _, _, _, _, []).

% Prédicat ligtot/5 pour récupérer le prochain arrêt dans un itinéraire
ligtot(Arret1, Arret2, Ligne, Horaire, TypeTransport) :-
    lig(Arret1, Arret2, Ligne),
    ligne(Ligne, TypeTransport, _, [[H, M]|_], _),
    addh([H, M], 1, Horaire).
% Prédicat pour trouver un itinéraire total de Arret1 à Arret2 à partir dun certain horaire
itinTard(Arret1, Arret2, Horaire, Parcours) :-
    itinRecTard(Arret1, Arret2, Horaire, [], Parcours).

% Prédicat récursif pour explorer les itinéraires possibles en arrivant le plus tard possible
itinRecTard(ArretActuel, ArretFinal, HoraireArrivee, Horaire, [ArretActuel | Parcours]) :-
    ligtard(ArretActuel, ArretSuivant, Ligne, HoraireDepart),
    HoraireDepart >= HoraireArrivee,
    itinRecTard(ArretSuivant, ArretFinal, HoraireDepart, Horaire, Parcours).
itinRecTard(ArretFinal, ArretFinal, _, _, []).

% Planificateur de trajets

% Prédicat pour linterface utilisateur
interface_utilisateur :-
    write('Stations desservies par les transports publics : '), nl,
    % Affichez ici la liste des stations desservies.
    

    write('Choisissez une station de départ : '), read(StationDepart),
    write('Choisissez une station d\'arrivée : '), read(StationArrivee).
    
    % Laissez lutilisateur choisir les options ici.

    % Affichez ici le ou les parcours possibles.
