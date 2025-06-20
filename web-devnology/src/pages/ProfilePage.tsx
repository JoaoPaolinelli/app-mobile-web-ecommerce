// src/pages/ProfilePage.tsx

import React, { useState } from 'react';
import axios from 'axios';
import {
  Box,
  Typography,
  Button,
  Card,
  CardHeader,
  CardContent,
  CardActions,
  Divider,
  Avatar,
  IconButton,
  Collapse,
  List,
  ListItem,
  ListItemText
} from '@mui/material';
import { ExpandMore as ExpandMoreIcon } from '@mui/icons-material';
import { styled } from '@mui/material/styles';
import { useNavigate } from 'react-router-dom';

interface OrderItem {
  id: string;
  totalAmount: number;
  orderDate: string;
  user: {
    name: string;
    email: string;
  };
  items: {
    productId: string;
    productName: string;
    quantity: number;
  }[];
}

const ExpandIcon = styled(IconButton)(({ theme, expand }: { theme?: any; expand: boolean }) => ({
  transform: expand ? 'rotate(180deg)' : 'rotate(0deg)',
  marginLeft: 'auto',
  transition: theme.transitions.create('transform', {
    duration: theme.transitions.duration.shortest,
  }),
}));

export default function ProfilePage() {
  const navigate = useNavigate();
  const [showOrders, setShowOrders] = useState(false);
  const [orders, setOrders] = useState<OrderItem[]>([]);
  const [expandedId, setExpandedId] = useState<string | null>(null);

  const handleToggle = () => {
    if (!showOrders) {
      axios
        .get<OrderItem[]>('http://localhost:3000/orders')
        .then(res => setOrders(res.data))
        .catch(() => setOrders([]));
    }
    setShowOrders(prev => !prev);
  };

  const handleExpandClick = (id: string) => {
    setExpandedId(prev => (prev === id ? null : id));
  };

  return (
    <Box sx={{ p: 3 }}>
      <Typography variant="h5" fontWeight={600} align="center" gutterBottom>
        Perfil do Usuário
      </Typography>
      <Box display="flex" justifyContent="center" mb={3}>
        <Button variant="contained" color="primary" onClick={handleToggle}>
          Histórico de Pedidos
        </Button>
      </Box>

      {showOrders && (
        <Box sx={{ display: 'grid', gap: 2, px: 2 }}>
          {orders.length === 0 ? (
            <Typography align="center">Não há pedidos registrados no momento</Typography>
          ) : (
            orders.map(order => (
              <Card key={order.id} sx={{ maxWidth: 600, mx: 'auto', boxShadow: 3 }}>
                <CardHeader
                  avatar={
                    <Avatar
                    sizes='large'
                      src="public/logo.png"
                    
                      alt="Logo"
                    />
                  }
                  title={`Pedido #${order.id}`}
                  subheader={new Date(order.orderDate).toLocaleString()}
                />
                <Divider />
                <CardContent>
                  <Typography variant="body1">
                    <strong>Cliente:</strong> {order.user.name}
                  </Typography>
                  <Typography variant="body2" color="text.secondary">
                    <strong>Email:</strong> {order.user.email}
                  </Typography>
                  <Typography variant="subtitle1" sx={{ mt: 1 }}>
                    <strong>Total:</strong> R$ {order.totalAmount.toFixed(2)}
                  </Typography>
                </CardContent>

                <CardActions disableSpacing>
                  <Typography variant="body2">Ver itens</Typography>
                  <ExpandIcon
                    expand={expandedId === order.id}
                    onClick={() => handleExpandClick(order.id)}
                    aria-expanded={expandedId === order.id}
                    aria-label="show more"
                  >
                    <ExpandMoreIcon />
                  </ExpandIcon>
                </CardActions>

                <Collapse in={expandedId === order.id} timeout="auto" unmountOnExit>
                  <CardContent>
                    <List>
                      {order.items.map((it, idx) => (
                        <ListItem key={idx} divider>
                          <ListItemText
                            primary={it.productName}
                            secondary={`#${it.productId} — Qtd: ${it.quantity}`}
                          />
                        </ListItem>
                      ))}
                    </List>
                  </CardContent>
                </Collapse>
                {/* Botão para reportar problema */}
                <CardActions sx={{ justifyContent: 'flex-end', pb: 2 }}>  
                  <Button 
                    size="small" 
                    color="error" 
                    onClick={() => alert(`Reportar problema no pedido #${order.id}`)}
                  >
                    Reportar Problema
                  </Button>
                </CardActions>
              </Card>
            ))
          )}
        </Box>
      )}
    </Box>
  );
}
