import React, { useRef, useState, useEffect } from 'react';
import { Box, IconButton, Typography, Button } from '@mui/material';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import {
  faChevronLeft,
  faChevronRight,
  faPlus,
  faMinus,
} from '@fortawesome/free-solid-svg-icons';
import ProductCard from './ProductCard';
import { useCart, type CartItem } from '../store/CartContext';

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
}

interface Props {
  products: Product[];
}

export default function ProductCarousel({ products }: Props) {
  const containerRef = useRef<HTMLDivElement>(null);
  const [activeIdx, setActiveIdx] = useState(0);
  const [visibleSet, setVisibleSet] = useState<Set<number>>(new Set());
  const [imageMap, setImageMap] = useState<Record<number,string>>({});
  const { state: cartItems, add, increment, decrement } = useCart();

  // Sorteia uma imagem para cada produto
  useEffect(() => {
    const map: Record<number,string> = {};
    products.forEach(p => {
      map[p.id] = imageNames[Math.floor(Math.random() * imageNames.length)];
    });
    setImageMap(map);
  }, [products]);

  // IntersectionObserver para foco/blur
  useEffect(() => {
    const el = containerRef.current;
    if (!el) return;
    const cards = Array.from(el.children) as HTMLElement[];
    const obs = new IntersectionObserver(
      entries => {
        const newVis = new Set<number>(visibleSet);
        entries.forEach(e => {
          const idx = cards.indexOf(e.target as HTMLElement);
          if (e.intersectionRatio >= 0.6) newVis.add(idx);
          else newVis.delete(idx);
        });
        setVisibleSet(newVis);
        const best = entries
          .filter(e => e.isIntersecting)
          .sort((a,b) => b.intersectionRatio - a.intersectionRatio)[0];
        if (best) setActiveIdx(cards.indexOf(best.target as HTMLElement));
      },
      { root: el, threshold: [0.6,1] }
    );
    cards.forEach(c => obs.observe(c));
    return () => obs.disconnect();
  }, [products, visibleSet]);

  const scroll = (dir: 'left'|'right') => {
    const el = containerRef.current;
    if (!el) return;
    const w = el.children[0]?.clientWidth ?? 140;
    el.scrollBy({ left: dir==='left' ? -(w+16) : w+16, behavior:'smooth' });
  };

  return (
    <Box sx={{ position:'relative', py:2 }}>
      {activeIdx>0 && (
        <IconButton
          onClick={()=>scroll('left')}
          sx={{
            position:'absolute', top:'50%', left:0,
            transform:'translate(-50%,-50%)',
            bgcolor:'rgba(255,255,255,0.8)',
            '&:hover':{bgcolor:'rgba(255,255,255,1)'},
            zIndex:2
          }}
        >
          <FontAwesomeIcon icon={faChevronLeft} />
        </IconButton>
      )}

      <Box
        ref={containerRef}
        sx={{
          display:'flex',
          flexWrap:'nowrap',
          overflowX:'auto',
          gap:2,
          px:4,
          scrollSnapType:'x mandatory',
          '&::-webkit-scrollbar':{display:'none'},
          scrollbarWidth:'none'
        }}
      >
        {products.map((p, idx) => {
          const src = `/assets/images/${imageMap[p.id]}`;
          const isVisible = visibleSet.has(idx);
          const item = cartItems.find((i:CartItem)=>i.productId===p.id);
          const qty = item?.quantity ?? 0;

          return (
            <Box
              key={`${p.id}-${idx}`}
              sx={{
                flex:'0 0 140px',
                maxHeight:230,
                scrollSnapAlign:'center',
                overflow:'hidden',
                transition:'filter 0.3s',
                filter:isVisible?'none':'blur(4px)'
              }}
            >
              <ProductCard
                imageUrl={src}
                title={p.name}
                subtitle={`Tamanho ${p.size}`}
                price={`R$ ${p.price.toFixed(2)}`}
                quantity={qty}
                onAdd={() => add(p.id)}
                onIncrement={() => increment(p.id)}
                onDecrement={() => decrement(p.id)}
              />
            </Box>
          );
        })}
      </Box>

      {activeIdx < products.length-1 && (
        <IconButton
          onClick={()=>scroll('right')}
          sx={{
            position:'absolute', top:'50%', right:0,
            transform:'translate(50%,-50%)',
            bgcolor:'rgba(255,255,255,0.8)',
            '&:hover':{bgcolor:'rgba(255,255,255,1)'},
            zIndex:2
          }}
        >
          <FontAwesomeIcon icon={faChevronRight}/>
        </IconButton>
      )}
    </Box>
  );
}
