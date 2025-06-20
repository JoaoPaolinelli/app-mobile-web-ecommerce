// src/pages/SearchPage.tsx

import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { Box, TextField, Typography } from '@mui/material';
import ProductCard from '../components/ProductCard';
import { useCart } from '../store/CartContext';

// imagens locais para caso o imageUrl venha como URL externa
const imageNames = [
  'apple.jpg','Arraia.png','arraial01.png','blusa_promo.jpeg','brinquedos.jpeg',
  'Calça.jpeg','Calça_feminina_default.jpeg','Camisa.jpg','Camiseta_default.jpg',
  'Compras.jpg','Corrente.jpeg','cozinha.jpeg','diaDosNamorados.png','Esteira.jpeg',
  'facas.jpeg','Halter.jpeg','logo.png','Logo_old.png','Macbook.jpg','Ombro.jpeg',
  'Promo.png','promocao.png','promocoes.png','PulseiraMasculina.webp','Relogio.jpeg',
  'Relogio.webp','Sandalha.jpeg','sapato.jpg','tempero.jpg','vestido.jpeg','Whisky.jpg',
];

interface Product {
  id: number;
  name: string;
  size: string;
  price: number;
  imageUrl: string;
}

export default function SearchPage() {
  const [allProducts, setAllProducts] = useState<Product[]>([]);
  const [query, setQuery] = useState('');
  const { state: cartItems, add, increment, decrement } = useCart();

  useEffect(() => {
    axios
      .get<Product[]>('http://localhost:3000/products')
      .then(res => setAllProducts(res.data))
      .catch(console.error);
  }, []);

  // filtra sempre que `query` muda
  const filtered = allProducts.filter(p =>
    p.name.toLowerCase().includes(query.toLowerCase())
  );

  // helper para qtd no carrinho
  const getQty = (id: number) =>
    cartItems.find(i => i.productId === id)?.quantity ?? 0;

  // seleciona imagem: se url externa, escolhe aleatória; senão, tenta usar local ou fallback aleatório
  const resolveImage = (url: string) => {
    const isExternal = url.startsWith('http');
    const randomName = imageNames[Math.floor(Math.random() * imageNames.length)];
    return `/assets/images/${randomName}`;
  };

  return (
    <Box sx={{ p: 3 }}>
      {/* busca */}
      <Box sx={{ display: 'flex', justifyContent: 'center', mb: 4 }}>
        <TextField
          label="Pesquisar produtos"
          variant="outlined"
          value={query}
          onChange={e => setQuery(e.target.value)}
          sx={{ width: { xs: '100%', sm: 400 } }}
        />
      </Box>

      {/* mensagem se não encontrar */}
      {query && filtered.length === 0 && (
        <Typography align="center">Nenhum produto encontrado.</Typography>
      )}

      {/* grid responsivo */}
      <Box
        sx={{
          display: 'grid',
          gap: 2,
          gridTemplateColumns: {
            xs: '1fr',
            sm: 'repeat(2,1fr)',
            md: 'repeat(3,1fr)',
            lg: 'repeat(4,1fr)'
          }
        }}
      >
        {filtered.map((p, i) => (
          <Box key={`${p.id}-${i}`} sx={{ p: 1 }}>
            <ProductCard
              imageUrl={resolveImage(p.imageUrl)}
              title={p.name}
              subtitle={`Tamanho ${p.size}`}
              price={`R$ ${p.price.toFixed(2)}`}
              quantity={getQty(p.id)}
              onAdd={() => add(p.id)}
              onIncrement={() => increment(p.id)}
              onDecrement={() => decrement(p.id)}
            />
          </Box>
        ))}
      </Box>
    </Box>
  );
}
