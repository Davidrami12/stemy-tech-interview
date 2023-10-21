import React, { useState, useEffect } from 'react';
import { List, ListItem, SearchBar, OrderButton, PokemonImage } from '../styled/StyledComponents';
import { fetchPokemons } from '../features/FetchAPI';

type Pokemon = {
  name: string;
  url: string;
}

const PokemonList = () => {
  const [pokemons, setPokemons] = useState<Pokemon[]>([]);
  const [search, setSearch] = useState<string>('');
  const [order, setOrder] = useState<string>('asc');

  useEffect(() => {
    const getPokemons = async () => {
      try {
        const pokemons = await fetchPokemons();
        setPokemons(pokemons);
      } catch (error) {
        console.error("An error ocurred: ", error);
      }
    };

    getPokemons();
  }, []);

  const getPokemonId = (url: string): string | null => {
    const match = url.match(/\/(\d+)\/$/);
    return match ? match[1] : null;
  };

  const filteredPokemons = pokemons.filter(pokemon => 
    pokemon.name.includes(search.toLowerCase())
  );

  const toggleOrder = () => {
    setOrder(prevOrder => prevOrder === 'asc' ? 'desc' : 'asc');
  };

  const sortedPokemons = [...filteredPokemons].sort((a, b) => {
    if (order === 'asc') {
      return a.name.localeCompare(b.name);
    } else {
      return b.name.localeCompare(a.name);
    }
  });

  return (
    <div>
      <SearchBar 
        type="text" 
        placeholder="Search Pokémon..." 
        value={search}
        onChange={e => setSearch(e.target.value)}
      />

      <OrderButton onClick={toggleOrder}>
        Order {order === 'asc' ? 'Descending' : 'Ascending'}
      </OrderButton>
    
      <List>
        {sortedPokemons.map((pokemon, index) => (
          <li key={index}>
            <ListItem>
              <PokemonImage 
                src={`https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${getPokemonId(pokemon.url)}.png`} 
                alt={pokemon.name}
              />
              #{getPokemonId(pokemon.url)} {pokemon.name}
            </ListItem>
          </li>
        ))}
      </List>

    </div>
  );
};

export default PokemonList;