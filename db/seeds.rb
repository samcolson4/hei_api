require 'json'

episodes_json = <<-JSON
[
{"episode_url":"https://heinetwork.tv/episode/valiant-one-dog-man/","collection":"Season 15","episode_title":"'Valiant One' & 'Dog Man'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2025/01/on_cinema_s15_ep06.png","aired_at":"2025-01-29T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/babygirl-nosferatu/","collection":"Season 15","episode_title":"'Babygirl' & 'Nosferatu'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2024/12/welcome-to-movie-house.jpg","aired_at":"2024-12-25T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-damned-wallace-gromit-vengeance-most-fowl/","collection":"Season 15","episode_title":"'The Damned' & 'Wallace & Gromit: Vengeance Most Fowl'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2024/12/on_cinema_s15_ep02.png","aired_at":"2025-01-01T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/den-of-thieves-2-pantera-better-man/","collection":"Season 15","episode_title":"'Den of Thieves 2: Pantera' & 'Better Man'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2025/01/on_cinema_s15_e03.webp","aired_at":"2025-01-08T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/one-of-them-days-wolf-man/","collection":"Season 15","episode_title":"'One of Them Days' & 'Wolf Man'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2025/01/on_cinema_s15_ep04.png","aired_at":"2025-01-15T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/night-swim-weak-layers/","collection":"Season 14","episode_title":"'Night Swim' & 'Weak Layers'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2024/01/1401ThumbnailV1.jpg","aired_at":"2024-01-03T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-book-of-clarence-mean-girls/","collection":"Season 14","episode_title":"'The Book of Clarence' & 'Mean Girls'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2024/01/1402-thumb-2.jpg","aired_at":"2024-01-10T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/founders-day-i-s-s/","collection":"Season 14","episode_title":"'Founders Day' & 'I.S.S.'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2024/01/1403_Thumbnail.jpg","aired_at":"2024-01-17T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/sometimes-i-think-about-dying-the-underdoggs/","collection":"Season 14","episode_title":"'Sometimes I Think About Dying' & 'The Underdoggs'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2024/01/s14e04-t-1.jpg","aired_at":"2024-01-24T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/argylle-the-promised-land/","collection":"Season 14","episode_title":"'Argylle' & 'The Promised Land'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2024/01/1405_thumb.jpg","aired_at":"2024-01-25T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/it-ends-with-us/","collection":"Season 14","episode_title":"'It Ends With Us'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2024/02/1406-thumb-v3.jpg","aired_at":"2024-02-07T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/madame-web-bob-marley-one-love/","collection":"Season 14","episode_title":"'Madame Web' & 'Bob Marley: One Love'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2024/02/1407t.jpg","aired_at":"2024-02-14T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/drive-away-dolls/","collection":"Season 14","episode_title":"'Drive-Away Dolls'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2024/02/1408_th.jpg","aired_at":"2024-02-21T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/dune-part-two/","collection":"Season 14","episode_title":"'Dune: Part Two'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2024/02/1409thumbnail.jpg","aired_at":"2024-02-28T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/kung-fu-panda-4-imaginary/","collection":"Season 14","episode_title":"'Kung Fu Panda 4' & 'Imaginary'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2024/03/r_hyfnQX.jpeg","aired_at":"2024-02-29T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/season-14-wrap-party/","collection":"Season 14","episode_title":"Season 14 Wrap Party","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2024/04/s14-wrap.jpg","aired_at":"2024-04-07T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/1st-annual-on-cinema-oscar-special/","collection":"Oscar Specials","episode_title":"1st Annual On Cinema Oscar Special","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/oscar-1.jpg","aired_at":"2013-02-26T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/2nd-annual-on-cinema-oscar-special/","collection":"Oscar Specials","episode_title":"2nd Annual On Cinema Oscar Special","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/oscar-2.jpg","aired_at":"2014-03-03T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/3rd-annual-on-cinema-oscar-special/","collection":"Oscar Specials","episode_title":"3rd Annual On Cinema Oscar Special","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/oscar-3.jpg","aired_at":"2015-02-23T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/4th-annual-on-cinema-oscar-special/","collection":"Oscar Specials","episode_title":"4th Annual On Cinema Oscar Special","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/oscar-4.jpg","aired_at":"2016-02-29T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/our-cinema-oscar-special/","collection":"Oscar Specials","episode_title":"Our Cinema Oscar Special","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/oscar-our.jpg","aired_at":"2017-02-27T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/5th-annual-on-cinema-oscar-special/","collection":"Oscar Specials","episode_title":"5th Annual On Cinema Oscar Special","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/oscar-5.jpg","aired_at":"2018-03-05T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-new-on-cinema-oscar-special/","collection":"Oscar Specials","episode_title":"The New On Cinema Oscar Special","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/oscar-6.jpg","aired_at":"2019-02-24T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/7th-annual-on-cinema-oscar-special/","collection":"Oscar Specials","episode_title":"7th Annual On Cinema Oscar Special","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/oscar-7.jpg","aired_at":"2020-02-09T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/8th-annual-on-cinema-oscar-special/","collection":"Oscar Specials","episode_title":"8th Annual On Cinema Oscar Special","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/05/ocos8-screen.jpg","aired_at":"2021-04-25T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/9th-annual-on-cinema-oscar-special/","collection":"Oscar Specials","episode_title":"9th Annual On Cinema Oscar Special","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/03/os9-thumb.jpg","aired_at":"2022-03-27T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/10th-annual-on-cinema-oscar-special/","collection":"Oscar Specials","episode_title":"10th Annual On Cinema Oscar Special","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2023/02/Screen-Shot-2023-03-12-at-11.55.02-PM.png","aired_at":"2023-03-12T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/11th-annual-on-cinema-oscar-special/","collection":"Oscar Specials","episode_title":"11th Annual On Cinema Oscar Special","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2024/03/GFwGM6ZbYAA5cI0-copy.jpeg","aired_at":"2024-03-10T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/prey-for-the-devil/","collection":"Season 13","episode_title":"'Prey for the Devil'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/10/s13e1-thumb.jpg","aired_at":"2022-10-26T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/my-policeman-enola-holmes-2/","collection":"Season 13","episode_title":"'My Policeman' & 'Enola Holmes 2'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/11/ep2-thumb.jpg","aired_at":"2022-11-02T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/black-panther-wakanda-forever-the-fabelmans/","collection":"Season 13","episode_title":"'Black Panther: Wakanda Forever' & 'The Fabelmans'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/11/s12ep3_thumb_fix.jpg","aired_at":"2022-11-09T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-menu-the-santa-clauses/","collection":"Season 13","episode_title":"'The Menu' & 'The Santa Clauses'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/11/s13e4_thumb2.jpg","aired_at":"2022-11-16T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/devotion-strange-world/","collection":"Season 13","episode_title":"'Devotion' & 'Strange World'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/11/s13e5-thumb.jpg","aired_at":"2022-11-23T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/scrooge-a-christmas-carol-violent-night/","collection":"Season 13","episode_title":"'Scrooge: A Christmas Carol' & 'Violent Night'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/11/s13e6-a98.jpg","aired_at":"2022-11-30T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/pinocchio-something-from-tiffanys/","collection":"Season 13","episode_title":"'Pinocchio' & 'Something from Tiffany's'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/12/s13e7-thumb.jpg","aired_at":"2022-12-07T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/a-man-called-otto-avatar-the-way-of-water/","collection":"Season 13","episode_title":"'A Man Called Otto' & 'Avatar: The Way of Water'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/12/s13e8-thumbnail.jpg","aired_at":"2022-12-14T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/on-cinema-in-the-morning-christmas-special/","collection":"Season 13","episode_title":"On Cinema And More In The Morning Christmas Special","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/12/s13e9-thumb.jpg","aired_at":"2022-12-21T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/alice-darling/","collection":"Season 13","episode_title":"'Alice, Darling'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/12/s13e10-g.jpg","aired_at":"2022-12-28T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/m3gan-the-amazing-maurice/","collection":"Season 13","episode_title":"'M3GAN' & 'The Amazing Maurice'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2023/01/s13e11-thumb.jpg","aired_at":"2023-01-04T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/season-13-wrap-party/","collection":"Season 13","episode_title":"Season 13 Wrap Party","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2024/04/s12-wrap.jpg","aired_at":"2023-01-27T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/xposed-episode-1/","collection":"Xposed","episode_title":"Xposed - Episode 1","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/11/xposed-thumb.jpg","aired_at":"2021-11-17T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/xposed-episode-2/","collection":"Xposed","episode_title":"Xposed - Episode 2","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/01/xposed-ep-2-thumb.jpg","aired_at":"2022-01-26T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/xposed-episode-3/","collection":"Xposed","episode_title":"Xposed - Episode 3","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/02/xposed-3-thumb.jpg","aired_at":"2022-02-02T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/xposed-episode-4/","collection":"Xposed","episode_title":"Xposed - Episode 4","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/02/x4-thumbnail.jpg","aired_at":"2022-02-09T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/xposed-episode-5/","collection":"Xposed","episode_title":"Xposed - Episode 5","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/02/xposed5-thumb.jpg","aired_at":"2022-02-23T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/mass-no-time-to-die/","collection":"Season 12","episode_title":"'Mass' & 'No Time To Die'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/10/s12e1-thumb.jpg","aired_at":"2021-10-06T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/halloween-kills-the-last-duel/","collection":"Season 12","episode_title":"'Halloween Kills' & 'The Last Duel'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/10/S2e12-thumb.jpg","aired_at":"2021-10-13T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/dune-the-french-dispatch/","collection":"Season 12","episode_title":"'Dune' & 'The French Dispatch'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/10/ep3-thumb.jpg","aired_at":"2021-10-20T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/last-night-in-soho-antlers/","collection":"Season 12","episode_title":"'Last Night in Soho' & 'Antlers'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/10/e4-thumb.jpg","aired_at":"2021-10-27T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-harder-they-fall-eternals/","collection":"Season 12","episode_title":"'The Harder They Fall' & 'Eternals'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/11/ep5-thumb.jpg","aired_at":"2021-11-03T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/red-notice-ghostbusters-afterlife/","collection":"Season 12","episode_title":"'Red Notice' & 'Ghostbusters: Afterlife'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/11/ep6-thumb.jpg","aired_at":"2021-11-10T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/top-gun-maverick-king-richard/","collection":"Season 12","episode_title":"'Top Gun: Maverick' & 'King Richard'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/11/ep7_thumb.jpg","aired_at":"2021-11-17T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/house-of-gucci-resident-evil-welcome-to-raccoon-city/","collection":"Season 12","episode_title":"'House of Gucci' & 'Resident Evil: Welcome to Raccoon City'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/11/ep8-thumb.jpg","aired_at":"2021-11-24T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/nightmare-alley/","collection":"Season 12","episode_title":"'Nightmare Alley'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/12/ep9-thumb.jpg","aired_at":"2021-12-01T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/american-underdog/","collection":"Season 12","episode_title":"'American Underdog'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/12/ep10-thumb.jpg","aired_at":"2021-12-08T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/rock-house-pilot-episode/","collection":"Heilots","episode_title":"Rock House - Heilot","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/07/rock_house_thumb.jpg","aired_at":"2021-07-14T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/xposed-heilot/","collection":"Heilots","episode_title":"Xposed - Heilot","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/11/xposed-thumb.jpg","aired_at":"2021-11-17T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/popcorn-shuffle-heilot/","collection":"Heilots","episode_title":"Popcorn Shuffle - Heilot","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/11/popcorn-shuffle-thumb.jpg","aired_at":"2021-11-24T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/marks-cavalcade-of-characters-heilot/","collection":"Heilots","episode_title":"Mark's Cavalcade of Characters - Heilot","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/12/cavalcade-thumb.jpg","aired_at":"2021-12-01T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/abominable-judy/","collection":"Season 11","episode_title":"'Abominable' & 'Judy'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s11e1.jpg","aired_at":"2019-09-25T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/joker-the-current-war/","collection":"Season 11","episode_title":"'Joker' & 'The Current War'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s11e2.jpg","aired_at":"2019-10-02T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/gemini-man-the-addams-family/","collection":"Season 11","episode_title":"'Gemini Man' & 'The Addams Family'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s11e3.jpg","aired_at":"2019-10-09T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/mister-america-maleficent-mistress-of-evil/","collection":"Season 11","episode_title":"'Mister America' & 'Maleficent: Mistress of Evil'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s11e4.jpg","aired_at":"2019-10-16T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/black-and-blue-the-last-full-measure/","collection":"Season 11","episode_title":"'Black and Blue' & 'The Last Full Measure'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s11e5.jpg","aired_at":"2019-10-23T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/terminator-dark-fate-motherless-brooklyn/","collection":"Season 11","episode_title":"'Terminator: Dark Fate' & 'Motherless Brooklyn'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s11e6.jpg","aired_at":"2019-10-30T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/midway-arctic-dogs/","collection":"Season 11","episode_title":"'Midway' & 'Arctic Dogs'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s11e7.jpg","aired_at":"2019-11-06T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/charlies-angels-the-report/","collection":"Season 11","episode_title":"'Charlie's Angels' & 'The Report'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s11e8.jpg","aired_at":"2019-11-13T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/on-cinema-debt-forgiveness-special/","collection":"Season 11","episode_title":"On Cinema Debt Forgiveness Special","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s11e9.jpg","aired_at":"2019-11-20T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/knives-out-queen-slim/","collection":"Season 11","episode_title":"'Knives Out' & 'Queen & Slim'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s11e10.jpg","aired_at":"2019-11-27T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/trial-of-tim-heidecker-day-1/","collection":"The Trial of Tim Heidecker","episode_title":"The Trial of Tim Heidecker - Day 1","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/trial-1.jpg","aired_at":"2017-11-15T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/trial-of-tim-heidecker-day-2/","collection":"The Trial of Tim Heidecker","episode_title":"The Trial of Tim Heidecker - Day 2","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/trial-2.jpg","aired_at":"2017-11-16T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/trial-of-tim-heidecker-day-3/","collection":"The Trial of Tim Heidecker","episode_title":"The Trial of Tim Heidecker - Day 3","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/trial-3.jpg","aired_at":"2017-11-17T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/trial-of-tim-heidecker-day-4/","collection":"The Trial of Tim Heidecker","episode_title":"The Trial of Tim Heidecker - Day 4","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/trial-4.jpg","aired_at":"2017-11-20T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/trial-of-tim-heidecker-day-5/","collection":"The Trial of Tim Heidecker","episode_title":"The Trial of Tim Heidecker - Day 5","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/trial-5.jpg","aired_at":"2017-11-21T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/trial-of-tim-heidecker-verdict/","collection":"The Trial of Tim Heidecker","episode_title":"The Trial of Tim Heidecker - Verdict","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/trial-verdict.jpg","aired_at":"2017-11-28T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-trial-of-tim-heidecker-full/","collection":"The Trial of Tim Heidecker","episode_title":"The Trial of Tim Heidecker","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/08/trial_cover.jpg","aired_at":"2017-11-14T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/vfa-acquisition-announcement/","collection":"Bonus Content","episode_title":"VFA Acquisition Announcement","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/05/vfa_acquisition.jpg","aired_at":"2021-04-30T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/on-cinema-summer-preview/","collection":"Bonus Content","episode_title":"2021 On Cinema Summer Preview (Audio Only)","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/05/hei_summer_preview_thumb.jpg","aired_at":"2021-05-28T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/gregg-turkingtons-classic-movie-time-episode-1/","collection":"Bonus Content","episode_title":"Gregg Turkington's Classic Movie Time - Episode 1","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/06/cmt_cov-er.jpg","aired_at":"2021-06-02T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/on-cinema-live-trailer/","collection":"Bonus Content","episode_title":"On Cinema Live Trailer","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/06/joe_live.jpg","aired_at":"2021-06-02T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/gregg-turkingtons-classic-movie-time-episode-2/","collection":"Bonus Content","episode_title":"Gregg Turkington's Classic Movie Time - Episode 2","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/06/national-security.jpg","aired_at":"2021-06-09T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/on-cinema-live/","collection":"Bonus Content","episode_title":"On Cinema Live","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/06/live-show-thumb.jpg","aired_at":"2021-06-16T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/gregg-turkingtons-classic-movie-time-episode-3/","collection":"Bonus Content","episode_title":"Gregg Turkington's Classic Movie Time - Episode 3","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/06/cmt3-full.jpg","aired_at":"2021-06-23T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/rock-house-trailer/","collection":"Bonus Content","episode_title":"Rock House (Trailer)","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/07/vlcsnap-2021-07-12-13h47m51s419.jpg","aired_at":"2021-07-11T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/introducing-hei-points/","collection":"Bonus Content","episode_title":"Introducing HEI Points","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/09/Screen-Shot-2021-09-22-at-11.08.33-AM-2.jpg","aired_at":"2021-09-22T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/deck-of-cards-teaser/","collection":"Bonus Content","episode_title":"Deck of Cards - Teaser","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/11/deck_thumb.jpg","aired_at":"2021-11-17T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/d4-my-angel-official-video/","collection":"Bonus Content","episode_title":"D4 - My Angel (Official Video)","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/12/my-angel-thumb.jpg","aired_at":"2021-12-08T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/wendy-kerby-valentines-day-special-promo/","collection":"Bonus Content","episode_title":"Wendy Kerby Valentine's Day Special Promo","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/02/wendy-promo-cover.jpg","aired_at":"2022-01-31T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-wendy-kerby-valentines-day-special/","collection":"Bonus Content","episode_title":"The Wendy Kerby Valentine's Day Special","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/02/wkvd-thumb.jpg","aired_at":"2022-02-14T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/dekkar-volume-1/","collection":"Bonus Content","episode_title":"Dekkar (Volume 1)","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/04/dekkar-v1-thumb.jpg","aired_at":"2022-04-27T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/dekkar-volume-2/","collection":"Bonus Content","episode_title":"Dekkar (Volume 2)","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/05/D2-thumb.jpg","aired_at":"2022-05-20T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/2022-on-cinema-summer-preview/","collection":"Bonus Content","episode_title":"2022 On Cinema Summer Preview (Audio Only)","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/05/summer_22_thumb.jpg","aired_at":"2022-05-23T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/popcorn-classics-part-1/","collection":"Bonus Content","episode_title":"Popcorn Classics (Part 1)","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/06/pc_cover.jpg","aired_at":"2022-06-10T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/deck-of-cards-teaser-trailer/","collection":"Bonus Content","episode_title":"Deck of Cards - Teaser Trailer","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/06/doc_cover.jpg","aired_at":"2022-06-21T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/popcorn-classics-part-2/","collection":"Bonus Content","episode_title":"Popcorn Classics (Part 2)","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/07/popcorn_cover_2.jpg","aired_at":"2022-07-06T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/behind-the-cards/","collection":"Bonus Content","episode_title":"Behind The Cards","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/06/doc_cover.jpg","aired_at":"2022-07-26T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/deck-of-cards/","collection":"Bonus Content","episode_title":"Deck of Cards","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/09/doc_thumb_2.jpg","aired_at":"2022-09-02T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/deck-of-cards-what-went-wrong/","collection":"Bonus Content","episode_title":"Deck of Cards: What Went Wrong?","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/10/doc_www_thumb.jpg","aired_at":"2022-10-12T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/10th-annual-oscar-special-teaser/","collection":"Bonus Content","episode_title":"10th Annual Oscar Special Teaser","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2023/02/10th_teaser_thumb.jpg","aired_at":"2023-02-24T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/an-important-message-from-actor-joe-estevez/","collection":"Bonus Content","episode_title":"An Important Message From Actor Joe Estevez","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2023/03/joe_message_thumb.jpg","aired_at":"2023-03-03T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/pinocchio-through-the-years/","collection":"Bonus Content","episode_title":"Pinocchio Through The Years","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2023/03/pinocchio_thumb.jpg","aired_at":"2023-03-16T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/vfa-expert-hollywood-tour/","collection":"Bonus Content","episode_title":"VFA Expert Hollywood Tour","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2023/05/vfa_tour_thumb.jpg","aired_at":"2023-05-19T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/2023-on-cinema-summer-movie-recap/","collection":"Bonus Content","episode_title":"2023 On Cinema Summer Movie Recap (Audio Only)","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2022/12/s13e10-g.jpg","aired_at":"2023-09-11T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/our-cinema-movie-birthdays-episode-1/","collection":"Bonus Content","episode_title":"Our Cinema Movie Birthdays - Episode 1","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2023/11/movie_birthdays_thumb.jpg","aired_at":"2023-11-03T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/our-cinema-movie-birthdays-episode-2/","collection":"Bonus Content","episode_title":"Our Cinema Movie Birthdays - Episode 2","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2023/11/movie_birthdays_thumb_2.jpg","aired_at":"2023-11-10T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/our-cinema-movie-birthdays-episode-3/","collection":"Bonus Content","episode_title":"Our Cinema Movie Birthdays - Episode 3","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2023/11/movie_birthdays_thumb_3.jpg","aired_at":"2023-11-17T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/our-cinema-movie-birthdays-episode-4/","collection":"Bonus Content","episode_title":"Our Cinema Movie Birthdays - Episode 4","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2023/11/movie_birthdays_thumb_4.jpg","aired_at":"2023-11-24T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/case-closed-breach-of-trust/","collection":"Bonus Content","episode_title":"Case Closed: Breach of Trust","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2023/12/caseclosed_thumb.jpg","aired_at":"2023-12-13T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/announcing-amatocon/","collection":"Bonus Content","episode_title":"Announcing AmatoCon","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2024/01/amatocon_thumb.jpg","aired_at":"2024-01-23T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-first-ever-film-buffs-movie-scavenger-hunt-on-line-event-teaser/","collection":"Bonus Content","episode_title":"The First Ever Film Buff's Movie Scavenger Hunt On-Line Event Teaser","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2024/06/Title-card.webp","aired_at":"2024-06-20T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/2024-on-cinema-summer-movie-recap-audio-only/","collection":"Bonus Content","episode_title":"2024 On Cinema Summer Movie Recap (Audio Only)","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2024/08/on-cinema-summer-movie-roundup-2024.webp","aired_at":"2024-08-14T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/pacific-rim-uprising-and-sherlock-gnomes/","collection":"Season 10","episode_title":"'Pacific Rim Uprising' and 'Sherlock Gnomes'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s10e1.jpg","aired_at":"2018-03-22T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/ready-player-one-and-tyler-perrys-acrimony/","collection":"Season 10","episode_title":"'Ready Player One' and 'Tyler Perry's Acrimony'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s10e2.jpg","aired_at":"2018-03-28T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/chappaquiddick-and-you-were-never-really-here/","collection":"Season 10","episode_title":"'Chappaquiddick' and 'You Were Never Really Here'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s10e3.jpg","aired_at":"2018-04-06T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/sgt-stubby-an-american-hero-and-overboard/","collection":"Season 10","episode_title":"'Sgt. Stubby: An American Hero' and 'Overboard'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s10e4.jpg","aired_at":"2018-04-12T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/rampage-and-super-troopers-2/","collection":"Season 10","episode_title":"'Rampage' and 'Super Troopers 2'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s10e5.jpg","aired_at":"2018-04-19T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/traffik/","collection":"Season 10","episode_title":"'Traffik'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s10e6.jpg","aired_at":"2018-04-26T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/avengers-infinity-war/","collection":"Season 10","episode_title":"'Avengers: Infinity War'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s10e7.jpg","aired_at":"2018-05-03T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/life-of-the-party-and-breaking-in/","collection":"Season 10","episode_title":"'Life of the Party' and 'Breaking In'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s10e8.jpg","aired_at":"2018-05-10T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/deadpool-2-and-show-dogs/","collection":"Season 10","episode_title":"'Deadpool 2' and 'Show Dogs'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s10e9.jpg","aired_at":"2018-05-17T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/solo-a-star-wars-movie/","collection":"Season 10","episode_title":"'Solo: A Star Wars Movie'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s10e10.jpg","aired_at":"2018-05-25T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/kong-skull-island-and-the-wall/","collection":"Season 9","episode_title":"'Kong: Skull Island' and 'The Wall'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s9e1.jpg","aired_at":"2017-03-06T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/t2-trainspotting-and-the-belko-experiment/","collection":"Season 9","episode_title":"'T2 Trainspotting' and 'The Belko Experiment'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s9e2.jpg","aired_at":"2017-03-13T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/chips-and-power-rangers/","collection":"Season 9","episode_title":"'Chips' and 'Power Rangers'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s9e3.jpg","aired_at":"2017-03-20T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/boss-baby-and-the-zookeepers-wife/","collection":"Season 9","episode_title":"'Boss Baby' and 'The Zookeeper's Wife'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s9e4.jpg","aired_at":"2017-03-27T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/smurfs-the-lost-village-and-the-case-for-christ/","collection":"Season 9","episode_title":"'Smurfs: The Lost Village' and 'The Case for Christ'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s9e5.jpg","aired_at":"2017-04-03T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/fast-and-furious-8-and-the-lost-city-of-z/","collection":"Season 9","episode_title":"'Fast and Furious 8' and 'The Lost City of Z'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s9e6.jpg","aired_at":"2017-04-10T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/unforgettable-animal-crackers-and-born-in-china/","collection":"Season 9","episode_title":"Unforgettable', 'Animal Crackers', and 'Born in China'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s9e7.jpg","aired_at":"2017-04-17T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-circle-and-how-to-be-a-latin-lover/","collection":"Season 9","episode_title":"'The Circle' and 'How to be a Latin Lover'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s9e8.jpg","aired_at":"2017-04-24T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/guardians-of-the-gallery-vol-2-and-the-lovers/","collection":"Season 9","episode_title":"'Guardians of the Gallery Vol. 2' and 'The Lovers'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s9e9.jpg","aired_at":"2017-05-01T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/king-arthur-and-snatched/","collection":"Season 9","episode_title":"'King Arthur' and 'Snatched'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s9e10.jpg","aired_at":"2017-05-08T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/star-trek-beyond-and-hillarys-america/","collection":"Season 8","episode_title":"'Star Trek Beyond' and 'Hillary's America'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s8e1.jpg","aired_at":"2016-07-27T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/cafe-society-and-jason-bourne/","collection":"Season 8","episode_title":"'Cafe Society' and 'Jason Bourne'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s8e2.jpg","aired_at":"2016-08-03T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/suicide-squad-and-nine-lives/","collection":"Season 8","episode_title":"'Suicide Squad' and 'Nine Lives'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s8e3.jpg","aired_at":"2016-08-10T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/sausage-party-and-petes-dragon/","collection":"Season 8","episode_title":"'Sausage Party' and 'Pete's Dragon'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s8e4.jpg","aired_at":"2016-08-17T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/ben-hur-and-kubo-and-the-two-strings/","collection":"Season 8","episode_title":"'Ben-Hur' and 'Kubo and the Two Strings'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s8e5.jpg","aired_at":"2016-08-24T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/hands-of-stone-and-mechanic-resurrection/","collection":"Season 8","episode_title":"'Hands of Stone' and 'Mechanic: Resurrection'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s8e6.jpg","aired_at":"2016-08-31T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/solace-and-the-light-between-oceans/","collection":"Season 8","episode_title":"'Solace' and 'The Light Between Oceans'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s8e7.jpg","aired_at":"2016-09-07T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/sully-and-when-the-bough-breaks/","collection":"Season 8","episode_title":"'Sully' and 'When The Bough Breaks'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s8e8.jpg","aired_at":"2016-09-14T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/snowden-and-bridget-joness-baby/","collection":"Season 8","episode_title":"'Snowden' and 'Bridget Jones's Baby'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s8e9.jpg","aired_at":"2016-09-21T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-magnificent-seven-and-storks/","collection":"Season 8","episode_title":"'The Magnificent Seven' and 'Storks'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s8e10.jpg","aired_at":"2016-09-28T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/official-endorsement/","collection":"Season 8","episode_title":"Official Endorsement","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s8-trump.jpg","aired_at":"2016-07-28T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/ant-man-and-fantastic-four/","collection":"Season 7","episode_title":"'Ant Man' and 'Fantastic Four'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s7e1.jpg","aired_at":"2015-09-09T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/black-mass-and-maze-runner-the-scorch-trials/","collection":"Season 7","episode_title":"'Black Mass' and 'Maze Runner: The Scorch Trials'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s7e2.jpg","aired_at":"2015-09-16T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-intern-hotel-transylvania-2/","collection":"Season 7","episode_title":"'The Intern' and 'Hotel Transylvania 2'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s7e3.jpg","aired_at":"2015-09-23T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/doctor-san-forgiveness-special/","collection":"Season 7","episode_title":"Doctor San Forgiveness Special","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s7e4.jpg","aired_at":"2015-09-30T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/pan-and-steve-jobs/","collection":"Season 7","episode_title":"'Pan' and 'Steve Jobs'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s7e5.jpg","aired_at":"2015-10-07T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/goosebumps-and-bridge-of-spies/","collection":"Season 7","episode_title":"'Goosebumps' and 'Bridge of Spies'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s7e6.jpg","aired_at":"2015-10-14T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/jem-and-the-holograms-and-paranormal-activity-the-ghost-dimensions/","collection":"Season 7","episode_title":"'Jem and the Holograms' and 'Paranormal Activity: The Ghost Dimensions'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s7e7.jpg","aired_at":"2015-10-21T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/autobahn-and-scouts-guide-to-the-zombie-apocalypse/","collection":"Season 7","episode_title":"'Autobahn' and 'Scout's Guide to the Zombie Apocalypse'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s7e8.jpg","aired_at":"2015-10-28T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/spectre-and-the-peanuts-movie/","collection":"Season 7","episode_title":"'Spectre' and 'The Peanuts Movie'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s7e9.jpg","aired_at":"2015-11-05T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/rings-and-by-the-sea/","collection":"Season 7","episode_title":"'Rings' and 'By The Sea'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s7e10.jpg","aired_at":"2015-11-12T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/jupiter-ascending-and-the-spongebob-movie-sponge-out-of-water/","collection":"Season 6","episode_title":"'Jupiter Ascending' and 'The Spongebob Movie: Sponge Out of Water'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s6e1.jpg","aired_at":"2015-02-04T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/fifty-shades-of-grey-and-kingsman-the-secret-service/","collection":"Season 6","episode_title":"'Fifty Shades of Grey' and 'Kingsman: The Secret Service'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s6e2.jpg","aired_at":"2015-02-11T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/hot-tub-time-machine-2-and-mcfarlands-usa/","collection":"Season 6","episode_title":"'Hot Tub Time Machine 2' and 'McFarlands USA'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s6e3.jpg","aired_at":"2015-02-18T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/focus-and-lazarus/","collection":"Season 6","episode_title":"'Focus' and 'Lazarus'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s6e4.jpg","aired_at":"2015-02-25T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/chappie-and-the-second-best-exotic-marigold-hotel/","collection":"Season 6","episode_title":"'Chappie' and 'The Second Best Exotic Marigold Hotel'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s6e5.jpg","aired_at":"2015-03-04T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/in-the-heart-of-the-sea-and-cinderella/","collection":"Season 6","episode_title":"'In the Heart of the Sea' and 'Cinderella'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s6e6.jpg","aired_at":"2015-03-11T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-divergent-series-insurgent-and-the-gunman/","collection":"Season 6","episode_title":"'The Divergent Series: Insurgent' and 'The Gunman'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s6e7.jpg","aired_at":"2015-03-18T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/get-hard-and-home/","collection":"Season 6","episode_title":"'Get Hard' and 'Home'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s6e8.jpg","aired_at":"2015-03-25T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/furious-7-and-woman-in-gold/","collection":"Season 6","episode_title":"'Furious 7' and 'Woman In Gold'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s6e9.jpg","aired_at":"2015-04-01T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/ex-machina-and-the-moon-and-the-sun/","collection":"Season 6","episode_title":"'Ex Machina' and 'The Moon and the Sun'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s6e10.jpg","aired_at":"2015-04-08T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/deliver-us-from-evil-and-tammy/","collection":"Season 5","episode_title":"'Deliver Us From Evil' and 'Tammy'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s5e1.jpg","aired_at":"2014-07-02T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/dawn-of-the-planet-of-the-apes-and-so-it-goes/","collection":"Season 5","episode_title":"'Dawn of the Planet of the Apes' and 'So It Goes'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s5e2.jpg","aired_at":"2014-07-09T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/jupiter-ascending-and-planes-fire-and-rescue/","collection":"Season 5","episode_title":"'Jupiter Ascending' and 'Planes: Fire and Rescue'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s5e3.jpg","aired_at":"2014-07-16T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/wish-i-was-here-and-hercules/","collection":"Season 5","episode_title":"'Wish I Was Here' and 'Hercules'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s5e4.jpg","aired_at":"2014-07-23T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/guardians-of-the-galaxy-and-get-on-up/","collection":"Season 5","episode_title":"'Guardians of the Galaxy' and 'Get On Up'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s5e5.jpg","aired_at":"2014-07-30T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/teenage-mutant-ninja-turtles-and-into-the-storm/","collection":"Season 5","episode_title":"'Teenage Mutant Ninja Turtles' and 'Into The Storm'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s5e6.jpg","aired_at":"2014-08-06T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/lets-be-cops-and-the-expendables-3/","collection":"Season 5","episode_title":"'Let's Be Cops' and 'The Expendables 3'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s5e7.jpg","aired_at":"2014-08-13T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/on-cinema-after-cinema/","collection":"Season 5","episode_title":"On Cinema After Cinema","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s5-after.jpg","aired_at":"2014-08-14T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/sin-city-a-dame-to-kill-for/","collection":"Season 5","episode_title":"'Sin City: A Dame to Kill For'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s5e8.jpg","aired_at":"2014-08-20T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-november-man-and-jessabelle/","collection":"Season 5","episode_title":"'The November Man' and 'Jessabelle'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s5e9.jpg","aired_at":"2014-08-27T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/dark-places-and-the-green-inferno/","collection":"Season 5","episode_title":"'Dark Places' and 'The Green Inferno'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s5e10.jpg","aired_at":"2014-09-03T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/lone-survivor-and-her/","collection":"Season 4","episode_title":"'Lone Survivor' and 'Her'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s4e1.jpg","aired_at":"2014-01-08T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-nut-job-and-ride-along/","collection":"Season 4","episode_title":"'The Nut Job' and 'Ride Along'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s4e2.jpg","aired_at":"2014-01-15T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/i-frankenstein-and-gimme-shelter/","collection":"Season 4","episode_title":"'I, Frankenstein' and 'Gimme Shelter'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s4e3.jpg","aired_at":"2014-01-22T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/on-alternative-medicine/","collection":"Season 4","episode_title":"On Alternative Medicine","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s4e4.jpg","aired_at":"2014-01-29T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-lego-movie-and-robocop/","collection":"Season 4","episode_title":"'The Lego Movie' and 'Robocop'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s4e5.jpg","aired_at":"2014-02-05T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-girl-on-a-bicycle-and-endless-love/","collection":"Season 4","episode_title":"'The Girl on a Bicycle' and 'Endless Love'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s4e6.jpg","aired_at":"2014-02-12T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/pompeii/","collection":"Season 4","episode_title":"'Pompeii'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s4e7.jpg","aired_at":"2014-02-19T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/welcome-to-yesterday-aka-almanac-and-non-stop/","collection":"Season 4","episode_title":"'Welcome to Yesterday' (aka 'Almanac') and 'Non-Stop'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s4e8.jpg","aired_at":"2014-02-26T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/need-for-speed-and-walk-of-shame/","collection":"Season 4","episode_title":"'Need for Speed' and 'Walk of Shame'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s4e9.jpg","aired_at":"2014-03-05T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/muppets-most-wanted/","collection":"Season 4","episode_title":"'Muppets Most Wanted'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s4e10.jpg","aired_at":"2014-03-12T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-lone-ranger-and-despicable-me-2/","collection":"Season 3","episode_title":"'The Lone Ranger' and 'Despicable Me 2'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s3e1.jpg","aired_at":"2013-07-03T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/grown-ups-2-and-pacific-rim/","collection":"Season 3","episode_title":"'Grown Ups 2' and 'Pacific Rim'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s3e2.jpg","aired_at":"2013-07-10T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/turbo-and-red-2/","collection":"Season 3","episode_title":"'Turbo' and 'Red 2'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s3e3.jpg","aired_at":"2013-07-17T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-wolverine-and-blue-jasmine/","collection":"Season 3","episode_title":"'The Wolverine' and 'Blue Jasmine'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s3e4.jpg","aired_at":"2013-07-24T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-smurfs-2-and-300-rise-of-an-empire/","collection":"Season 3","episode_title":"'The Smurfs 2' and '300: Rise of an Empire'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s3e5.jpg","aired_at":"2013-07-31T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/percy-jackson-sea-of-monsters-and-elysium/","collection":"Season 3","episode_title":"'Percy Jackson: Sea of Monsters' and 'Elysium'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s3e6.jpg","aired_at":"2013-08-07T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/kick-ass-2/","collection":"Season 3","episode_title":"'Kick Ass 2'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s3e7.jpg","aired_at":"2013-08-14T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-worlds-end-the-colony/","collection":"Season 3","episode_title":"'The World's End' and 'The Colony'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s3e8.jpg","aired_at":"2013-08-21T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/one-direction-this-is-us-and-the-getaway/","collection":"Season 3","episode_title":"'One Direction: This is Us' and 'The Getaway'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s3e9.jpg","aired_at":"2013-08-28T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/riddick/","collection":"Season 3","episode_title":"'Riddick'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s3e10.jpg","aired_at":"2013-09-04T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/on-cinema-christmas-special/","collection":"Season 3","episode_title":"On Cinema Christmas Special","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s3-christmas.jpg","aired_at":"2013-12-19T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/side-effects-and-identity-thief/","collection":"Season 2","episode_title":"'Side Effects' and 'Identity Thief'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s2e1-1.jpg","aired_at":"2013-02-07T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/a-good-day-to-die-hard-and-escape-from-planet-earth/","collection":"Season 2","episode_title":"'A Good Day to Die Hard' and 'Escape From Planet Earth'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s2e2-1.jpg","aired_at":"2013-02-14T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/snitch-and-dark-skies/","collection":"Season 2","episode_title":"'Snitch' and 'Dark Skies'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s2e3-1.jpg","aired_at":"2013-02-21T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/21-and-over-and-jack-the-giant-slayer/","collection":"Season 2","episode_title":"'21 and Over' and 'Jack The Giant Slayer'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s2e4-1.jpg","aired_at":"2013-02-28T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/oz-the-great-and-powerful-and-dead-man-down/","collection":"Season 2","episode_title":"'Oz: The Great and Powerful' and 'Dead Man Down'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s2e5.jpg","aired_at":"2013-03-07T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/carrie-and-the-incredible-burt-wonderstone/","collection":"Season 2","episode_title":"'Carrie' and 'The Incredible Burt Wonderstone'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s2e6.jpg","aired_at":"2013-03-14T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-croods/","collection":"Season 2","episode_title":"'The Croods'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s2e7-1.jpg","aired_at":"2013-03-21T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/g-i-joe-retaliation-and-temptation-confessions-of-a-marriage-counselor/","collection":"Season 2","episode_title":"'G.I. Joe: Retaliation' and 'Temptation: Confessions of a Marriage Counselor'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s2e8.jpg","aired_at":"2013-03-28T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-company-you-keep-and-jurassic-park-3d/","collection":"Season 2","episode_title":"'The Company You keep' and 'Jurassic Park 3D'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s2e9-1.jpg","aired_at":"2013-04-04T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/a-tribute-to-steven-spielberg-in-3d/","collection":"Season 2","episode_title":"A Tribute to Steven Spielberg in 3D","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s2-spielberg.jpg","aired_at":"2013-04-05T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/oblivion-and-scary-movie-5/","collection":"Season 2","episode_title":"'Oblivion' and 'Scary Movie 5'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s2e10-1.jpg","aired_at":"2013-04-11T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-future-of-cinema/","collection":"Season 2","episode_title":"The Future of Cinema","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s2-future.jpg","aired_at":"2013-04-18T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-man-with-the-iron-fists-and-flight/","collection":"Season 1","episode_title":"'The Man With The Iron Fists' and 'Flight'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s1e1.jpg","aired_at":"2012-11-02T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/skyfall-and-lincoln/","collection":"Season 1","episode_title":"'Skyfall' and 'Lincoln'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s1e2-1.jpg","aired_at":"2012-11-08T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/twilight-part-two-and-anna-karenina/","collection":"Season 1","episode_title":"'Twilight: Part Two' and 'Anna Karenina'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s1e3-1.jpg","aired_at":"2012-11-16T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/red-dawn-and-life-of-pi/","collection":"Season 1","episode_title":"'Red Dawn' and 'Life of Pi'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s1e4.jpg","aired_at":"2012-11-21T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-frozen-ground-and-universal-soldier-day-of-reckoning/","collection":"Season 1","episode_title":"'The Frozen Ground' and 'Universal Soldier: Day of Reckoning'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s1e5.jpg","aired_at":"2012-11-29T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/playing-for-keeps-and-hyde-park-on-hudson/","collection":"Season 1","episode_title":"'Playing for Keeps' and 'Hyde Park on Hudson'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s1e6.jpg","aired_at":"2012-12-06T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/the-hobbit-and-les-miserables/","collection":"Season 1","episode_title":"'The Hobbit' and 'Les Miserables'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s1e7.jpg","aired_at":"2012-12-13T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/zero-dark-thirty-and-monsters-inc-3d/","collection":"Season 1","episode_title":"'Zero Dark Thirty' and 'Monsters, Inc. 3D'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s1e8.jpg","aired_at":"2012-12-21T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/jack-reacher-and-cirque-du-soleil-worlds-away/","collection":"Season 1","episode_title":"'Jack Reacher' and 'Cirque du Soleil: Worlds Away'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s1e9.jpg","aired_at":"2012-12-27T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":"https://heinetwork.tv/episode/parental-guidance-and-django-unchained/","collection":"Season 1","episode_title":"'Parental Guidance' and 'Django Unchained'","poster_url":"https://www.heinetwork.tv/wp-content/uploads/2021/02/s1e10.jpg","aired_at":"2013-01-10T00:00:00","show":"on_cinema","media_type":"episode"}
,
{"episode_url":null,"collection":"1","episode_title":"Episode 1","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2014-07-17T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"1","episode_title":"Episode 2","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2014-07-24T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"1","episode_title":"Episode 3","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2014-07-31T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"1","episode_title":"Episode 4","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2014-08-07T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"1","episode_title":"Episode 5","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2014-08-14T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"2","episode_title":"Port Of Call: Hawaii - Episode 1","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-03-09T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"2","episode_title":"Port Of Call: Hawaii - Episode 2","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-03-10T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"2","episode_title":"Port Of Call: Hawaii - Episode 3","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-03-11T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"2","episode_title":"Port Of Call: Hawaii - Episode 4","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-03-12T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"2","episode_title":"Port Of Call: Hawaii - Episode 5","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-03-13T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"2","episode_title":"Port Of Call: Hawaii - Episode 6","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-03-14T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"2","episode_title":"Port Of Call: Hawaii - Episode 7","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-03-17T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"2","episode_title":"Port Of Call: Hawaii - Episode 8","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-03-18T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"2","episode_title":"Port Of Call: Hawaii - Episode 9","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-03-19T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"2","episode_title":"Port Of Call: Hawaii - Episode 10","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-03-20T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"2","episode_title":"Port Of Call: Hawaii - Episode 11","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-03-23T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"2","episode_title":"Port Of Call: Hawaii - Episode 12","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-03-24T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"2","episode_title":"Port Of Call: Hawaii - Episode 13","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-03-25T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"2","episode_title":"Port Of Call: Hawaii - Episode 14","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-03-26T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"2","episode_title":"Port Of Call: Hawaii - Episode 15","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-03-27T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"2","episode_title":"Port Of Call: Hawaii - Episode 16","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-03-30T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"2","episode_title":"Port Of Call: Hawaii - Episode 17","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-03-31T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"2","episode_title":"Port Of Call: Hawaii - Episode 18","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-04-01T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"2","episode_title":"Port Of Call: Hawaii - Episode 19","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-04-02T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"2","episode_title":"Port Of Call: Hawaii - Episode 20","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-04-03T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"Specials","episode_title":"Decker at Cinefamily","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-05-29T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"3","episode_title":"Decker 3 - Episode 1","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-10-12T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"3","episode_title":"Gregg Turkington's Decker Vs. Dracula - Episode 2","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-10-13T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"3","episode_title":"Gregg Turkington's Decker Vs. Dracula - Episode 3","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-10-14T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"3","episode_title":"Decker Vs. Dracula - Episode 4","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2015-10-15T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"4","episode_title":"All Good Things...","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2016-06-17T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"4","episode_title":"The New Recruits","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2016-06-24T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"4","episode_title":"The Butterfly Effect","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2016-07-08T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"4","episode_title":"Global Hoax","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2016-07-15T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"4","episode_title":"Band Together","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2016-07-22T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"4","episode_title":"A New Hero","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2016-07-29T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"5","episode_title":"Sonrise","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2017-06-04T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"5","episode_title":"Promises Kept","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2017-06-11T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"5","episode_title":"Double Decker","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2017-06-18T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"5","episode_title":"Private Sector","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2017-06-25T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"5","episode_title":"Same Old Glory","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2017-07-02T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"5","episode_title":"A Grave Matter","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2017-07-09T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"6","episode_title":"Lesser of Two Evils","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2017-07-16T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"6","episode_title":"Trouble on the Bayou","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2017-07-23T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"6","episode_title":"DavidsonCare","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2017-07-30T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"6","episode_title":"Desert Caravan","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2017-08-06T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"6","episode_title":"Rock and a Hard Place","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2017-08-13T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"6","episode_title":"Space Wall","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2017-08-20T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"Specials (2020)","episode_title":"The Animated Adventures of Jack Decker","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2020-07-03T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"Deck of Cards","episode_title":"Deck of Cards","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2022-09-02T00:00:00","show":"Decker","media_type":"episode"}
,
{"episode_url":null,"collection":"Deck of Cards","episode_title":"Deck of Cards: What Went Wrong?","poster_url":"https://i.cdn.turner.com/adultswim/big/img/2017/05/05/Decker_fbsearchTn.jpg","aired_at":"2022-10-12T00:00:00","show":"Decker","media_type":"episode"}
]
JSON

episodes = JSON.parse(episodes_json)

episodes.each do |episode|
  record = Episode.find_or_initialize_by(episode_url: episode["episode_url"])
  record.update!(
    collection: episode["collection"],
    episode_title: episode["episode_title"],
    poster_url: episode["poster_url"],
    aired_at: episode["aired_at"],
    media_type: episode["media_type"],
    show: episode["show"]
  )
end

puts "Seeded #{episodes.size} episodes."
