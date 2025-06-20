// src/components/CartButton.tsx
import React from 'react';
import { IconButton, Badge } from '@mui/material';
import ShoppingBagIcon from '@mui/icons-material/ShoppingBag';
import { useCart } from '../store/CartContext';
import { useNavigate } from 'react-router-dom';

export default function CartButton() {
  const { state: cartItems } = useCart();
  const totalCount = cartItems.reduce((sum, i) => sum + i.quantity, 0);
  const navigate = useNavigate();

  return (
    <Badge badgeContent={totalCount} color="secondary">
      <IconButton
        onClick={() => navigate('/checkout')}
        sx={{
          width: 55,
          height: 45,
          backgroundColor: '#0827C9',
          border: '1px solid #000000',
          borderRadius: 5,
          color: 'white',
          '&:hover': { backgroundColor: '#001b8d' },
        }}
      >
        <ShoppingBagIcon />
      </IconButton>
    </Badge>
  );
}
