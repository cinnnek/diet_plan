-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Paź 27, 2024 at 10:46 AM
-- Wersja serwera: 10.4.28-MariaDB
-- Wersja PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `diets_project`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `dietuser`
--

CREATE TABLE `dietuser` (
  `id` int(11) NOT NULL,
  `id_plan` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `start_date` date DEFAULT curdate(),
  `end_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `plan`
--

CREATE TABLE `plan` (
  `id_plan` int(11) NOT NULL,
  `nazwa` varchar(100) NOT NULL,
  `ile_kalorii` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `plan`
--

INSERT INTO `plan` (`id_plan`, `nazwa`, `ile_kalorii`, `description`) VALUES
(1, 'Plan 2000 kcal', 2000, 'Plan diety o dziennej wartości energetycznej 2000 kcal.'),
(2, 'Plan 2500 kcal', 2500, 'Plan diety o dziennej wartości energetycznej 2500 kcal.'),
(3, 'Plan 3000 kcal', 3000, 'Plan diety o dziennej wartości energetycznej 3000 kcal.'),
(4, 'Plan 3500 kcal', 3500, 'Plan diety o dziennej wartości energetycznej 3500 kcal.'),
(5, 'Plan 4000 kcal', 4000, 'Plan diety o dziennej wartości energetycznej 4000 kcal.'),
(6, 'Plan 4500 kcal', 4500, 'Plan diety o dziennej wartości energetycznej 4500 kcal.');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `posilek`
--

CREATE TABLE `posilek` (
  `id_posiłku` int(11) NOT NULL,
  `nazwa` varchar(100) NOT NULL,
  `kcal` int(11) DEFAULT NULL,
  `plan_id` int(11) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `przepis` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posilek`
--

INSERT INTO `posilek` (`id_posiłku`, `nazwa`, `kcal`, `plan_id`, `type`, `przepis`) VALUES
(1, 'Omlet na masę', 1260, 6, 'Śniadanie', 'W misce umieść białka jaj. Dodaj odżywkę płatki proszek\nbudyniowy proszek do pieczenia i szczyptę soli. Słodziki rozdrobnij\nlub rozpuść w gorącej wodzie i dodaj do miski. Całość zblenduj na\nstosunkowo jednolitą masę i przelej do okrągłej foremki do\npieczenia.\nOmlet piecz około 18 minut w 220 stopniach.\nPieczony omlet podawaj z jogurtem i plastrami banana'),
(2, 'Tortilla z jajecznicą', 472, 2, 'Śniadanie / przekąska', 'Na patelni przygotuj standardową ściętą jajecznicę. Na osobnej\r\npatelni połóż placek tortilli. Nałóż na niego kawałki sera, rukolę,\r\nkukurydzę, ketchup, ściętą jajecznicę resztę sera i troszkę pieprzu.\r\nCałość zawiń i podpiecz tak aby się zarumieniła z obu stron.\r\nZacznij podpiekanie od tej strony gdzie placek na siebie zachodzi.'),
(7, 'Nocna owsianka z bananem i masłem orzechowym', 443, 1, 'Śniadanie ', 'Płatki, nasiona chia, skyr, kakao i masło orzechowe przełożyć do pojemniczka i wymieszać. Odstawić na noc do lodówki. Kolejnego dnia rano dodać pokrojonego banana.'),
(8, 'Borówki amerykańskie 400g', 236, 1, 'Przekąska ', 'Usuń szypułki z owoców. Umyj dokładnie owoce zimną wodą.'),
(9, 'Kurczak z kaszą gryczaną i kapustą kiszoną', 452, 1, 'Obiad', 'Kaszę gryczaną gotujemy według przepisu na opakowaniu. Kurczaka, cebulę i paprykę kroimy w kostkę i smażymy na patelni na rozgrzanym oleju. Ugotowaną kaszę dodajemy na patelnię do pozostałych składników i mieszamy. Podajemy z kapusta kwaszoną.'),
(10, 'Racuchy z jabłkami\r\n', 637, 1, 'Obiad', 'Jabłko ścieramy na tarce, podgrzewamy mleko i dodajemy drożdże. Następnie dodajemy mąkę, cynamon i olej. Całość mieszamy z jabłkami i odstawiamy, żeby ciasto wyrosło. Nakładamy łyżkami na rozgrzany tłuszcz i smażymy.'),
(11, 'Serek z brzoskwinią\r\n', 232, 1, 'Kolacja', 'Brzoskwinię kroimy na małe kawałki i mieszamy z pozostałymi składnikami.'),
(12, 'Koktajl z bananem i szpinakiem\r\n', 528, 2, 'Przekąska', 'Całość blendujemy'),
(13, 'Kasza jaglana ze schabem i pomidorami\r\n', 659, 2, 'Obiad', 'Kaszę jaglaną przelewamy na sitku zimną wodą, następnie wrzątkiem i znów zimną wodą. Posiekaną cebulę smażymy na patelni na rozgrzanym oleju razem z pokrojonym w kostkę schabem, dodajemy pokrojoną w kostkę lub startą na grubej tarce marchewkę, pomidory i ulubione przyprawy. Dusimy na wolnym ogniu pod przykryciem, pod koniec dodajemy koncentrat pomidorowy. Kaszę kładziemy na talerz i zalewamy zawartością patelni.'),
(14, 'Zupa krem z dyni i grochu\r\n', 540, 2, 'Podwieczorek', '1. Namocz groch w miseczce z wodą. 2. Czosnek przeciśnij przez praskę. Zetrzyj na tarce (lub zblenduj) marchewkę i pietruszkę. Pokrój pora na drobne plasterki. Podsmaż rozdrobnione warzywa na rozgrzanej oliwie. Posól. Duś pod przykryciem 10 min. 3. Ugotuj groch (stosunek wody do grochu - 2:1). Dodaj groch do garnka z duszonymi warzywami. 4. Do warzyw dodaj dynię pokrojoną w kostkę, słodką paprykę oraz 0,5 szklanki wody. Gotuj około 15-20 minut. 5. Zmiksuj warzywa i posól wedle smaku. 6. Na suchej patelni upraż pestki słonecznika. 7. Dodaj pestki do zupy przed samym podaniem.'),
(15, 'Kanapki z pesto\r\n', 315, 2, 'Kolacja', 'Chleb smarujemy pesto, nakładamy sałatę i paprykę'),
(16, 'Anaboliczne kanapki\r\n', 801, 3, 'Śniadanie', 'Jajka ugotuj na twardo i delikatnie wystudź. Zagnieć je widelcem\r\nz twarogiem, śmietaną i przyprawami. Do pasty dodaj pokrojony\r\ndrobno szczypiorek i natkę. Pastę przełóż na kanapki. Dodaj\r\nplastry pomidora. Pestki podpraż na suchej patelni i posyp nimi\r\nkanapki.'),
(17, 'Mini serniczki', 541, 3, 'Przekąska', 'Twaróg zagnieć widelcem razem z białkami. Dodaj mąkę i odżywkę. Całość wymieszaj. Olej rozgrzej na patelni. Łyżką\r\nnakładaj masę i smaż mini serniczki.'),
(18, 'Kurczak w sosie cytrynowym z ryżem\r\n', 859, 3, 'Obiad', 'Kurczaka kroimy w kostkę i marynujemy w sosie złożonym z soku cytrynowego (2 łyżki), oliwy z oliwek (2 łyżki), odrobiną suszonej papryki chilli (na czubku łyżeczki) i soli. Smażymy na rozgrzanej patelni (bez dodatkowego tłuszczu). W międzyczasie przygotowujemy sałatkę: rukolę myjemy, dodajemy pomidorki koktajlowe (możemy je przekroić na pół) i posiekaną czerwoną cebulę. Polewamy dressingiem (1 łyżka oliwy, 1 łyżeczka soku z cytryny, pieprz, sól). Na sałatkę wykładamy zawartość patelni. Podajemy z ugotowanym według przepisu na opakowaniu ryżem.'),
(20, 'Sałatka z awokado, szpinakiem i pomarańczą\r\n', 485, 3, 'Podwieczorek', 'Kroimy składniki, polewamy oliwą, posypujemy ulubionymi przyprawami i mieszamy ze szpinakiem. Podajemy z krążkami ryżowymi.'),
(21, 'Sałatka z kukurydzą, papryką i nasionami chia (z chlebem)', 323, 3, 'Kolacja', 'Sałatę rwiemy, pomidora i paprykę kroimy. Całość mieszamy z kukurydzą i polewamy oliwą z oliwek zmieszaną z nasionami chia i ulubionymi przyprawami. Podajemy z chlebem.'),
(22, 'Mannaczi', 946, 4, 'Śniadanie', 'W rondelku umieść mleko oraz kaszę. Zagotuj mleko stale\r\nmieszając. Gdy kasza zacznie gęstnieć ściągnij rondel z ognia\r\ni delikatnie wystudź. Dodaj odżywkę białkową i wymieszaj. Przełóż\r\nkaszę do miski dodaj owoce i orzechy lub masło orzechowe.'),
(23, 'Sałatka grecka\r\n', 478, 4, 'Przekąska', 'Sałatę rwiemy na kawałki i mieszamy z oliwkami, pokrojonym pomidorem, ogórkiem, cebulą i serem. Całość polewamy oliwą z oliwek i sokiem z cytryny, przyprawiamy solą, pieprzem i oregano i mieszamy. Podajemy z chlebem.'),
(24, 'Kurczak chrupiący\r\n', 921, 4, 'Obiad', 'Kurczaka kroimy w kostkę. Do jogurtu dodajemy pieprz i sól, mieszamy, a następnie dodajemy kurczaka. Zostawiamy na kilka minut. W międzyczasie płatki kukurydziane ugniatamy widelcem albo mielimy w młynku po czym panierujemy w nich kurczaka. Smażymy na rozgrzanym tłuszczu i podajemy z ugotowanym według przepisu na opakowaniu ryżem.'),
(25, 'Pieczona owsianka', 790, 4, 'Podwieczorek', 'Wszystkie składniki poza owocami umieść w misce i bardzo\r\ndokładnie wymieszaj (lub zmiksuj). Dodaj owoce. Masę przełóż do\r\nprostokątnej foremki do pieczenia (20x10 cm) i posyp wiórkami\r\nkokosowymi. Piecz 25 minut w 175 stopniach.'),
(26, 'Kanapki z szynką z indyka i warzywami\r\n', 362, 4, 'Kolacja', 'Chleb smarujemy masłem, dodajemy kolejno sałatę, szynkę i pokrojonego ogórka'),
(27, 'Jabłuszka w cieście', 806, 5, 'Śniadanie', ' Myjemy jabłka i obieramy ze skóry. Kroimy w średniej wielkości plastry. Przygotowujemy ciasto o konsystencji gęstej od ciasta na naleśniki dodając szczyptę cynamonu. Smażymy wszystko na rozgrzanym oleju. Odsączamy zbędny tłuszcz kładąc jabłka w cieście na ręcznikach papierowych i posypujemy mieszanką cukru pudru z cynamonem.'),
(28, 'Placuszki bananowe', 625, 5, 'Przekąska', 'Banany rozgnieść w misce widelcem. Dodać jajka i mąkę, dokładnie wymieszać. Smażyć na niewielkiej ilości oleju.'),
(29, 'Makaron z gorgonzolą', 1296, 5, 'Obiad', 'Makaron gotujemy al dente, nim się zagotuje delikatnie podgrzewamy na patelni pokrojoną w kostkę gruszkę. Do odcedzonego makaronu wrzucamy ser, gruszki i posiekane orzechy włoskie.'),
(30, 'Pieczone bataty', 583, 5, 'Podwieczorek', 'Bataty obrać i pokroić w cienkie słupki. Zmieszać z sokiem z cytryny i z oliwą, doprawić solą i pieprzem. Nieobrane ząbki czosnku rozgnieść nożem i położyć z batatami na blasze. Piec na blasze wyłożonej papierem do pieczenia w temp. 180 stopni przez około 40 minut, aż będą miękkie.'),
(31, 'Zapiekanka z grahamki', 732, 5, 'Kolacja', 'Grahamkę kroimy na pół, smarujemy margaryną każdą połowę, kładziemy po plasterku szynki a następnie posypujemy startym żółtym serem. Pieczemy w piekarniku aż ser się roztopi a bułka będzie chrupiąca. Można posmarować keczupem.'),
(32, 'Jaglanka z bananem, amarantusem i rodzynkami\r\n', 545, 6, 'Przekąska', 'Rodzynki płuczemy na sitku zimną wodą, następnie przelewamy wrzątkiem. Całość wsypujemy do miski i zalewamy mlekiem'),
(33, 'Naleśnik z dżemem', 1384, 6, 'Obiad', 'Składniki miksujemy z dodatkiem odrobiny wody (do uzyskania odpowiedniej konsystencji, pozwalającej na wylanie zawartości na patelnię) i smażymy całość na średnim ogniu na oleju. W efekcie otrzymujemy jeden gruby naleśnik. Po przełożeniu na talerz smarujemy dżemem niskosłodzonym - proponujemy morelowy, ale świetnie sprawdzi się każdy niskosłodzony dżem.'),
(34, 'Dorsz gotowany na parze z brokułem\r\n', 521, 6, 'Podwieczorek', 'Dorsza solimy i okładamy plastrami pokrojonej cytryny. Brokuła solimy i gotujemy na parze razem z dorszem przez ok. 20 - 25 minut. Kaszę jaglaną płuczemy pod zimną, bieżącą wodą, a następnie przelewamy wrzątkiem. Gotujemy w posolonej wodzie w proporcjach 1:2,5 (kasza:woda) przez ok. 15 minut. Podajemy na talerzu, posypane sezamem. Brokuła polewamy oliwą z oliwek.'),
(35, 'Makaron ryżowy z łososiem i szpinakiem\r\n', 860, 6, 'Kolacja', 'Pokrojone w paski suszone pomidory i łososia smażymy na patelni na oleju razem ze szpinakiem. Obok przygotowujemy makaron ryżowy według przepisu na opakowaniu. Na talerzu wykładamy makaron, następnie łososia z warzywami. Całość posypujemy natką pietruszki.');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `product`
--

CREATE TABLE `product` (
  `id_prod` int(11) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `calories_per_100g` decimal(5,2) NOT NULL,
  `proteins_per_100g` decimal(5,2) NOT NULL,
  `carbs_per_100g` decimal(5,2) NOT NULL,
  `fats_per_100g` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id_prod`, `product_name`, `calories_per_100g`, `proteins_per_100g`, `carbs_per_100g`, `fats_per_100g`) VALUES
(1, 'Banan', 97.00, 1.00, 23.50, 0.30),
(2, 'Pierś z kurczaka', 98.00, 21.50, 0.00, 1.30),
(3, 'Ryż biały', 344.00, 6.70, 78.90, 0.70),
(4, 'Ryż brązowy', 119.00, 3.40, 22.80, 1.10),
(5, 'Jajko', 139.00, 12.50, 0.60, 9.70),
(6, 'Mleko 3,2%', 61.00, 3.30, 4.80, 3.20),
(7, 'Mleko 2%', 51.00, 3.40, 4.90, 2.00),
(8, 'Mleko 1,5%', 39.00, 3.60, 2.70, 1.50),
(9, 'Mleko 0.5%', 37.00, 3.00, 5.00, 0.50),
(10, 'Jabłko', 52.00, 0.40, 14.00, 0.40),
(11, 'Pomarańcza', 53.00, 0.90, 13.00, 0.30),
(12, 'Truskawki', 32.00, 0.67, 7.68, 0.30),
(13, 'Marchew', 41.00, 0.93, 9.58, 0.24),
(14, 'Brokuły', 34.00, 2.82, 7.00, 0.40),
(15, 'Wołowina', 250.00, 26.00, 0.00, 18.00),
(16, 'Jogurt naturalny', 61.00, 3.50, 4.66, 3.25),
(17, 'Chleb razowy', 218.00, 5.90, 41.90, 1.30),
(18, 'Chleb biały', 265.00, 9.30, 54.30, 1.40),
(19, 'Makaron fusilli suchy', 359.00, 12.00, 71.00, 2.00),
(20, 'Makaron penne suchy', 353.00, 13.00, 69.00, 2.00),
(21, 'Makaron pełnoziarnisty suchy', 348.00, 14.63, 75.03, 1.40),
(22, 'Makaron ryżowy suchy', 364.00, 5.95, 80.18, 0.56),
(23, 'Kasza gryczana sucha', 344.00, 13.50, 69.94, 3.12),
(24, 'Kasza jęczmienna sucha', 335.00, 7.40, 68.80, 2.20),
(25, 'Ziemniaki gotowane', 70.00, 0.90, 17.00, 0.20),
(26, 'Sałata masłowa', 13.00, 1.35, 2.23, 0.22),
(27, 'Pomidor', 19.00, 0.88, 4.10, 0.20),
(28, 'Ogórek', 15.00, 0.70, 2.90, 0.11),
(29, 'Cebula', 33.00, 1.40, 6.90, 0.40),
(30, 'Czosnek', 152.00, 6.40, 32.66, 0.50),
(31, 'Czekolada gorzka 80 %', 497.00, 10.00, 20.00, 41.28),
(32, 'Czekolada mleczna', 545.00, 6.70, 54.00, 33.00),
(33, 'Masło', 748.00, 0.70, 0.70, 82.50),
(34, 'Oliwa z oliwek', 897.00, 0.00, 0.20, 99.60),
(35, 'Sok pomarańczowy', 43.00, 0.70, 8.90, 0.00),
(36, 'Sok jabłkowy', 42.00, 0.10, 10.00, 0.00),
(37, 'Woda mineralna', 0.00, 0.00, 0.00, 0.00),
(38, 'Herbata czarna', 1.00, 0.10, 0.00, 0.30),
(39, 'Kawa rozpuszczalna', 85.00, 7.20, 21.93, 1.00),
(40, 'Orzechy włoskie', 649.00, 14.00, 11.00, 63.00),
(41, 'Orzechy laskowe', 677.00, 17.00, 14.90, 63.00),
(42, 'Migdały', 604.00, 24.10, 20.50, 52.00),
(43, 'Pistacje', 605.00, 26.50, 10.30, 49.20),
(44, 'Nerkowce', 597.00, 17.00, 24.00, 47.00),
(45, 'Sezam', 573.00, 17.73, 23.45, 49.67),
(46, 'Słonecznik', 577.00, 24.00, 19.00, 44.00),
(47, 'Dynia', 33.00, 1.30, 7.70, 0.30),
(48, 'Dynia piżmowa', 45.00, 1.00, 11.69, 0.10),
(49, 'Awokado', 160.00, 2.00, 7.40, 15.30),
(50, 'Ananas', 55.00, 0.40, 13.60, 0.20),
(51, 'Winogrona', 71.00, 0.50, 18.20, 0.20),
(52, 'Brzoskwinia', 50.00, 1.00, 11.90, 0.20),
(53, 'Gruszka', 58.00, 0.60, 14.40, 0.20),
(54, 'Maliny', 43.00, 1.30, 12.00, 0.30),
(55, 'Borówki', 59.00, 0.90, 15.20, 0.30),
(56, 'Białko jajka kurzego', 48.00, 10.90, 0.70, 0.20),
(57, 'Płatki owsiane', 373.00, 13.00, 68.00, 6.90),
(58, 'Budyń waniliowy bez cukru', 95.00, 2.90, 17.00, 1.80),
(59, 'Odżywka białkowa', 390.00, 76.00, 8.00, 6.33),
(60, 'Słodzik pastylki', 50.00, 1.50, 55.00, 0.00),
(61, 'Proszek do pieczenia', 115.00, 3.90, 23.00, 0.60),
(62, 'Sól kuchenna', 0.00, 0.00, 0.00, 0.00),
(63, 'Toritlla', 296.00, 7.60, 54.00, 5.20),
(64, 'Ser żółty', 262.00, 29.50, 0.10, 16.00),
(65, 'Rukola', 26.00, 3.80, 0.80, 0.50),
(66, 'Kukurydza', 120.00, 3.00, 21.80, 1.40),
(67, 'Ketchup', 99.00, 1.30, 22.00, 0.50),
(68, 'Pieprz czarny', 251.00, 10.39, 63.95, 3.26),
(69, 'Szynka wieprzowa', 147.00, 20.00, 1.00, 7.00),
(70, 'Nasiona chia', 456.00, 20.00, 0.70, 34.00),
(71, 'Kakao', 459.00, 18.20, 50.60, 21.70),
(72, 'Masło orzechowe', 596.00, 27.00, 14.00, 46.00),
(73, 'Kapusta kiszona', 12.00, 1.10, 3.40, 0.20),
(74, 'Papryka czerwona', 32.00, 1.30, 6.60, 0.50),
(75, 'Olej rzepakowy', 900.00, 0.00, 0.00, 100.00),
(76, 'Mleko ryżowe', 48.00, 0.50, 9.70, 1.00),
(77, 'Mąka ryżowa', 349.00, 7.60, 76.90, 0.70),
(78, 'Drożdże piekarskie', 92.00, 11.30, 14.50, 2.00),
(79, 'Cynamon', 247.00, 4.00, 28.00, 1.24),
(80, 'Serek homogenizowany naturalny', 117.00, 10.00, 4.70, 6.50),
(81, 'Miód pszczeli', 324.00, 0.30, 79.50, 0.00);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `składposiłku`
--

CREATE TABLE `składposiłku` (
  `id` int(11) NOT NULL,
  `id_posiłku` int(11) NOT NULL,
  `id_produktu` int(11) NOT NULL,
  `nazwa_produktu` varchar(100) DEFAULT NULL,
  `typ` varchar(20) DEFAULT NULL,
  `ilosc` decimal(10,2) DEFAULT NULL,
  `jednostka` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `składposiłku`
--

INSERT INTO `składposiłku` (`id`, `id_posiłku`, `id_produktu`, `nazwa_produktu`, `typ`, `ilosc`, `jednostka`) VALUES
(1, 1, 56, 'Białko jajka kurzego', 'składnik główny', 350.00, 'g'),
(2, 1, 57, 'Płatki owsiane', 'składnik główny', 150.00, 'g'),
(3, 1, 1, 'Banan', 'dodatek', 1.00, 'szt.'),
(4, 1, 16, 'Jogurt naturalny', 'dodatek', 80.00, 'g'),
(5, 1, 58, 'Budyń waniliowy bez cukru', 'składnik główny', 35.00, 'g'),
(6, 1, 59, 'Odżywka białkowa', 'składnik główny', 40.00, 'g'),
(7, 1, 60, 'Słodzik pastylki', 'składnik główny', 5.00, 'szt.'),
(8, 1, 62, 'Sól kuchenna', 'składnik główny', 0.25, 'g'),
(9, 1, 61, 'Proszek do pieczenia', 'składnik główny', 2.00, 'g'),
(10, 8, 55, 'Borówki', 'składnik główny', 400.00, 'g'),
(11, 7, 57, 'Płatki owsiane', 'składnik główny', 40.00, 'g'),
(12, 7, 16, 'Jogurt naturalny', 'składnik główny', 150.00, 'g'),
(13, 7, 70, 'Nasiona chia', 'składnik główny', 10.00, 'g'),
(14, 7, 1, 'Banan', 'składnik główny', 1.00, 'szt.'),
(15, 7, 71, 'Kakao', 'składnik główny', 3.00, 'g'),
(16, 7, 72, 'Masło orzechowe', 'składnik główny', 10.00, 'g'),
(17, 9, 73, 'Kapusta kiszona', 'składnik główny', 200.00, 'g'),
(18, 9, 2, 'Pierś z kurczaka', 'składnik główny', 100.00, 'g'),
(19, 9, 74, 'Papryka czerwona', 'składnik główny', 60.00, 'g'),
(20, 9, 23, 'Kasza gryczana sucha', 'składnik główny', 60.00, 'g'),
(21, 9, 29, 'Cebula', 'składnik główny', 30.00, 'g'),
(22, 9, 75, 'Olej rzepakowy', 'składnik główny', 10.00, 'g'),
(23, 10, 10, 'Jabłko', 'składnik główny', 150.00, 'g'),
(26, 10, 76, 'Mleko ryżowe', 'składnik główny', 125.00, 'ml'),
(27, 10, 77, 'Mąka ryżowa', 'składnik główny', 100.00, 'g'),
(28, 10, 78, 'Drożdże piekarskie', 'składnik główny', 15.00, 'g'),
(29, 10, 75, 'Olej rzepakowy', 'składnik główny', 15.00, 'g'),
(30, 10, 79, 'Cynamon', 'składnik główny', 5.00, 'g'),
(31, 11, 80, 'Serek homogenizowany naturalny', 'składnik główny', 200.00, 'g'),
(32, 11, 52, 'Brzoskwinia', 'składnik główny', 85.00, 'g'),
(33, 11, 81, 'Miód pszczeli', 'składnik główny', 12.00, 'g'),
(34, 11, 57, 'Płatki owsiane', 'składnik główny', 10.00, 'g');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `imie` varchar(50) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `weight` decimal(5,2) DEFAULT NULL,
  `height` decimal(5,2) DEFAULT NULL,
  `activity_level_1-5` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_user`, `imie`, `username`, `email`, `password`, `age`, `weight`, `height`, `activity_level_1-5`) VALUES
(1, 'Test', 'test123', 'test@example.com', 'test123', 30, 75.50, 180.00, '4');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `dietuser`
--
ALTER TABLE `dietuser`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_plan` (`id_plan`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeksy dla tabeli `plan`
--
ALTER TABLE `plan`
  ADD PRIMARY KEY (`id_plan`);

--
-- Indeksy dla tabeli `posilek`
--
ALTER TABLE `posilek`
  ADD PRIMARY KEY (`id_posiłku`),
  ADD KEY `plan_id` (`plan_id`);

--
-- Indeksy dla tabeli `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id_prod`);

--
-- Indeksy dla tabeli `składposiłku`
--
ALTER TABLE `składposiłku`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_posiłku` (`id_posiłku`),
  ADD KEY `id_produktu` (`id_produktu`);

--
-- Indeksy dla tabeli `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dietuser`
--
ALTER TABLE `dietuser`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `plan`
--
ALTER TABLE `plan`
  MODIFY `id_plan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `posilek`
--
ALTER TABLE `posilek`
  MODIFY `id_posiłku` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id_prod` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `składposiłku`
--
ALTER TABLE `składposiłku`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `dietuser`
--
ALTER TABLE `dietuser`
  ADD CONSTRAINT `dietuser_ibfk_1` FOREIGN KEY (`id_plan`) REFERENCES `plan` (`id_plan`) ON DELETE CASCADE,
  ADD CONSTRAINT `dietuser_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `posilek`
--
ALTER TABLE `posilek`
  ADD CONSTRAINT `posilek_ibfk_1` FOREIGN KEY (`plan_id`) REFERENCES `plan` (`id_plan`) ON DELETE CASCADE;

--
-- Constraints for table `składposiłku`
--
ALTER TABLE `składposiłku`
  ADD CONSTRAINT `składposiłku_ibfk_1` FOREIGN KEY (`id_posiłku`) REFERENCES `posilek` (`id_posiłku`) ON DELETE CASCADE,
  ADD CONSTRAINT `składposiłku_ibfk_2` FOREIGN KEY (`id_produktu`) REFERENCES `product` (`id_prod`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
