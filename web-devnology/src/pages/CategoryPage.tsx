// src/pages/CategoriesPage.tsx

import React, { useEffect, useState } from 'react';
import axios from 'axios';
import {
  Box,
  Typography,
  Card,
  CardContent,
  useTheme,
  IconButton
} from '@mui/material';
import {
  faStar, faGem, faToolbox, faLeaf, faBolt, faCube,
  faHandSparkles, faHeart, faCertificate, faTree,
  faQuestion, faUser, faBrain, faRocket, faThumbsUp,
  faUtensils, faScrewdriverWrench, faShirt, faCrown,
  faTv, faPaintbrush, faRecycle, faDiamond,
  faMobileScreenButton, faAppleWhole
} from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

interface Category {
  name?: string;
  category?: string;
  count: number;
}

export default function CategoriesPage() {
  const theme = useTheme();
  const [categories, setCategories] = useState<Category[]>([]);

  useEffect(() => {
    axios
      .get<Category[]>('http://localhost:3000/categories/combined/counts')
      .then(res => setCategories(res.data))
      .catch(console.error);
  }, []);

  const normalize = (s?: string) =>
    s
      ? s.trim().toLowerCase().normalize('NFD').replace(/[̀-\u036f]/g, '').replace(/ç/g,'c')
      : '';

  const iconMap: Record<string, any> = {
    fantastic: faStar,
    refined: faGem,
    practical: faToolbox,
    small: faLeaf,
    sleek: faBolt,
    generic: faCube,
    handmade: faHandSparkles,
    gorgeous: faHeart,
    licensed: faCertificate,
    rustic: faTree,
    unbranded: faQuestion,
    ergonomic: faUser,
    intelligent: faBrain,
    incredible: faRocket,
    awesome: faThumbsUp,
    tasty: faUtensils,
    handcrafted: faScrewdriverWrench,
    roupas: faShirt,
    elegant: faCrown,
    oriental: faAppleWhole,
    electronic: faTv,
    bespoke: faPaintbrush,
    recycled: faRecycle,
    luxurious: faDiamond,
    modern: faMobileScreenButton,
    fresh: faAppleWhole,
  };

  return (
    <Box sx={{ p: 3 }}>
      <Typography variant="h5" fontWeight={600} mb={2}>
        Categorias
      </Typography>

      {/* Grid responsivo */}
      <Box
        sx={{
          display: 'grid',
          gap: 2,
          gridTemplateColumns: {
            xs: 'repeat(1, 1fr)',
            sm: 'repeat(2, 1fr)',
            md: 'repeat(3, 1fr)',
            lg: 'repeat(4, 1fr)',
            xl: 'repeat(5, 1fr)'
          }
        }}
      >
        {categories.map((cat, i) => {
          const raw = cat.name ?? cat.category ?? '';
          const key = normalize(raw);
          const icon = iconMap[key] || faQuestion;
          const label = raw || 'Sem nome';

          return (
            <Card
              key={i}
              sx={{
                backgroundColor: '#fff',
                boxShadow: 1,
                textAlign: 'center',
                p: 2,
                borderRadius: 2,
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center'
              }}
            >
              <IconButton
                disableRipple
                sx={{
                  bgcolor: '#E3F2FD',
                  '&:hover': { bgcolor: '#BBDEFB' },
                  mb: 1,
                  width: 56,
                  height: 56,
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  borderRadius: '50%'
                }}
              >
                <FontAwesomeIcon icon={icon} size="lg" color={theme.palette.primary.main} />
              </IconButton>
              <CardContent sx={{ p: 0 }}>
                <Typography variant="body2" noWrap>
                  {label}
                </Typography>
              </CardContent>
            </Card>
          );
        })}
      </Box>
    </Box>
  );
}
