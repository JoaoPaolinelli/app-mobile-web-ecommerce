import Slider from 'react-slick';

import 'slick-carousel/slick/slick.css';
import 'slick-carousel/slick/slick-theme.css';
import banner1 from '../assets/banner02.jpeg';
import banner2 from '../assets/banner04.jpeg';
import banner3 from '../assets/banner05.jpg';
import banner4 from '../assets/banner06.jpeg';
import banner5 from '../assets/banner05.jpg';
import banner6 from '../assets/banner06.jpeg';
import banner7 from '../assets/banner07.jpg';
import banner9 from '../assets/banner09.jpeg';




import { Box } from '@mui/material';



const mockImages = [banner1, banner2, banner3, banner4, banner5, banner6, banner7, banner9];




export default function Carousel() {
  const settings = {
    dots: true,
    infinite: true,
    speed: 500,
    autoplay: true,
    autoplaySpeed: 3000,
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: true,
  };

  return (
    <Box sx={{ width: '100%', maxWidth: 400,height: 300, mx: 'auto', mt: 4 }}>
      <Slider {...settings}>
        {mockImages.map((url, index) => (
          <Box key={index} component="img" src={url} sx={{ width: '100%',height: '100%', objectFit: 'cover', borderRadius: 2 }} />
        ))}
      </Slider>
    </Box>
  );
}
