![Alt text](https://cloud.githubusercontent.com/assets/10431659/6080288/bde5fc80-ae4a-11e4-9a25-ac1f7aea7504.jpg)
  

1.檔案 HOG.m 是沒有block的HOG，特徵維度固定皆為81維

2.檔案 hog_feature_vector.m是有block的HOG，相對的他的特徵維度取決於圖片大小

以上兩者都是可以run的HOG，要注意的是

	a. hy = [-1,0,1];  hx = hy'; 不是一般code的  hy = [-1,0,1]; hx = -hy';

	b. normalize是針對每一個block做normalization


3.檔案hogcalculator.m 感覺起來更猛，他有用trilinear interpolation，但是看起來還有一些部分有問題，

  還沒有run過，相關的解釋如下，

  a. http://hi.baidu.com/nokltkmtsfbnsyq/item/e1328f39b3abedb0623aff52

  b. http://hi.baidu.com/nokltkmtsfbnsyq/item/6103f8b1fe9ed0e34ec7fd52
  
  上面b的網址中間有八行式子，有遺漏，可以去找相關的論文補齊。



