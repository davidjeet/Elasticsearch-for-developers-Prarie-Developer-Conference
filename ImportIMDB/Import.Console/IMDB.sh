#!/usr/bin/env bash
# Check that Elasticsearch is running
curl -s "http://localhost:9200" 2>&1 > /dev/null
if [ $? != 0 ]; then
    echo "Unable to contact Elasticsearch on port 9200."
    echo "Please ensure Elasticsearch is running and can be reached at http://localhost:9200/"
    exit -1
fi

echo "WARNING, this script will delete the 'imdb' index and re-index all data!"
echo "Press Control-C to cancel this operation."
echo
echo "Press [Enter] to continue."
read

# Delete the old index, swallow failures if it doesn't exist
curl -s -XDELETE 'localhost:9200/imdb' > /dev/null

## Create the next index using mapping.json

# echo "Creating 'imdb' index..."
echo "Adding Index and Mapping data..."

echo

curl -XPOST localhost:9200/imdb -d '{
    "settings" : {
        "number_of_shards" : 1
    },
    "mappings" : {
        "movies" : {
          "properties": 
          {
            "title": { 
              "type": "string" },
            "genres": {
              "type": "string",
              "index": "not_analyzed" },
            "year": { 
              "type": "short" },
            "rating": {
              "type": "float" }      
          }
        }
    }
}'
######curl -s -XPOST 'localhost:9200/imdb' -d@$(dirname $0)/mapping.json
# Wait for index to become yellow
curl -s 'localhost:9200/imdb/_health?wait_for_status=yellow&timeout=10s' > /dev/null
echo
echo "Done creating 'imdb' index."

echo
echo "Indexing data..."

echo
curl -s -XPOST 'localhost:9200/imdb/movies/1' -d'{
  "title": "The Shawshank Redemption",
  "rating": 9.2,
  "year": 1994,
  "genres": ["Crime","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/2' -d'{
  "title": "The Godfather",
  "rating": 9.2,
  "year": 1972,
  "genres": ["Crime","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/3' -d'{
  "title": "The Godfather: Part II",
  "rating": 9,
  "year": 1974,
  "genres": ["Crime","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/4' -d'{
  "title": "The Dark Knight",
  "rating": 8.9,
  "year": 2008,
  "genres": ["Action","Crime","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/5' -d'{
  "title": "Pulp Fiction",
  "rating": 8.9,
  "year": 1994,
  "genres": ["Crime","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/6' -d'{
  "title": "Schindler\u0027s List",
  "rating": 8.9,
  "year": 1993,
  "genres": ["Unknown"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/7' -d'{
  "title": "12 Angry Men",
  "rating": 8.9,
  "year": 1957,
  "genres": ["Crime","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/8' -d'{
  "title": "The Lord of the Rings: The Return of the King",
  "rating": 8.9,
  "year": 2003,
  "genres": ["Adventure","Drama","Fantasy"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/9' -d'{
  "title": "Il buono, il brutto, il cattivo",
  "rating": 8.9,
  "year": 1966,
  "genres": ["Western"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/10' -d'{
  "title": "Fight Club",
  "rating": 8.8,
  "year": 1999,
  "genres": ["Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/11' -d'{
  "title": "The Lord of the Rings: The Fellowship of the Ring",
  "rating": 8.8,
  "year": 2001,
  "genres": ["Adventure","Drama","Fantasy"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/12' -d'{
  "title": "Star Wars: Episode V - The Empire Strikes Back",
  "rating": 8.7,
  "year": 1980,
  "genres": ["Action","Adventure","Fantasy","Sci-Fi"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/13' -d'{
  "title": "Forrest Gump",
  "rating": 8.7,
  "year": 1994,
  "genres": ["Drama","Romance"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/14' -d'{
  "title": "Inception",
  "rating": 8.7,
  "year": 2010,
  "genres": ["Action","Mystery","Sci-Fi","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/15' -d'{
  "title": "One Flew Over the Cuckoo\u0027s Nest",
  "rating": 8.7,
  "year": 1975,
  "genres": ["Unknown"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/16' -d'{
  "title": "The Lord of the Rings: The Two Towers",
  "rating": 8.7,
  "year": 2002,
  "genres": ["Adventure","Drama","Fantasy"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/17' -d'{
  "title": "Goodfellas",
  "rating": 8.7,
  "year": 1990,
  "genres": ["Biography","Crime","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/18' -d'{
  "title": "The Matrix",
  "rating": 8.7,
  "year": 1999,
  "genres": ["Action","Sci-Fi"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/19' -d'{
  "title": "Shichinin no samurai",
  "rating": 8.7,
  "year": 1954,
  "genres": ["Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/20' -d'{
  "title": "Star Wars",
  "rating": 8.6,
  "year": 1977,
  "genres": ["Action","Adventure","Fantasy","Sci-Fi"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/21' -d'{
  "title": "Cidade de Deus",
  "rating": 8.6,
  "year": 2002,
  "genres": ["Crime","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/22' -d'{
  "title": "Se7en",
  "rating": 8.6,
  "year": 1995,
  "genres": ["Crime","Drama","Mystery","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/23' -d'{
  "title": "The Silence of the Lambs",
  "rating": 8.6,
  "year": 1991,
  "genres": ["Crime","Drama","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/24' -d'{
  "title": "The Usual Suspects",
  "rating": 8.6,
  "year": 1995,
  "genres": ["Crime","Drama","Mystery","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/25' -d'{
  "title": "It\u0027s a Wonderful Life",
  "rating": 8.6,
  "year": 1946,
  "genres": ["Unknown"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/26' -d'{
  "title": "La vita � bella",
  "rating": 8.6,
  "year": 1997,
  "genres": ["Comedy","Drama","Romance","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/27' -d'{
  "title": "L�on",
  "rating": 8.6,
  "year": 1994,
  "genres": ["Crime","Drama","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/28' -d'{
  "title": "C\u0027era una volta il West",
  "rating": 8.5,
  "year": 1968,
  "genres": ["Unknown"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/29' -d'{
  "title": "Sen to Chihiro no kamikakushi",
  "rating": 8.5,
  "year": 2001,
  "genres": ["Adventure","Animation","Family","Fantasy"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/30' -d'{
  "title": "Saving Private Ryan",
  "rating": 8.5,
  "year": 1998,
  "genres": ["Action","Drama","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/31' -d'{
  "title": "Interstellar",
  "rating": 8.5,
  "year": 2014,
  "genres": ["Adventure","Drama","Sci-Fi"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/32' -d'{
  "title": "Casablanca",
  "rating": 8.5,
  "year": 1942,
  "genres": ["Drama","Romance","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/33' -d'{
  "title": "American History X",
  "rating": 8.5,
  "year": 1998,
  "genres": ["Crime","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/34' -d'{
  "title": "Psycho",
  "rating": 8.5,
  "year": 1960,
  "genres": ["Horror","Mystery","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/35' -d'{
  "title": "City Lights",
  "rating": 8.5,
  "year": 1931,
  "genres": ["Comedy","Drama","Romance"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/36' -d'{
  "title": "Raiders of the Lost Ark",
  "rating": 8.5,
  "year": 1981,
  "genres": ["Action","Adventure"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/37' -d'{
  "title": "Rear Window",
  "rating": 8.5,
  "year": 1954,
  "genres": ["Mystery","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/38' -d'{
  "title": "Intouchables",
  "rating": 8.5,
  "year": 2011,
  "genres": ["Biography","Comedy","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/39' -d'{
  "title": "Modern Times",
  "rating": 8.5,
  "year": 1936,
  "genres": ["Comedy","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/40' -d'{
  "title": "The Green Mile",
  "rating": 8.5,
  "year": 1999,
  "genres": ["Crime","Drama","Fantasy","Mystery"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/41' -d'{
  "title": "Terminator 2: Judgment Day",
  "rating": 8.5,
  "year": 1991,
  "genres": ["Action","Sci-Fi"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/42' -d'{
  "title": "Deadpool",
  "rating": 8.5,
  "year": 2016,
  "genres": ["Action","Adventure","Comedy","Sci-Fi"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/43' -d'{
  "title": "The Pianist",
  "rating": 8.5,
  "year": 2002,
  "genres": ["Biography","Drama","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/44' -d'{
  "title": "The Departed",
  "rating": 8.5,
  "year": 2006,
  "genres": ["Crime","Drama","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/45' -d'{
  "title": "Whiplash",
  "rating": 8.5,
  "year": 2014,
  "genres": ["Drama","Music"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/46' -d'{
  "title": "Back to the Future",
  "rating": 8.5,
  "year": 1985,
  "genres": ["Adventure","Comedy","Sci-Fi"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/47' -d'{
  "title": "Memento",
  "rating": 8.5,
  "year": 2000,
  "genres": ["Mystery","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/48' -d'{
  "title": "Gladiator",
  "rating": 8.5,
  "year": 2000,
  "genres": ["Action","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/49' -d'{
  "title": "Apocalypse Now",
  "rating": 8.5,
  "year": 1979,
  "genres": ["Drama","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/50' -d'{
  "title": "Dr. Strangelove or: How I Learned to Stop Worrying and Love the Bomb",
  "rating": 8.5,
  "year": 1964,
  "genres": ["Comedy"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/51' -d'{
  "title": "The Prestige",
  "rating": 8.5,
  "year": 2006,
  "genres": ["Drama","Mystery","Sci-Fi","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/52' -d'{
  "title": "Sunset Blvd.",
  "rating": 8.4,
  "year": 1950,
  "genres": ["Drama","Film-Noir"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/53' -d'{
  "title": "The Lion King",
  "rating": 8.4,
  "year": 1994,
  "genres": ["Adventure","Animation","Drama","Family","Musical"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/54' -d'{
  "title": "Alien",
  "rating": 8.4,
  "year": 1979,
  "genres": ["Horror","Sci-Fi"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/55' -d'{
  "title": "The Great Dictator",
  "rating": 8.4,
  "year": 1940,
  "genres": ["Comedy","Drama","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/56' -d'{
  "title": "Das Leben der Anderen",
  "rating": 8.4,
  "year": 2006,
  "genres": ["Drama","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/57' -d'{
  "title": "Nuovo Cinema Paradiso",
  "rating": 8.4,
  "year": 1988,
  "genres": ["Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/58' -d'{
  "title": "Django Unchained",
  "rating": 8.4,
  "year": 2012,
  "genres": ["Drama","Western"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/59' -d'{
  "title": "The Shining",
  "rating": 8.4,
  "year": 1980,
  "genres": ["Drama","Horror"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/60' -d'{
  "title": "Paths of Glory",
  "rating": 8.4,
  "year": 1957,
  "genres": ["Drama","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/61' -d'{
  "title": "The Dark Knight Rises",
  "rating": 8.4,
  "year": 2012,
  "genres": ["Action","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/62' -d'{
  "title": "WALL�E",
  "rating": 8.4,
  "year": 2008,
  "genres": ["Adventure","Animation","Family","Sci-Fi"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/63' -d'{
  "title": "Hotaru no haka",
  "rating": 8.4,
  "year": 1988,
  "genres": ["Animation","Drama","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/64' -d'{
  "title": "American Beauty",
  "rating": 8.4,
  "year": 1999,
  "genres": ["Drama","Romance"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/65' -d'{
  "title": "Aliens",
  "rating": 8.4,
  "year": 1986,
  "genres": ["Action","Horror","Sci-Fi"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/66' -d'{
  "title": "Mononoke-hime",
  "rating": 8.4,
  "year": 1997,
  "genres": ["Adventure","Animation","Fantasy"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/67' -d'{
  "title": "Citizen Kane",
  "rating": 8.4,
  "year": 1941,
  "genres": ["Drama","Mystery"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/68' -d'{
  "title": "Oldeuboi",
  "rating": 8.4,
  "year": 2003,
  "genres": ["Drama","Mystery","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/69' -d'{
  "title": "North by Northwest",
  "rating": 8.4,
  "year": 1959,
  "genres": ["Adventure","Crime","Mystery","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/70' -d'{
  "title": "Vertigo",
  "rating": 8.4,
  "year": 1958,
  "genres": ["Mystery","Romance","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/71' -d'{
  "title": "Once Upon a Time in America",
  "rating": 8.4,
  "year": 1984,
  "genres": ["Crime","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/72' -d'{
  "title": "Das Boot",
  "rating": 8.4,
  "year": 1981,
  "genres": ["Adventure","Drama","Thriller","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/73' -d'{
  "title": "M",
  "rating": 8.3,
  "year": 1931,
  "genres": ["Crime","Drama","Mystery","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/74' -d'{
  "title": "Star Wars: Episode VI - Return of the Jedi",
  "rating": 8.3,
  "year": 1983,
  "genres": ["Action","Adventure","Fantasy","Sci-Fi"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/75' -d'{
  "title": "Witness for the Prosecution",
  "rating": 8.3,
  "year": 1957,
  "genres": ["Drama","Mystery"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/76' -d'{
  "title": "Le fabuleux destin d\u0027Am�lie Poulain",
  "rating": 8.3,
  "year": 2001,
  "genres": ["Unknown"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/77' -d'{
  "title": "Reservoir Dogs",
  "rating": 8.3,
  "year": 1992,
  "genres": ["Crime","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/78' -d'{
  "title": "Braveheart",
  "rating": 8.3,
  "year": 1995,
  "genres": ["Biography","Drama","History","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/79' -d'{
  "title": "Requiem for a Dream",
  "rating": 8.3,
  "year": 2000,
  "genres": ["Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/80' -d'{
  "title": "A Clockwork Orange",
  "rating": 8.3,
  "year": 1971,
  "genres": ["Crime","Drama","Sci-Fi"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/81' -d'{
  "title": "Taxi Driver",
  "rating": 8.3,
  "year": 1976,
  "genres": ["Crime","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/82' -d'{
  "title": "Toy Story 3",
  "rating": 8.3,
  "year": 2010,
  "genres": ["Adventure","Animation","Comedy","Family","Fantasy"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/83' -d'{
  "title": "Double Indemnity",
  "rating": 8.3,
  "year": 1944,
  "genres": ["Crime","Drama","Film-Noir","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/84' -d'{
  "title": "Star Wars: Episode VII - The Force Awakens",
  "rating": 8.3,
  "year": 2015,
  "genres": ["Action","Adventure","Fantasy","Sci-Fi"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/85' -d'{
  "title": "To Kill a Mockingbird",
  "rating": 8.3,
  "year": 1962,
  "genres": ["Crime","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/86' -d'{
  "title": "Lawrence of Arabia",
  "rating": 8.3,
  "year": 1962,
  "genres": ["Adventure","Biography","Drama","History","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/87' -d'{
  "title": "Eternal Sunshine of the Spotless Mind",
  "rating": 8.3,
  "year": 2004,
  "genres": ["Drama","Romance","Sci-Fi"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/88' -d'{
  "title": "Full Metal Jacket",
  "rating": 8.3,
  "year": 1987,
  "genres": ["Drama","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/89' -d'{
  "title": "Amadeus",
  "rating": 8.3,
  "year": 1984,
  "genres": ["Biography","Drama","Music"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/90' -d'{
  "title": "The Sting",
  "rating": 8.3,
  "year": 1973,
  "genres": ["Comedy","Crime","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/91' -d'{
  "title": "Singin\u0027 in the Rain",
  "rating": 8.3,
  "year": 1952,
  "genres": ["Unknown"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/92' -d'{
  "title": "Ladri di biciclette",
  "rating": 8.3,
  "year": 1948,
  "genres": ["Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/93' -d'{
  "title": "2001: A Space Odyssey",
  "rating": 8.3,
  "year": 1968,
  "genres": ["Mystery","Sci-Fi"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/94' -d'{
  "title": "Snatch.",
  "rating": 8.3,
  "year": 2000,
  "genres": ["Comedy","Crime"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/95' -d'{
  "title": "Monty Python and the Holy Grail",
  "rating": 8.3,
  "year": 1975,
  "genres": ["Adventure","Comedy","Fantasy"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/96' -d'{
  "title": "Toy Story",
  "rating": 8.3,
  "year": 1995,
  "genres": ["Adventure","Animation","Comedy","Family","Fantasy"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/97' -d'{
  "title": "The Kid",
  "rating": 8.3,
  "year": 1921,
  "genres": ["Comedy","Drama","Family"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/98' -d'{
  "title": "Inglourious Basterds",
  "rating": 8.3,
  "year": 2009,
  "genres": ["Adventure","Drama","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/99' -d'{
  "title": "L.A. Confidential",
  "rating": 8.3,
  "year": 1997,
  "genres": ["Crime","Drama","Mystery","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/100' -d'{
  "title": "Rash�mon",
  "rating": 8.3,
  "year": 1950,
  "genres": ["Crime","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/101' -d'{
  "title": "Per qualche dollaro in pi�",
  "rating": 8.3,
  "year": 1965,
  "genres": ["Western"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/102' -d'{
  "title": "The Apartment",
  "rating": 8.3,
  "year": 1960,
  "genres": ["Comedy","Drama","Romance"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/103' -d'{
  "title": "All About Eve",
  "rating": 8.3,
  "year": 1950,
  "genres": ["Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/104' -d'{
  "title": "Indiana Jones and the Last Crusade",
  "rating": 8.3,
  "year": 1989,
  "genres": ["Action","Adventure","Fantasy"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/105' -d'{
  "title": "Jodaeiye Nader az Simin",
  "rating": 8.3,
  "year": 2011,
  "genres": ["Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/106' -d'{
  "title": "Metropolis",
  "rating": 8.3,
  "year": 1927,
  "genres": ["Drama","Sci-Fi"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/107' -d'{
  "title": "Scarface",
  "rating": 8.3,
  "year": 1983,
  "genres": ["Crime","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/108' -d'{
  "title": "Inside Out",
  "rating": 8.3,
  "year": 0,
  "genres": ["Unknown"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/109' -d'{
  "title": "The Treasure of the Sierra Madre",
  "rating": 8.3,
  "year": 1948,
  "genres": ["Action","Adventure","Drama","Western"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/110' -d'{
  "title": "Y�jinb�",
  "rating": 8.2,
  "year": 1961,
  "genres": ["Comedy","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/111' -d'{
  "title": "Batman Begins",
  "rating": 8.2,
  "year": 2005,
  "genres": ["Action","Adventure"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/112' -d'{
  "title": "Some Like It Hot",
  "rating": 8.2,
  "year": 1959,
  "genres": ["Comedy","Romance"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/113' -d'{
  "title": "The Third Man",
  "rating": 8.2,
  "year": 1949,
  "genres": ["Film-Noir","Mystery","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/114' -d'{
  "title": "Unforgiven",
  "rating": 8.2,
  "year": 1992,
  "genres": ["Western"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/115' -d'{
  "title": "3 Idiots",
  "rating": 8.2,
  "year": 2009,
  "genres": ["Comedy","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/116' -d'{
  "title": "Jagten",
  "rating": 8.2,
  "year": 2012,
  "genres": ["Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/117' -d'{
  "title": "Up",
  "rating": 8.2,
  "year": 2009,
  "genres": ["Adventure","Animation","Comedy","Family"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/118' -d'{
  "title": "Good Will Hunting",
  "rating": 8.2,
  "year": 1997,
  "genres": ["Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/119' -d'{
  "title": "Raging Bull",
  "rating": 8.2,
  "year": 1980,
  "genres": ["Biography","Drama","Sport"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/120' -d'{
  "title": "Der Untergang",
  "rating": 8.2,
  "year": 2004,
  "genres": ["Biography","Drama","History","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/121' -d'{
  "title": "Die Hard",
  "rating": 8.2,
  "year": 1988,
  "genres": ["Action","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/122' -d'{
  "title": "Chinatown",
  "rating": 8.2,
  "year": 1974,
  "genres": ["Drama","Mystery","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/123' -d'{
  "title": "The Great Escape",
  "rating": 8.2,
  "year": 1963,
  "genres": ["Adventure","Drama","History","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/124' -d'{
  "title": "Heat",
  "rating": 8.2,
  "year": 1995,
  "genres": ["Action","Crime","Drama","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/125' -d'{
  "title": "On the Waterfront",
  "rating": 8.2,
  "year": 1954,
  "genres": ["Crime","Drama","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/126' -d'{
  "title": "El laberinto del fauno",
  "rating": 8.2,
  "year": 2006,
  "genres": ["Drama","Fantasy","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/127' -d'{
  "title": "Sunrise: A Song of Two Humans",
  "rating": 8.2,
  "year": 1927,
  "genres": ["Drama","Romance"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/128' -d'{
  "title": "Mr. Smith Goes to Washington",
  "rating": 8.2,
  "year": 1939,
  "genres": ["Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/129' -d'{
  "title": "Tonari no Totoro",
  "rating": 8.2,
  "year": 1988,
  "genres": ["Animation","Family","Fantasy"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/130' -d'{
  "title": "The Bridge on the River Kwai",
  "rating": 8.2,
  "year": 1957,
  "genres": ["Adventure","Drama","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/131' -d'{
  "title": "The Gold Rush",
  "rating": 8.2,
  "year": 1925,
  "genres": ["Adventure","Comedy","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/132' -d'{
  "title": "Ikiru",
  "rating": 8.2,
  "year": 1952,
  "genres": ["Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/133' -d'{
  "title": "Room",
  "rating": 8.2,
  "year": 0,
  "genres": ["Unknown"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/134' -d'{
  "title": "Ran",
  "rating": 8.2,
  "year": 1985,
  "genres": ["Action","Drama","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/135' -d'{
  "title": "Det sjunde inseglet",
  "rating": 8.2,
  "year": 1957,
  "genres": ["Drama","Fantasy"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/136' -d'{
  "title": "Blade Runner",
  "rating": 8.2,
  "year": 1982,
  "genres": ["Sci-Fi","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/137' -d'{
  "title": "El secreto de sus ojos",
  "rating": 8.2,
  "year": 2009,
  "genres": ["Drama","Mystery","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/138' -d'{
  "title": "Lock, Stock and Two Smoking Barrels",
  "rating": 8.2,
  "year": 1998,
  "genres": ["Comedy","Crime"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/139' -d'{
  "title": "The General",
  "rating": 8.2,
  "year": 1926,
  "genres": ["Action","Adventure","Comedy","Drama","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/140' -d'{
  "title": "Smultronst�llet",
  "rating": 8.2,
  "year": 1957,
  "genres": ["Drama","Romance"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/141' -d'{
  "title": "Casino",
  "rating": 8.2,
  "year": 1995,
  "genres": ["Biography","Crime","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/142' -d'{
  "title": "The Elephant Man",
  "rating": 8.2,
  "year": 1980,
  "genres": ["Biography","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/143' -d'{
  "title": "Hauru no ugoku shiro",
  "rating": 8.2,
  "year": 2004,
  "genres": ["Adventure","Animation","Family","Fantasy"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/144' -d'{
  "title": "The Revenant",
  "rating": 8.2,
  "year": 2015,
  "genres": ["Adventure","Drama","Thriller","Western"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/145' -d'{
  "title": "Warrior",
  "rating": 8.2,
  "year": 2011,
  "genres": ["Drama","Sport"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/146' -d'{
  "title": "The Wolf of Wall Street",
  "rating": 8.2,
  "year": 2013,
  "genres": ["Biography","Comedy","Crime","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/147' -d'{
  "title": "V for Vendetta",
  "rating": 8.2,
  "year": 2005,
  "genres": ["Action","Drama","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/148' -d'{
  "title": "Judgment at Nuremberg",
  "rating": 8.1,
  "year": 1961,
  "genres": ["Drama","History","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/149' -d'{
  "title": "A Beautiful Mind",
  "rating": 8.1,
  "year": 2001,
  "genres": ["Biography","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/150' -d'{
  "title": "Gran Torino",
  "rating": 8.1,
  "year": 2008,
  "genres": ["Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/151' -d'{
  "title": "The Big Lebowski",
  "rating": 8.1,
  "year": 1998,
  "genres": ["Comedy","Crime"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/152' -d'{
  "title": "Rebecca",
  "rating": 8.1,
  "year": 1940,
  "genres": ["Drama","Film-Noir","Mystery","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/153' -d'{
  "title": "The Deer Hunter",
  "rating": 8.1,
  "year": 1978,
  "genres": ["Drama","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/154' -d'{
  "title": "Gone with the Wind",
  "rating": 8.1,
  "year": 1939,
  "genres": ["Drama","Romance","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/155' -d'{
  "title": "Cool Hand Luke",
  "rating": 8.1,
  "year": 1967,
  "genres": ["Crime","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/156' -d'{
  "title": "Fargo",
  "rating": 8.1,
  "year": 1996,
  "genres": ["Crime","Drama","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/157' -d'{
  "title": "How to Train Your Dragon",
  "rating": 8.1,
  "year": 2010,
  "genres": ["Action","Adventure","Animation","Family","Fantasy"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/158' -d'{
  "title": "Trainspotting",
  "rating": 8.1,
  "year": 1996,
  "genres": ["Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/159' -d'{
  "title": "Incendies",
  "rating": 8.1,
  "year": 2010,
  "genres": ["Drama","Mystery","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/160' -d'{
  "title": "Dial M for Murder",
  "rating": 8.1,
  "year": 1954,
  "genres": ["Crime","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/161' -d'{
  "title": "The Sixth Sense",
  "rating": 8.1,
  "year": 1999,
  "genres": ["Drama","Mystery","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/162' -d'{
  "title": "Into the Wild",
  "rating": 8.1,
  "year": 2007,
  "genres": ["Adventure","Biography","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/163' -d'{
  "title": "Finding Nemo",
  "rating": 8.1,
  "year": 2003,
  "genres": ["Adventure","Animation","Comedy","Family"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/164' -d'{
  "title": "It Happened One Night",
  "rating": 8.1,
  "year": 1934,
  "genres": ["Comedy","Romance"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/165' -d'{
  "title": "The Thing",
  "rating": 8.1,
  "year": 1982,
  "genres": ["Horror","Sci-Fi"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/166' -d'{
  "title": "No Country for Old Men",
  "rating": 8.1,
  "year": 2007,
  "genres": ["Crime","Drama","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/167' -d'{
  "title": "Gone Girl",
  "rating": 8.1,
  "year": 2014,
  "genres": ["Crime","Drama","Mystery","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/168' -d'{
  "title": "Mary and Max",
  "rating": 8.1,
  "year": 2009,
  "genres": ["Animation","Comedy","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/169' -d'{
  "title": "Mad Max: Fury Road",
  "rating": 8.1,
  "year": 2015,
  "genres": ["Action","Adventure","Sci-Fi","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/170' -d'{
  "title": "Spotlight",
  "rating": 8.1,
  "year": 0,
  "genres": ["Unknown"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/171' -d'{
  "title": "Kill Bill: Vol. 1",
  "rating": 8.1,
  "year": 2003,
  "genres": ["Action"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/172' -d'{
  "title": "Rush",
  "rating": 8.1,
  "year": 0,
  "genres": ["Unknown"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/173' -d'{
  "title": "The Maltese Falcon",
  "rating": 8.1,
  "year": 1941,
  "genres": ["Crime","Drama","Film-Noir","Mystery"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/174' -d'{
  "title": "Life of Brian",
  "rating": 8.1,
  "year": 1979,
  "genres": ["Comedy"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/175' -d'{
  "title": "Hotel Rwanda",
  "rating": 8.1,
  "year": 2004,
  "genres": ["Drama","History","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/176' -d'{
  "title": "Platoon",
  "rating": 8.1,
  "year": 1986,
  "genres": ["Drama","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/177' -d'{
  "title": "Le salaire de la peur",
  "rating": 8.1,
  "year": 1953,
  "genres": ["Adventure","Drama","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/178' -d'{
  "title": "There Will Be Blood",
  "rating": 8.1,
  "year": 2007,
  "genres": ["Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/179' -d'{
  "title": "Butch Cassidy and the Sundance Kid",
  "rating": 8.1,
  "year": 1969,
  "genres": ["Biography","Crime","Drama","Western"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/180' -d'{
  "title": "Network",
  "rating": 8.1,
  "year": 1976,
  "genres": ["Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/181' -d'{
  "title": "Les quatre cents coups",
  "rating": 8.1,
  "year": 1959,
  "genres": ["Crime","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/182' -d'{
  "title": "Stand by Me",
  "rating": 8.1,
  "year": 1986,
  "genres": ["Adventure","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/183' -d'{
  "title": "Persona",
  "rating": 8.1,
  "year": 1966,
  "genres": ["Drama","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/184' -d'{
  "title": "12 Years a Slave",
  "rating": 8.1,
  "year": 2013,
  "genres": ["Biography","Drama","History"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/185' -d'{
  "title": "The Princess Bride",
  "rating": 8.1,
  "year": 1987,
  "genres": ["Adventure","Comedy","Family","Fantasy","Romance"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/186' -d'{
  "title": "The Grand Budapest Hotel",
  "rating": 8.1,
  "year": 2014,
  "genres": ["Adventure","Comedy","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/187' -d'{
  "title": "In the Name of the Father",
  "rating": 8.1,
  "year": 1993,
  "genres": ["Biography","Drama","History"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/188' -d'{
  "title": "Touch of Evil",
  "rating": 8.1,
  "year": 1958,
  "genres": ["Crime","Film-Noir","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/189' -d'{
  "title": "Amores perros",
  "rating": 8.1,
  "year": 2000,
  "genres": ["Drama","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/190' -d'{
  "title": "Shutter Island",
  "rating": 8.1,
  "year": 2010,
  "genres": ["Mystery","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/191' -d'{
  "title": "Million Dollar Baby",
  "rating": 8.1,
  "year": 2004,
  "genres": ["Drama","Sport"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/192' -d'{
  "title": "Annie Hall",
  "rating": 8.1,
  "year": 1977,
  "genres": ["Comedy","Romance"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/193' -d'{
  "title": "Ben-Hur",
  "rating": 8.1,
  "year": 1959,
  "genres": ["Adventure","Drama","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/194' -d'{
  "title": "The Grapes of Wrath",
  "rating": 8.1,
  "year": 1940,
  "genres": ["Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/195' -d'{
  "title": "Relatos salvajes",
  "rating": 8.1,
  "year": 2014,
  "genres": ["Comedy","Drama","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/196' -d'{
  "title": "Hachi: A Dog\u0027s Tale",
  "rating": 8.1,
  "year": 2009,
  "genres": ["Unknown"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/197' -d'{
  "title": "Kaze no tani no Naushika",
  "rating": 8.1,
  "year": 1984,
  "genres": ["Adventure","Animation","Fantasy","Sci-Fi"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/198' -d'{
  "title": "Stalker",
  "rating": 8.1,
  "year": 1979,
  "genres": ["Drama","Sci-Fi"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/199' -d'{
  "title": "Drishyam",
  "rating": 8.1,
  "year": 2015,
  "genres": ["Drama","Mystery","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/200' -d'{
  "title": "Les diaboliques",
  "rating": 8,
  "year": 1955,
  "genres": ["Drama","Horror","Mystery","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/201' -d'{
  "title": "Jurassic Park",
  "rating": 8,
  "year": 1993,
  "genres": ["Adventure","Sci-Fi","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/202' -d'{
  "title": "Gandhi",
  "rating": 8,
  "year": 1982,
  "genres": ["Biography","Drama","History"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/203' -d'{
  "title": "8�",
  "rating": 8,
  "year": 1963,
  "genres": ["Drama","Fantasy"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/204' -d'{
  "title": "The Bourne Ultimatum",
  "rating": 8,
  "year": 2007,
  "genres": ["Action","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/205' -d'{
  "title": "Donnie Darko",
  "rating": 8,
  "year": 2001,
  "genres": ["Drama","Sci-Fi","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/206' -d'{
  "title": "The Martian",
  "rating": 8,
  "year": 2015,
  "genres": ["Adventure","Drama","Sci-Fi"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/207' -d'{
  "title": "The Wizard of Oz",
  "rating": 8,
  "year": 1939,
  "genres": ["Adventure","Family","Fantasy","Musical"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/208' -d'{
  "title": "Before Sunrise",
  "rating": 8,
  "year": 1995,
  "genres": ["Drama","Romance"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/209' -d'{
  "title": "The Best Years of Our Lives",
  "rating": 8,
  "year": 1946,
  "genres": ["Drama","Romance","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/210' -d'{
  "title": "Sin City",
  "rating": 8,
  "year": 2005,
  "genres": ["Crime","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/211' -d'{
  "title": "Strangers on a Train",
  "rating": 8,
  "year": 1951,
  "genres": ["Crime","Film-Noir","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/212' -d'{
  "title": "The Terminator",
  "rating": 8,
  "year": 1984,
  "genres": ["Action","Sci-Fi"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/213' -d'{
  "title": "Rocky",
  "rating": 8,
  "year": 1976,
  "genres": ["Drama","Sport"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/214' -d'{
  "title": "The Truman Show",
  "rating": 8,
  "year": 1998,
  "genres": ["Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/215' -d'{
  "title": "Twelve Monkeys",
  "rating": 8,
  "year": 1995,
  "genres": ["Mystery","Sci-Fi","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/216' -d'{
  "title": "Salinui chueok",
  "rating": 8,
  "year": 2003,
  "genres": ["Crime","Drama","Mystery","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/217' -d'{
  "title": "Groundhog Day",
  "rating": 8,
  "year": 1993,
  "genres": ["Comedy","Fantasy","Romance"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/218' -d'{
  "title": "Monsters, Inc.",
  "rating": 8,
  "year": 2001,
  "genres": ["Adventure","Animation","Comedy","Family","Fantasy"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/219' -d'{
  "title": "Harry Potter and the Deathly Hallows: Part 2",
  "rating": 8,
  "year": 2011,
  "genres": ["Adventure","Drama","Fantasy","Mystery"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/220' -d'{
  "title": "Jaws",
  "rating": 8,
  "year": 1975,
  "genres": ["Adventure","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/221' -d'{
  "title": "Mou gaan dou",
  "rating": 8,
  "year": 2002,
  "genres": ["Crime","Mystery","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/222' -d'{
  "title": "La battaglia di Algeri",
  "rating": 8,
  "year": 1966,
  "genres": ["Drama","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/223' -d'{
  "title": "Barry Lyndon",
  "rating": 8,
  "year": 1975,
  "genres": ["Adventure","Drama","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/224' -d'{
  "title": "The Avengers",
  "rating": 8,
  "year": 2012,
  "genres": ["Action","Adventure","Sci-Fi"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/225' -d'{
  "title": "La haine",
  "rating": 8,
  "year": 1995,
  "genres": ["Crime","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/226' -d'{
  "title": "Dog Day Afternoon",
  "rating": 8,
  "year": 1975,
  "genres": ["Crime","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/227' -d'{
  "title": "Fanny och Alexander",
  "rating": 8,
  "year": 1982,
  "genres": ["Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/228' -d'{
  "title": "Kumonosu-j�",
  "rating": 8,
  "year": 1957,
  "genres": ["Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/229' -d'{
  "title": "Prisoners",
  "rating": 8,
  "year": 2013,
  "genres": ["Crime","Drama","Mystery","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/230' -d'{
  "title": "Yip Man",
  "rating": 8,
  "year": 2008,
  "genres": ["Action","Biography","Drama","Sport"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/231' -d'{
  "title": "The Imitation Game",
  "rating": 8,
  "year": 2014,
  "genres": ["Biography","Drama","Thriller","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/232' -d'{
  "title": "The King\u0027s Speech",
  "rating": 8,
  "year": 2010,
  "genres": ["Unknown"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/233' -d'{
  "title": "Guardians of the Galaxy",
  "rating": 8,
  "year": 2014,
  "genres": ["Action","Adventure","Sci-Fi"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/234' -d'{
  "title": "La grande illusion",
  "rating": 8,
  "year": 1937,
  "genres": ["Drama","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/235' -d'{
  "title": "Pirates of the Caribbean: The Curse of the Black Pearl",
  "rating": 8,
  "year": 2003,
  "genres": ["Action","Adventure","Fantasy"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/236' -d'{
  "title": "High Noon",
  "rating": 8,
  "year": 1952,
  "genres": ["Western"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/237' -d'{
  "title": "Per un pugno di dollari",
  "rating": 8,
  "year": 1964,
  "genres": ["Action","Drama","Western"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/238' -d'{
  "title": "The Help",
  "rating": 8,
  "year": 2011,
  "genres": ["Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/239' -d'{
  "title": "Roman Holiday",
  "rating": 8,
  "year": 1953,
  "genres": ["Comedy","Romance"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/240' -d'{
  "title": "Tenk� no shiro Rapyuta",
  "rating": 8,
  "year": 1986,
  "genres": ["Adventure","Animation","Family","Fantasy"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/241' -d'{
  "title": "Catch Me If You Can",
  "rating": 8,
  "year": 2002,
  "genres": ["Biography","Crime","Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/242' -d'{
  "title": "Notorious",
  "rating": 8,
  "year": 1946,
  "genres": ["Drama","Film-Noir","Romance","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/243' -d'{
  "title": "Who\u0027s Afraid of Virginia Woolf?",
  "rating": 8,
  "year": 1966,
  "genres": ["Unknown"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/244' -d'{
  "title": "Beauty and the Beast",
  "rating": 8,
  "year": 1991,
  "genres": ["Animation","Family","Fantasy","Musical","Romance"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/245' -d'{
  "title": "Anatomy of a Murder",
  "rating": 8,
  "year": 1959,
  "genres": ["Crime","Drama","Mystery","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/246' -d'{
  "title": "Bom yeoreum gaeul gyeoul geurigo bom",
  "rating": 8,
  "year": 2003,
  "genres": ["Drama"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/247' -d'{
  "title": "Before Sunset",
  "rating": 8,
  "year": 2004,
  "genres": ["Drama","Romance"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/248' -d'{
  "title": "The Night of the Hunter",
  "rating": 8,
  "year": 1955,
  "genres": ["Crime","Drama","Film-Noir","Thriller"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/249' -d'{
  "title": "Underground",
  "rating": 8,
  "year": 1995,
  "genres": ["Comedy","Drama","War"]
}'

echo
curl -s -XPOST 'localhost:9200/imdb/movies/250' -d'{
  "title": "Fa yeung nin wa",
  "rating": 8,
  "year": 2000,
  "genres": ["Unknown"]
}'

