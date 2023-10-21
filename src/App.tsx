import React from 'react';
import logo from "./pokeapi_256.png"
import PokemonList from './components/PokemonList';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <h1>Pokédex React App</h1>
      </header>

      <main>
        <PokemonList />
      </main>
    </div>
  );
}

export default App;
