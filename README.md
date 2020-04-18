# Statistical Data Analysis (example) using R
A short script in R to perform data mining in a dataset (Housing.csv), perform visualizations and build a linear regression model. 

Steps to follow before running the script:
1. Download R https://cran.r-project.org/bin/windows/
2. Download RStudio https://rstudio.com/products/rstudio/download/
3. Open RStudio
4. File/Open File choose the script file. 
   Note: Here you may want to change the dataset path used in the beginning. 
5. Install the following packages 
  -dplyr
  -ggplot2
  -caTools
6. Run the script


![Rplot](https://user-images.githubusercontent.com/28048969/77810937-7562c000-7097-11ea-87f1-b687dcd7de19.png)

![stars](https://user-images.githubusercontent.com/28048969/77862051-4e33fc00-7219-11ea-95e7-7026b03606cf.PNG)


   ggplot(compare_result, aes(x=actual, y=predicted))+geom_point(col="purple") + geom_smooth(method="lm", se = T)

![Rplot](https://user-images.githubusercontent.com/28048969/77863748-bfc57780-7224-11ea-9bf9-0aeb78e9a6ab.png)
