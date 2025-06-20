// src/pages/Home.tsx

import React, { useEffect, useState } from 'react';
import { Box, Typography } from '@mui/material';
import axios from 'axios';
import Carousel from '../components/Carousel';
import CategoryList from '../components/CategoryList';
import CartButton from '../components/CardButton';
import ProductCarousel from '../components/ProductCarousel';

interface Product {
  id: number;
  name: string;
  size: string;
  price: number;
}

export default function Home() {
  const [products, setProducts] = useState<Product[]>([]);

  useEffect(() => {
    axios
      .get<Product[]>('http://localhost:3000/products')
      .then(res => setProducts(res.data))
      .catch(console.error);
  }, []);

  return (
    <Box sx={{ p: 3 }}>
      {/* Banner/carrossel principal */}
      <Carousel />

      {/* Lista de categorias */}
      <Box sx={{ mt: 4 }}>
        <CategoryList />
      </Box>

      {/* Botão de carrinho no topo */}
      <Box sx={{ display: 'flex', justifyContent: 'flex-end', my: 2 }}>
        <CartButton />
      </Box>

      {/* Título da seção de produtos */}
      <Typography variant="h5" fontWeight={600} mt={4} mb={2}>
        Produtos em destaque
      </Typography>

      {/* Carrossel de produtos */}
      <ProductCarousel products={products} />
    </Box>
  );
}
