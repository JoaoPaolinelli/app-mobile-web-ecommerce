import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Home from './pages/Home';
import NavBar from './components/NavBar';
import { CartProvider } from './store/CartContext';
import CheckoutPage from './pages/CheckoutPage';
import BagPage from './pages/BagPage';

export default function App() {
  return (
    <CartProvider>
    <BrowserRouter>
      <NavBar />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/pagamento" element={<CheckoutPage />} />
        <Route path="/orders" element={<BagPage />} />
      </Routes>
    </BrowserRouter>  
    </CartProvider>
  );
}
