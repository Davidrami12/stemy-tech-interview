import styled from 'styled-components';

const List = styled.ul`
  max-width: 200px;
  margin: 0 auto;
  text-align: left;
  font-size: 18px;
`;

const ListItem = styled.div`
  display: flex;
  align-items: center;
  position: relative;
  top: 16px;
`;

const SearchBar = styled.input`
  border-radius: 12px;
  font-size: 22px;
  margin-bottom: 12px;
`;

const OrderButton = styled.button`
  border-radius: 12px;
  font-size: 22px;
  cursor: pointer;
  background-color: #FECA1B;
  transition: all .2s;
  border: none;
  
  &:hover{
    background-color: #3761A8;
    color: white;
  }
`;

const PokemonImage = styled.img`
  max-width: 50px;
  margin-right: 10px;
`;

export {
  List,
  ListItem,
  SearchBar,
  OrderButton,
  PokemonImage
}; 