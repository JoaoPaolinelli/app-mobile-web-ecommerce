import React from 'react';
import ReactDOM from 'react-dom/client';
import AppDashboard from './components/AppDashboard';
import { CartProvider } from './store/CartContext';
import { BrowserRouter } from 'react-router-dom';

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <BrowserRouter>
      <CartProvider>
        <AppDashboard />
      </CartProvider>
    </BrowserRouter>
  </React.StrictMode>
);
