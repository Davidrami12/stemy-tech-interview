const BASE_URL = 'https://pokeapi.co/api/v2/pokemon/'; // In a real case could save this on a .env variable

export const fetchPokemons = async () => {
  try {
    const response = await fetch(BASE_URL);
    const data = await response.json();
    return data.results;
  } catch (error) {
    console.error("An error occurred trying to fetch pokeapi: ", error);
    throw error;
  }
};