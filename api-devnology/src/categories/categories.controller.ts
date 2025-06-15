import { Controller, Get } from '@nestjs/common';
import { CategoriesService, CategoryCount } from './categories.service';

@Controller('categories')
export class CategoriesController {
  constructor(private readonly categoriesService: CategoriesService) {}

  @Get('brazilian')
  getBrazilian() {
    return this.categoriesService.getBrazilianCategories();
  }

  @Get('european')
  getEuropean() {
    return this.categoriesService.getEuropeanCategories();
  }

   @Get('brazilian/counts')       // novo endpoint
  getBrazilianCounts(): Promise<CategoryCount[]> {
    return this.categoriesService.getBrazilianCategoryCounts();
  }

  @Get('european/counts')        // novo endpoint
  getEuropeanCounts(): Promise<CategoryCount[]> {
    return this.categoriesService.getEuropeanCategoryCounts();
  }

  @Get('combined/counts')
  getCombinedCounts(): Promise<CategoryCount[]> {
    return this.categoriesService.getCombinedCategoryCounts();
  }
}
