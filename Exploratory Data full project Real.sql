-- EXPLORATORY DATA ANALYSIS


SELECT *
FROM layoffs_staging2;


SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;


SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

 

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company 
ORDER BY 2 DESC; 


SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;
 

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;




SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;


SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;



SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

SELECT company, SUM(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;



SELECT *
FROM layoffs_staging2;

SELECT substring(`date`, 6, 2) AS `MONTH`, 
SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `MONTH`;




SELECT substring(`date`, 1, 7) AS `MONTH`, 
SUM(total_laid_off)
FROM layoffs_staging2
WHERE substring(`date`, 1, 7) IS NOT NULL 
GROUP BY `MONTH`
ORDER BY 1 ASC;




WITH rolling_total AS 
(
SELECT substring(`date`, 1, 7) AS `MONTH`, 
SUM(total_laid_off) AS total_off 
FROM layoffs_staging2
WHERE substring(`date`, 1, 7) IS NOT NULL 
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, total_off,
SUM(total_off) OVER(ORDER BY `MONTH`) AS Rolling_total 
FROM rolling_total;




SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;



SELECT company, YEAR(`date`),  SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY company ASC; 



SELECT company, YEAR(`date`),  SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC; 



WITH Company_Year AS 
(
SELECT company, YEAR(`date`),  SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC
)
SELECT * 
FROM Company_Year;



WITH Company_Year (company, years, total_laid_off) AS 
(
SELECT company, YEAR(`date`),  SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC
)
SELECT * 
FROM Company_Year;



WITH Company_Year (company, years, total_laid_off) AS 
(
SELECT company, YEAR(`date`),  SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC
)
SELECT *, dense_rank() OVER (partition by years ORDER BY total_laid_off DESC) 
AS ranking 
FROM Company_Year
WHERE years IS NOT NULL
ORDER BY ranking ASC;



WITH Company_Year (company, years, total_laid_off) AS 
(
SELECT company, YEAR(`date`),  SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC
), Company_Year_Rank AS 
(
SELECT *, 
dense_rank() OVER (partition by years ORDER BY total_laid_off DESC) 
AS ranking 
FROM Company_Year
WHERE years IS NOT NULL
)
SELECT * 
FROM Company_Year_Rank
WHERE ranking <= 5;









































