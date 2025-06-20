import { AppBar, Toolbar, Box, TextField, InputAdornment, Button, IconButton } from '@mui/material';
import SearchIcon from '@mui/icons-material/Search';
import LocationOnIcon from '@mui/icons-material/LocationOn';
import LocalShippingIcon from '@mui/icons-material/LocalShipping';
import ShoppingBagIcon from '@mui/icons-material/ShoppingBag';
import { Link } from 'react-router-dom';

export default function NavBar() {
  return (
    <AppBar
      position="static"
      elevation={0}
      sx={{
        backgroundColor: '#FFFFFF',
        border: '1px solid rgba(0, 0, 0, 0.5)',
        boxShadow: '0px 4px 4px rgba(0, 0, 0, 0.25)',
        overflow: 'hidden',
      }}
    >
      <Toolbar
        sx={{
          height: 90,
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'center',
          px: 3,
        }}
      >
        {/* Lado esquerdo: logo + pesquisa + endereço */}
        <Box display="flex" alignItems="center" gap={2} sx={{ flexGrow: 1 }}>
          {/* Logo + texto */}
          <Box display="flex" alignItems="center" gap={1}>
            <img
              src="/logo.png"
              alt="Logo"
              style={{ height: 60, objectFit: 'contain' }}
            />
           
          </Box>

          {/* Campo de busca */}
          <TextField
            placeholder="BUSCAR PRODUTOS"
            variant="outlined"
            size="small"
            InputProps={{
              startAdornment: (
                <InputAdornment position="start">
                  <SearchIcon />
                </InputAdornment>
              ),
              sx: {
                height: 45,
                backgroundColor: 'rgba(217, 217, 217, 0.5)',
                borderRadius: '10px',
              },
            }}
            sx={{ width: 500 }}
          />

          {/* Adicionar endereço */}
          <Button
            variant="outlined"
            startIcon={<LocationOnIcon />}
            sx={{
              width: 423,
              height: 30,
              backgroundColor: 'rgba(217, 217, 217, 0.5)',
              border: '1px solid rgba(0, 0, 0, 1)',
              borderRadius: 5,
              textTransform: 'none',
              fontSize: 13,
              color: 'black',
            }}
          >
            Adicionar Endereço
          </Button>
        </Box>

        {/* Lado direito: entrega + sacola */}
        <Box display="flex" alignItems="center" gap={2}>
          <Button
            variant="contained"
            startIcon={<LocalShippingIcon />}
            sx={{
              width: 290,
              height: 45,
              backgroundColor: '#0828C9',
              color: 'white',
              border: '1px solid #000000',
              borderRadius: 5,
              textTransform: 'none',
              fontSize: 13,
              '&:hover': {
                backgroundColor: '#001b8d',
              },
            }}
          >
            Entrega rápida de 10 ~ 15min
          </Button>

          <IconButton
            sx={{
              width: 55,
              height: 45,
              backgroundColor: '#0827C9',
              border: '1px solid #000000',
              borderRadius: 5,
              color: 'white',
              '&:hover': {
                backgroundColor: '#001b8d',
              },
            }}
          >
            <ShoppingBagIcon />
          </IconButton>
        </Box>
      </Toolbar>
    </AppBar>
  );
}
