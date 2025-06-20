// src/pages/CheckoutPage.tsx

import React, { useState, useRef, useEffect, useMemo } from 'react';
import {
  Box,
  Typography,
  TextField,
  Button,
  IconButton,
  Stack,
  MenuItem,
  Select,
  InputLabel,
  FormControl
} from '@mui/material';
import axios from 'axios';
import { useCart } from '../store/CartContext';
import { useNavigate } from 'react-router-dom';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faChevronLeft, faChevronRight } from '@fortawesome/free-solid-svg-icons';

interface OrderForm {
  phoneNumber: string;
  identification: string;
  deliveryAddress: string;
  paymentMethod: 'CREDIT_CARD' | 'PIX' | 'BOLETO' | 'OTHER';
}

interface Product {
  id: number;
  name: string;
  price: number;
}

export default function CheckoutPage() {
  const { state: cartItems, clear } = useCart();
  const navigate = useNavigate();
  const scrollRef = useRef<HTMLDivElement>(null);

  const [form, setForm] = useState<OrderForm>({
    phoneNumber: '',
    identification: '',
    deliveryAddress: '',
    paymentMethod: 'PIX',
  });

  // fetch full product list for names and prices
  const [products, setProducts] = useState<Product[]>([]);
  useEffect(() => {
    axios
      .get<Product[]>('http://localhost:3000/products')
      .then(res => setProducts(res.data))
      .catch(console.error);
  }, []);

  const priceMap = useMemo(() => {
    const m: Record<number, number> = {};
    products.forEach(p => (m[p.id] = p.price));
    return m;
  }, [products]);

  // total display
  const total = useMemo(
    () =>
      cartItems.reduce(
        (sum, item) => sum + item.quantity * (priceMap[item.productId] ?? 0),
        0
      ),
    [cartItems, priceMap]
  );

  const handleChange = (field: keyof OrderForm) => (
    e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>
  ) => {
    setForm(prev => ({ ...prev, [field]: e.target.value }));
  };

  const scroll = (dir: 'left' | 'right') => {
    if (!scrollRef.current) return;
    scrollRef.current.scrollBy({ left: dir === 'left' ? -120 : 120, behavior: 'smooth' });
  };

  const handleConfirm = async () => {
    const payload = {
      user: {
        phoneNumber: form.phoneNumber,
        identification: form.identification,
        deliveryAddress: form.deliveryAddress,
        paymentMethod: form.paymentMethod,
      },
      items: cartItems.map(item => {
        const product = products.find(p => p.id === item.productId);
        const unitPrice = Math.round((priceMap[item.productId] ?? 0) * 100);
        return {
          productId: String(item.productId),
          productName: product?.name ?? `Produto #${item.productId}`,
          quantity: item.quantity,
          unitPrice,
        };
      }),
    };

    console.log('Payload UI:', payload);
    try {
      await axios.post('http://localhost:3000/orders', payload);
      clear();
      navigate('/orders');
    } catch (err: any) {
      const msgs = err.response?.data?.message;
      alert(
        `Erro ao processar pedido: ${
          Array.isArray(msgs) ? msgs.join(', ') : msgs || 'Erro desconhecido'
        }`
      );
      console.error(err);
    }
  };

  return (
    <Box sx={{ maxWidth: 600, mx: 'auto', p: 3 }}>
      <Typography variant="h5" mb={2}>Checkout</Typography>

      <Typography variant="subtitle1" fontWeight={600} gutterBottom>
        Itens na sacola
      </Typography>
      <Box sx={{ position: 'relative', mb: 4 }}>
        <IconButton onClick={() => scroll('left')} sx={{ position: 'absolute', top: '50%', left: 0, transform: 'translate(-50%, -50%)', zIndex: 1 }}>
          <FontAwesomeIcon icon={faChevronLeft} />
        </IconButton>
        <Box ref={scrollRef} sx={{ display: 'flex', overflowX: 'auto', gap: 2, p: 1, '&::-webkit-scrollbar': { display: 'none' }, scrollbarWidth: 'none', border: '1px solid #ccc', borderRadius: 1 }}>
          {cartItems.map(item => (
            <Box key={item.productId} sx={{ minWidth: 100, p: 1, textAlign: 'center', border: '1px solid #ddd', borderRadius: 1 }}>
              <Typography variant="body2">#{item.productId}</Typography>
              <Typography variant="caption">Qtd: {item.quantity}</Typography>
            </Box>
          ))}
        </Box>
        <IconButton onClick={() => scroll('right')} sx={{ position: 'absolute', top: '50%', right: 0, transform: 'translate(50%, -50%)', zIndex: 1 }}>
          <FontAwesomeIcon icon={faChevronRight} />
        </IconButton>
      </Box>

      <Stack spacing={2} mb={2}>
        <TextField fullWidth label="Telefone" value={form.phoneNumber} onChange={handleChange('phoneNumber')} required />
        <TextField fullWidth label="Identificação" value={form.identification} onChange={handleChange('identification')} required />
        <TextField fullWidth label="Endereço de Entrega" value={form.deliveryAddress} onChange={handleChange('deliveryAddress')} required />
        <FormControl fullWidth>
          <InputLabel>Forma de Pagamento</InputLabel>
          <Select
            value={form.paymentMethod}
            label="Forma de Pagamento"
            onChange={e => setForm(prev => ({ ...prev, paymentMethod: e.target.value as any }))}
          >
            <MenuItem value="CREDIT_CARD">Cartão de Crédito</MenuItem>
            <MenuItem value="PIX">PIX</MenuItem>
            <MenuItem value="BOLETO">Boleto</MenuItem>
            <MenuItem value="OTHER">Outro</MenuItem>
          </Select>
        </FormControl>
      </Stack>

      <Box sx={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <Typography variant="h6">Total: R$ {(total).toFixed(2)}</Typography>
        <Button variant="contained" color="primary" onClick={handleConfirm}>Confirmar Compra</Button>
      </Box>
    </Box>
  );
}
