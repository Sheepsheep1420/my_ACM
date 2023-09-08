## [ABC156F] Modularness

#### 题意：

有一个长度为 $k$ 的序列 $d_0,d_1,\ldots,d_{k-1}$。

有 $q$ 组询问，每组询问给出三个数 $n,x, m$， 同时定义长度为 $n$ 的序列$a_0,a_1,\ldots,a_{n-1}$，其中：

$$
a_j=
\begin{cases}
x& j=0 \\
a_{j-1}+d_{(j-1)\mod k}&0<j\leq n-1
\end{cases}
$$

对于每组询问，请回答有多少个 $j$ 满足 $0\leq j< n-1$ 且 $(a_j\mod m)<(a_{j+1}\mod m)$。

数据范围：$1\leq k,q\leq 5000,0\leq d_i,x\leq 10^9,2\leq n,m\leq 10^9$,所有的数均为整数。
