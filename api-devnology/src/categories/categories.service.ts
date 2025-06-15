import { Injectable } from '@nestjs/common';
import { BrazilianService } from '../products/brazilian/brazilian.service';
import { EuropeanService } from '../products/european/european.service';

export interface CategoryCount {
  category: string;
  count: number;
}

@Injectable()
export class CategoriesService {
  constructor(
    private readonly brazilianService: BrazilianService,
    private readonly europeanService: EuropeanService,
  ) {}

  

  async getBrazilianCategories(): Promise<string[]> {
    const products = await this.brazilianService.findAll();
    const set = new Set(products.map(p => p.category.trim()).filter(c => !!c));
    return Array.from(set);
  }

  async getEuropeanCategories(): Promise<string[]> {
    const products = await this.europeanService.findAll();
    const set = new Set(products.map(p => p.category.trim()).filter(c => !!c));
    return Array.from(set);
  }

  private tallyCounts(products: { category: string }[]): CategoryCount[] {
    const counts = products.reduce<Record<string, number>>((acc, p) => {
      const cat = p.category.trim() || 'Uncategorized';
      acc[cat] = (acc[cat] || 0) + 1;
      return acc;
    }, {});
    return Object.entries(counts).map(([category, count]) => ({ category, count }));
  }
   async getBrazilianCategoryCounts(): Promise<CategoryCount[]> {
    const products = await this.brazilianService.findAll();
    return this.tallyCounts(products);
  }

  async getEuropeanCategoryCounts(): Promise<CategoryCount[]> {
    const products = await this.europeanService.findAll();
    return this.tallyCounts(products);
  }

  async getCombinedCategoryCounts(): Promise<CategoryCount[]> {
    const [brCounts, euCounts] = await Promise.all([
      this.getBrazilianCategoryCounts(),
      this.getEuropeanCategoryCounts(),
    ]);

    const map: Record<string, number> = {};

    brCounts.forEach(({ category, count }) => {
      map[category] = (map[category] || 0) + count;
    });
    euCounts.forEach(({ category, count }) => {
      map[category] = (map[category] || 0) + count;
    });

    return Object.entries(map).map(([category, count]) => ({ category, count }));
  }
}
