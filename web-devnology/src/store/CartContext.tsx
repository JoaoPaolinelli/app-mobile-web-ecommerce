import React, { createContext, useContext, useReducer, useEffect } from 'react';
import type { ReactNode } from 'react';

export interface CartItem {
  productId: number;
  quantity: number;
}

type State = CartItem[];

type Action =
  | { type: 'initialize'; payload: State }
  | { type: 'add'; payload: { productId: number } }
  | { type: 'increment'; payload: { productId: number } }
  | { type: 'decrement'; payload: { productId: number } }
  | { type: 'clear' };

const CartContext = createContext<{
  state: State;
  add: (productId: number) => void;
  increment: (productId: number) => void;
  decrement: (productId: number) => void;
  clear: () => void;
}>({
  state: [],
  add: () => {},
  increment: () => {},
  decrement: () => {},
  clear: () => {},
});

function cartReducer(state: State, action: Action): State {
  switch (action.type) {
    case 'initialize':
      return action.payload;
    case 'add': {
      const exists = state.find(i => i.productId === action.payload.productId);
      if (exists) return state;
      return [...state, { productId: action.payload.productId, quantity: 1 }];
    }
    case 'increment':
      return state.map(i =>
        i.productId === action.payload.productId
          ? { ...i, quantity: i.quantity + 1 }
          : i
      );
    case 'decrement':
      return state
        .map(i =>
          i.productId === action.payload.productId
            ? { ...i, quantity: i.quantity - 1 }
            : i
        )
        .filter(i => i.quantity > 0);
    case 'clear':
      return [];
    default:
      return state;
  }
}

export const CartProvider = ({ children }: { children: ReactNode }) => {
  const [state, dispatch] = useReducer(cartReducer, []);

  // Inicializa do localStorage
  useEffect(() => {
    const saved = localStorage.getItem('cart');
    if (saved) {
      try {
        const parsed: State = JSON.parse(saved);
        dispatch({ type: 'initialize', payload: parsed });
      } catch {}
    }
  }, []);

  // Persiste no localStorage
  useEffect(() => {
    localStorage.setItem('cart', JSON.stringify(state));
  }, [state]);

  const add = (productId: number) =>
    dispatch({ type: 'add', payload: { productId } });
  const increment = (productId: number) =>
    dispatch({ type: 'increment', payload: { productId } });
  const decrement = (productId: number) =>
    dispatch({ type: 'decrement', payload: { productId } });
  const clear = () => dispatch({ type: 'clear' });

  return (
    <CartContext.Provider value={{ state, add, increment, decrement, clear }}>
      {children}
    </CartContext.Provider>
  );
};

export const useCart = () => useContext(CartContext);
