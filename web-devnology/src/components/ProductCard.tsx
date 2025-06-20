import React from 'react';
import {
  Card,
  CardMedia,
  CardContent,
  CardActions,
  Typography,
  IconButton,
  Button,
  Box
} from '@mui/material';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faPlus, faMinus } from '@fortawesome/free-solid-svg-icons';

export interface ProductCardProps {
  imageUrl: string;
  title: string;
  subtitle?: string;
  price: string;          // ex: 'R$ 49,99'
  quantity: number;       // quantidade atual no carrinho
  onAdd: () => void;      // adiciona 1 (se quantity===0)
  onIncrement: () => void;// +1
  onDecrement: () => void;// -1
}

export default function ProductCard({
  imageUrl,
  title,
  subtitle,
  price,
  quantity,
  onAdd,
  onIncrement,
  onDecrement,
}: ProductCardProps) {
  return (
    <Card
      sx={{
        width: 140,
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        boxShadow: 1,
        borderRadius: 2,
        overflow: 'visible'
      }}
    >
      <CardMedia
        component="img"
        image={imageUrl}
        alt={title}
        sx={{
          width: 140,
          height: 100,
          objectFit: 'cover',
          borderRadius: '8px 8px 0 0'
        }}
      />

      <CardContent sx={{ p: 1, textAlign: 'center' }}>
        <Typography variant="subtitle2" noWrap>
          {title}
        </Typography>
        {subtitle && (
          <Typography variant="caption" color="text.secondary" noWrap>
            {subtitle}
          </Typography>
        )}
      </CardContent>

      <Box sx={{ px: 1, flexGrow: 1, width: '100%' }}>
        <Typography variant="body2" fontWeight={600}>
          {price}
        </Typography>
      </Box>

      <CardActions sx={{ justifyContent: 'center', pb: 1, width: '100%' }}>
        {quantity > 0 ? (
          <Box sx={{ display: 'flex', alignItems: 'center', width: '100%', justifyContent: 'space-around' }}>
            <IconButton onClick={onDecrement} size="small">
              <FontAwesomeIcon icon={faMinus} />
            </IconButton>
            <Typography>{quantity}</Typography>
            <IconButton onClick={onIncrement} size="small">
              <FontAwesomeIcon icon={faPlus} />
            </IconButton>
          </Box>
        ) : (
          <Button
            fullWidth
            variant="contained"
            onClick={onAdd}
            sx={{ textTransform: 'none' }}
          >
            Adicionar
          </Button>
        )}
      </CardActions>
    </Card>
  );
}
