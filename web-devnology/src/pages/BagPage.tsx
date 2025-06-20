// src/pages/BagPage.tsx

import React, { useState } from 'react';
import {
  Box,
  Typography,
  Button,
  Collapse,
  Card,
  CardContent,
  CardMedia,
  TextField
} from '@mui/material';
import { useCart } from '../store/CartContext';

export default function BagPage() {
  const { state: cartItems } = useCart();
  const [open, setOpen] = useState(false);

  const totalItems = cartItems.reduce((sum, i) => sum + i.quantity, 0);

  return (
    <Box sx={{ p: 3 }}>
      <Typography variant="h5" fontWeight={600} mb={1}>
        Sacola
      </Typography>
      <Typography variant="subtitle1" mb={2}>
        Total de itens: {totalItems}
      </Typography>

      {/* Dropdown de produtos selecionados */}
      <Box sx={{ mb: 2 }}>
        <Button variant="outlined" onClick={() => setOpen(prev => !prev)}>
          Produtos selecionados ({cartItems.length}) - ver detalhes
        </Button>
        <Collapse in={open} sx={{ mt: 2 }}>
          {/* Grid CSS para produtos */}
          <Box
            sx={{
              display: 'grid',
              gap: 2,
              gridTemplateColumns: {
                xs: '1fr',
                sm: 'repeat(2,1fr)',
                md: 'repeat(3,1fr)'
              }
            }}
          >
            {cartItems.map((item, idx) => (
              <Card key={`${item.productId}-${idx}`} sx={{ display: 'flex', alignItems: 'center' }}>
                <CardMedia
                  component="img"
                  sx={{ width: 100, height: 100, objectFit: 'cover' }}
                  image={`/assets/images/placeholder.png`}
                  alt={`Produto ${item.productId}`}
                />
                <CardContent>
                  <Typography>Produto #{item.productId}</Typography>
                  <Typography>Quantidade: {item.quantity}</Typography>
                </CardContent>
              </Card>
            ))}
          </Box>
        </Collapse>
      </Box>

      {/* Formulário de pedido */}
      <Box component="form" sx={{ display: 'grid', gap: 2, maxWidth: 500 }}>
        <TextField label="Nome Completo" required />
        <TextField label="E-mail" type="email" required />
        <TextField label="Telefone" required />
        <TextField label="Endereço" required />
        <TextField label="CEP" required />
        <Box sx={{ textAlign: 'right', mt: 2 }}>
          <Button variant="contained" color="primary">
            Confirmar Pedido
          </Button>
        </Box>
      </Box>
    </Box>
  );
}
