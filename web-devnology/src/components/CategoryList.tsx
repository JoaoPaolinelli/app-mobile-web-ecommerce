import { useEffect, useRef, useState } from 'react';
import { Box, Typography, IconButton } from '@mui/material';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import {
  faStar, faGem, faToolbox, faLeaf, faBolt, faCube, faHandSparkles, faHeart, faCertificate, faTree,
  faQuestion, faUser, faBrain, faRocket, faThumbsUp, faUtensils, faScrewdriverWrench, faShirt, faCrown,
  faTv, faPaintbrush, faRecycle, faDiamond, faMobileScreenButton, faAppleWhole,
  faChevronLeft, faChevronRight
} from '@fortawesome/free-solid-svg-icons';
import axios from 'axios';

interface Category {
  name?: string;
  category?: string;
  count: number;
}

export default function CategoryList() {
  const [categories, setCategories] = useState<Category[]>([]);
  const scrollRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    axios.get<Category[]>('http://localhost:3000/categories/combined/counts')
      .then(res => setCategories(res.data))
      .catch(err => console.error(err));
  }, []);

  function normalizeCategoryName(name: string | undefined | null): string {
    if (!name) return '';
    return name
      .trim()
      .toLowerCase()
      .normalize('NFD')
      .replace(/[\u0300-\u036f]/g, '')  // remove acentos
      .replace(/ç/g, 'c');
  }

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

  const scroll = (dir: 'left' | 'right') => {
    if (!scrollRef.current) return;
    scrollRef.current.scrollBy({ left: dir === 'left' ? -120 : 120, behavior: 'smooth' });
  };

  return (
    <Box sx={{ mt: 6, px: 4, position: 'relative' }}>
      <Typography variant="h5" fontWeight={600} mb={3}>
        Categorias
      </Typography>

      {/* Botão esquerda */}
      <IconButton
        onClick={() => scroll('left')}
        sx={{
          position: 'absolute',
          top: '50%',
          left: 0,
          transform: 'translateY(-50%)',
          backgroundColor: 'rgba(255,255,255,0.8)',
          '&:hover': { backgroundColor: 'rgba(255,255,255,1)' },
          zIndex: 1
        }}
      >
        <FontAwesomeIcon icon={faChevronLeft} />
      </IconButton>

      {/* Lista sem scrollbar visível */}
      <Box
        ref={scrollRef}
        sx={{
          display: 'flex',
          overflowX: 'auto',
          gap: 2,
          py: 1,
          px: 3,
          '&::-webkit-scrollbar': { display: 'none' },
          scrollbarWidth: 'none'
        }}
      >
        {categories.map((cat, idx) => {
          const raw = cat.name ?? cat.category ?? '';
          const normalized = normalizeCategoryName(raw);
          const icon = iconMap[normalized] || faQuestion;
          const displayName = raw || 'Sem nome';

          return (
            <Box
              key={idx}
              sx={{
                flex: '0 0 auto',
                textAlign: 'center',
                width: 80,
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                gap: 1,
              }}
            >
              <Box
                sx={{
                  width: 60,
                  height: 60,
                  borderRadius: '50%',
                  backgroundColor: '#f5f5f5',
                  display: 'flex',
                  justifyContent: 'center',
                  alignItems: 'center',
                }}
              >
                <FontAwesomeIcon icon={icon} size="lg" />
              </Box>
              <Typography variant="caption" sx={{ whiteSpace: 'nowrap' }}>
                {displayName}
              </Typography>
            </Box>
          );
        })}
      </Box>

      {/* Botão direita */}
      <IconButton
        onClick={() => scroll('right')}
        sx={{
          position: 'absolute',
          top: '50%',
          right: 0,
          transform: 'translateY(-50%)',
          backgroundColor: 'rgba(255,255,255,0.8)',
          '&:hover': { backgroundColor: 'rgba(255,255,255,1)' },
          zIndex: 1
        }}
      >
        <FontAwesomeIcon icon={faChevronRight} />
      </IconButton>
    </Box>
  );
}
