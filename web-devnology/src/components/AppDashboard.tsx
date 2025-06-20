// src/components/AppDashboard.tsx

import React, { useState } from 'react';
import {
  Box,
  Tabs,
  Tab,
  AppBar,
  Toolbar,
  Typography
} from '@mui/material';
import HomeIcon from '@mui/icons-material/Home';
import ShoppingBagIcon from '@mui/icons-material/ShoppingBag';
import PersonIcon from '@mui/icons-material/Person';
import SearchIcon from '@mui/icons-material/Search';
import GridViewIcon from '@mui/icons-material/GridView';

import Home from '../pages/Home';
import CategoriesPage from '../pages/CategoryPage';
import SearchPage from '../pages/SearchPage';
import ProfilePage from '../pages/ProfilePage';
import BagPage from '../pages/BagPage';
import CheckoutPage from '../pages/CheckoutPage';
// import SearchPage from '../pages/SearchPage'; // implementar futuramente
// import ProfilePage from '../pages/ProfilePage';
// import OrdersPage from '../pages/OrdersPage';

export default function AppDashboard() {
  const [tabIndex, setTabIndex] = useState(0);

  const renderContent = () => {
    switch (tabIndex) {
      case 0:
        return <Home />;
      case 1:
        return <CategoriesPage />;
      case 2:
        return <SearchPage/>
        // return <SearchPage />;
        // return <Typography>Pesquisa (em breve)</Typography>;
      case 3:
        // return <ProfilePage />;
        return <ProfilePage/>
      case 4:
        // return <OrdersPage />;
        return <CheckoutPage></CheckoutPage>
      default:
        return null;
    }
  };

  return (
    <Box sx={{ height: '100vh', display: 'flex', flexDirection: 'column' }}>
      {/* Navegação superior */}
      <AppBar position="static" color="default" elevation={1}>
        <Toolbar variant="dense" sx={{ justifyContent: 'space-between' }}>
          <Typography variant="h6">Minha Loja</Typography>
          <Tabs
            value={tabIndex}
            onChange={(_, val) => setTabIndex(val)}
            textColor="primary"
            indicatorColor="primary"
          >
            <Tab icon={<HomeIcon />} label="Loja" />
            <Tab icon={<GridViewIcon />} label="Categorias" />
            <Tab icon={<SearchIcon />} label="Pesquisa" />
            <Tab icon={<PersonIcon />} label="Perfil" />
            <Tab icon={<ShoppingBagIcon />} label="Sacola" />
          </Tabs>
        </Toolbar>
      </AppBar>

      {/* Conteúdo da aba */}
      <Box sx={{ flexGrow: 1, overflowY: 'auto', p: 3 }}>
        {renderContent()}
      </Box>
    </Box>
  );
}
